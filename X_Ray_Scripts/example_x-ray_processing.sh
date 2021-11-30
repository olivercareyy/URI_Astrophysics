#in the shell command terminal
#example
chandra_repro check_vf_pha=yes
dmcopy "acisf03111_repro_evt2.fits[energy=500:7000]" acisf03111_repro_evt2_energy_0.5-7000.fits 

#load the source in ds9 and put a circle region around the source with a radius of 1.25 arcseconds
#go to region and save region 

punlearn dmextract;
pset dmextract "acisf03111_repro_evt2_energy_0.5-7000.fits[exclude sky=region(ds9.reg)][bin time=::200]";
pset dmextract outfile = acisf03111_repro_evt2_energy_0.5-7000_lc_reduced.fits;

dmextract;

#starting a iPython enviroment

ipython

##inside of the iPython enviroment 

from lightcurves import *
lc_sigma_clip("acisf03111_repro_evt2_energy_0.5-7000_lc_reduced.fits",outfile='lc_cut.gti')

#make sure you grab the filtered exposure time from the iPython Enviroment
#we can exit the ipython enviroment

deflare "acisf03111_repro_evt2_energy_0.5-7000_lc_reduced.fits" outfile=acisf03111_repro_evt2_energy_0.5-7000_lc_reduced_split.fits method=sigma plot=yes

dmcopy "acisf03111_repro_evt2_energy_0.5-7000.fits[@lc_cut.gti]" acisf03111_repro_evt2_final.fits

#moving forward we want to use our fully reduced measurement set in this case acisf03111_repro_evt2_final.fits

#in ds9 we place another circle centered on the source and then go to Analysis -> CIAO Tools -> Count Rate and Fluxes -> Net Counts for Count Rate

#for flux, we need to draw an pandas that excludes any identified jet flux and define it to be background we then use  Analysis -> CIAO Tools -> Count Rate and Fluxes -> Photometry for flux

#we also want the spectral plot for each source - Analysis -> CIAO Tools -> Sherpa -> Spectral Fit - Grab the raw data not just the graph 
