%
%  Description : 
%              read input data, remove seasonal cycle and apply 3-month running mean.
%              After this step, propogator is formed based on the trainning period. 
%              read NCEP monthly data
%              trainning period: 194801-199912
%              trainning period: dt is 7 months
%
% Users can modify time_start and time_end to determine the analysis period
% ................ ntao1 to determine the prediction time
% ................ nEOF to determine how many EOFs to use for prediction.
% ................ subdomain to determin the target domain
%                  
%  by Xue Liu
%  
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   clear
%---------------------------------------------------------------------------------------
  
   directory  =  '../data/NECP_monthly_Tropics/';              % data directory
   tauxfile   =  [directory,'uflx.sfc.mon.mean.tropics.nc'];   % taux file
   tauyfile   =  [directory,'vflx.sfc.mon.mean.tropics.nc'];   % tauy file
   sstfile    =  [directory,'skt.sfc.mon.mean.tropics.nc'];    % SST file
   gridfile   =  [directory,'lsmask.tropics.nc'];              % grid and landmask file

   time_start = 1;        % time=1: 194801 
   time_end   = 624;      % time=624: 199912
   ntao  = 7;
   ntao1 = 1;
   nEOF  = 10;
   subdomain  = [-30,30,0,360];   % target domain   
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

%------------------
% END of data input
%------------------

   nyear=ntime./12;
 
   % remove seasonal cycle
   sst=reshape(sst,[nlon,nlat,12,nyear]);
   sstmean=squeeze(nanmean(sst,4));
   sst=sst-repmat(sstmean,[1,1,1,nyear]);
 
   sst=reshape(sst,[nlon,nlat,ntime]);

   % 3-month running mean
   sst  = func_runmean(sst,1,3) ; 
   
    % mask out land
   mask1=repmat(mask,[1,1,ntime]);
   sst(mask1==-1)=0;

   % tranfer varibales into [space*time]
   sst=reshape(sst,[nlon*nlat,ntime]);   
%------------------
% END of data prepare
%------------------
   % EOF analysis based on matlab svd
   [E,PC,lmd,CF,SCF]=func_EOF_svd(sst,nEOF);

   disp(['the first ',num2str(nEOF),' EOFs explains ',num2str(SCF(nEOF)*100),'% of variance']);
   
   % check EOF mode
    sst_mode=reshape(E(:,1:nEOF),[nlon,nlat,nEOF]);
   
   % reconstruct into sst field: T
   T=E*PC;

   % set up linear model   Y(t+ntao)=exp(A*ntao)*X(t)+noise
   % derive the propagator: G function in EOF space using PCs: 
       
    
    




