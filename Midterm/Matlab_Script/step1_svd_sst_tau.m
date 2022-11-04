%
%  Description : SVD analysis between wind stress and SST.
%                Using NCEP monthly data, from 194801 to 199912
%
%  OutPut: P, Q, PCsst, PCtau, Prec, Qrec 
%
%         %P,Q        :  SVD spatial mode for SST and wind stress respectively
%         %PCsst,PCtau:  time series for SVD mode.
%         %Prec,Qrec  :  renormalized P and Q
% 
%  by Xue Liu
%  
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   clear;
%---------------------------------------------------------------------------------------
  
   directory  =  '../NECP_monthly_mean_data/';              % data directory
   tauxfile   =  [directory,'uflx.sfc.mon.mean.tropics.nc'];   % taux file
   tauyfile   =  [directory,'vflx.sfc.mon.mean.tropics.nc'];   % tauy file
   sstfile    =  [directory,'skt.sfc.mon.mean.tropics.nc'];    % SST file
   gridfile   =  [directory,'lsmask.tropics.nc'];              % grid and landmask file

   time_start = 1;        % time=1: 194801 
   time_end   = 624;      % time=624: 199912

   subdomain  = [-30,30,100,-60+360];   % target domain   
%------------------
% END of user input
%------------------

   lon  = ncread(gridfile,'lon');
   lat  = ncread(gridfile,'lat');

   % target data boundaries 
   lat_start=min(find(lat>=subdomain(1)&lat<=subdomain(2)));
   lat_end=max(find(lat>=subdomain(1)&lat<=subdomain(2)));
   lon_start=min(find(lon>=subdomain(3)&lon<=subdomain(4)));
   lon_end=max(find(lon>=subdomain(3)&lon<=subdomain(4)));

  % determine dimension size
   ntime = time_end-time_start+1;   
   nlat  = lat_end-lat_start+1;
   nlon  = lon_end-lon_start+1;

  % load data
   lon  = lon(lon_start:lon_end);
   lat  = lat(lat_start:lat_end);
   mask = squeeze(ncread(gridfile,'lsmask',[lon_start,lat_start,1],[nlon,nlat,1])); 
   % read landmask data
   sst  = ncread(sstfile,'skt',[lon_start,lat_start,time_start],[nlon,nlat,ntime]);
   % skin temperature, unit:degC
   taux = ncread(tauxfile,'uflx',[lon_start,lat_start,time_start],[nlon,nlat,ntime]); 
   % u component of momentum flux, unit:N/m^2   
   tauy = ncread(tauyfile,'vflx',[lon_start,lat_start,time_start],[nlon,nlat,ntime]);                  % v component of momentum flux, unit:N/m^2 

%------------------
% END of data input
%------------------

   nyear=ntime./12;
 
   % remove seasonal cycle
   sst=reshape(sst,[nlon,nlat,12,nyear]);
   taux=reshape(taux,[nlon,nlat,12,nyear]);
   tauy=reshape(tauy,[nlon,nlat,12,nyear]);
    
%    sstmean=squeeze(nanmean(sst,4));
%    tauxmean=squeeze(nanmean(taux,4));
%    tauymean=squeeze(nanmean(tauy,4));

   sstmean=squeeze(mean(sst,4));
   tauxmean=squeeze(mean(taux,4));
   tauymean=squeeze(mean(tauy,4));
   
   sst=sst-repmat(sstmean,[1,1,1,nyear]);
   taux=taux-repmat(tauxmean,[1,1,1,nyear]);
   tauy=tauy-repmat(tauymean,[1,1,1,nyear]);
 
   sst=reshape(sst,[nlon,nlat,ntime]);
   taux=reshape(taux,[nlon,nlat,ntime]);
   tauy=reshape(tauy,[nlon,nlat,ntime]);

   % calculate standard deviation
   sigma_sst=std(sst(:));
   sigma_taux=std(taux(:));
   sigma_tauy=std(tauy(:));

   % normalize variables
   sst=sst./sigma_sst;
   taux=taux./sigma_taux;
   tauy=tauy./sigma_tauy;
     
   % mask out land
   mask1=repmat(mask,[1,1,ntime]);
   sst(mask1==-1)=0;
   taux(mask1==-1)=0;
   tauy(mask1==-1)=0;
 
   % concatenate taux tauy into one field
   tau=cat(2,taux,tauy);
  
   % tranfer varibales into [space*time]
   tau=reshape(tau,[nlon*2*nlat,ntime]);
   sst=reshape(sst,[nlon*nlat,ntime]);
 
%------------------
% END of data prepare
%------------------
      
   % SVD analysis
   % PCsst, PCtau : PC series
   % P,Q          : SVD modes for SST and Tau
   % SCF          : contribution
   % r_coor       : correlation between PCsst and PCtau
   [PCsst,PCtau,P,Q,thegma,SCF,r_coor]=func_SVDocean(sst,tau,6);
   
   % transfer variables into [nlon,nlat,pattern];
   sst_mode=reshape(P,[nlon,nlat,6]);
   tau_mode=reshape(Q,[nlon,2*nlat,6]);
   taux_mode=tau_mode(:,1:nlat,:);
   tauy_mode=tau_mode(:,nlat+1:2*nlat,:);
 
   % renormalized P and Q
   Prec=P.*sigma_sst;   
   Qrec(1:nlon*nlat,:)=Q(1:nlon*nlat,:).*sigma_taux;
   Qrec(nlon*nlat+1:2*nlon*nlat,:)=Q(nlon*nlat+1:2*nlon*nlat,:).*sigma_tauy;


