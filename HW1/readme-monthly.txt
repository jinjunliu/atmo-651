
===============================================================================
OAFLUX MONTHLY DATA DESCRIPTION
===============================================================================

***** Last updated on JUL/29/2017 *****

The latent heat flux, sensible heat flux, evaporation, and flux related surface
meteorological variables have been updated to 06/30/2017.


October 2012

All the data has been reprocessed for the period from 01/01/2005 onward as the daily 
sea ice mask was updated.


October 2011

The shortwave and longwave radiations (ISCCP), as well as the net heat flux, are
updated to 2009-Dec-31.


October 2009

The latent heat flux, sensible heat flux, evaporation, and flux related surface 
meteorological variables have been updated to 12/31/2008. The surface radiation 
fluxes, which are taken from ISCCP, have been updated to 12/31/2007. In addition
to the extension of time-series, the analysis of air temperature has been 
reprocessed for the period from 09/01/2002 to 12/31/2006 as the ERA-interim was
used to replace the NCEP/NCAR Reanalysis after the end of ERA40 to prevent the 
Gibbs-like phenomena caused by the NCEP/NCAR Reanalysis product over ocean near
steep orography. The associated latent and sensible heat fluxes, as well as 
evaporation, have also been updated since 09/01/2002.



January 2008

The Objectively Analyzed Air-sea Fluxes (OAFlux) project at the Woods Hole 
Oceanographic Institution (WHOI) released in January 2008 a multidecade, global 
analysis for latent and sensible heat fluxes, ocean evaporation, and flux-related 
surface meteorological variables. Monthly, 1-degree gridded products are available 
online for the period 1958-2006, and daily gridded products are released for the 
satellite era 1985-2006. The data after 2006 will be updated in due course.
       
The OAFlux project is supported by the NOAA Office of Climate Observations (OCO). 
This is the third release of the OAFlux products (Yu et al. 2008). The first data 
release was made in March 2004 for air-sea fluxes in the Atlantic Ocean (1988-
1999) under the auspices of the NOAA CLIVAR-Atlantic program. The second release 
was for air-sea fluxes over the global oceans (1981-2002) supported by the NOAA 
Office of Climate Observations (OCO) and Climate Change and Data Detection (CCDD) 
programs. 


All data files are in netCDF format and are compressed. 

*** Please note ***
The flux and basic meteorological variables were saved by using "ncshort" format to 
minimize the size of the file. Land and missing values are 32766. All flux variables 
are multiplied by a factor of 10, surface meterological variables by 100, and 
evaporation by 10. 


The monthly directory contains four subdirectories:

(1) evaporation_1958-2006  
	The directory has monthly-mean ocean evaporation as well as monthly-mean 
error averaged over the daily estimates. The two sets of monthly estimates are 
grouped into one data file for each year. The yearly files are named as:   
evapr_oaflux_yyyy.nc.gz, where “yyyy” denotes the four-digit year. The unit is cm/year.

(2) turbulence_1958-2006
	The directory has monthly-mean global analysis of latent heat flux 
(lh_oaflux_yyyy.nc.gz, positive upward), sensible heat flux (sh_oaflux_yyyy_nc.gz, 
positive upward), the 10m neutral wind speed (ws_oaflux_yyyy.nc.gz), the 2m air 
humidity (qa_oaflux_yyyy.nc.gz), the 2m air temperature (ta_oaflux_yyyy.nc.gz), 
and sea surface temperature (ts_oaflux_yyyy.nc.gz). The yearly files for each 
variable include also the monthly-mean error estimates for the corresponding variable. 
Units: latent and sensible heat flux (W/m2)
       wind speed (m/s)
       specific humidity  (g/kg)
       air and sea-surface temperatures (degree-C)


(3) radiation_1983-2004
	The surface radiation data in this directory are taken from the 
International Satellite Cloud Climatology Project (ISCCP; Zhang et al. 2004). The 
ISCCP-FD data are kindly provided by Dr. William B. Rossow for distribution along 
with the OAFlux products. Please reference the ISCCP webpage 
http://isccp.giss.nasa.gov/projects/flux.html about the project and the full 
global dataset. 
	The ISCCP data hosted here include net longwave radiation 
(lw_isccp_yyyy.nc.gz, positive upward) and net shortwave radiation 
(sw_isccp_yyyy.nc.gz, positive downward) at the ocean surface. The data are 
available from 7/1/1983 to 12/31/2004 and came with no error analysis. The unit is W/m2.

Please note that the original net longwave and shortwave radiations from ISCCP 
have a three-hour resolution and are on 2.5-degree grid over the globe. We applied 
daily average and linearly interpolation to the ISCCP dataset to produce the same 
spatial and temporal resolution as the OAFlux product. The monthly-mean fields were 
averaged from the daily fields.

(4) netheat_1983-2004
	The daily net heat flux (qnet_yyyy.nc.gz, positive downward) results from 
combining the OAFlux latent and sensible heat fluxes with the ISCCP ocean-surface 
radiation. The net heat flux, qnet, is computed as: qnet = SW- LW - LH - SH.
The unit is W/m2.



References:

Yu, L., X. Jin, and R. A. Weller, 2008: Multidecade Global Flux Datasets from the 
Objectively Analyzed Air-sea Fluxes (OAFlux) Project: Latent and sensible heat 
fluxes, ocean evaporation, and related surface meteorological variables. Woods 
Hole Oceanographic Institution, OAFlux Project Technical Report. OA-2008-01, 64pp. 
Woods Hole. Massachusetts.

Yu, L., and R. A. Weller, 2007: Objectively Analyzed air-sea heat Fluxes (OAFlux) 
for the global oceans. Bull. Ameri. Meteor. Soc., 88, 527-539.

Yu, L., 2007. Global variations in oceanic evaporation (1958-2005): The role of 
the changing wind speed. J. Climate, 20(21), 5376-5390.

Zhang, Y-C., W.B. Rossow, A.A. Lacis, V. Oinas, and M.I. Mishchenko, 2004. 
Calculation of  radiative fluxes from the surface to top of atmosphere based on 
ISCCP and other global data sets: Refinements of the radiative transfer model and 
the input data. J. Geophys. Res., 109, D19105, doi:10.1029/2003JD004457.

Created: January 2008 
L. Yu


