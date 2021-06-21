# Taudem

Docker build of [GDAL](https://gdal.org/)+[OpenMPI](https://www.open-mpi.org/)+[Taudem](https://hydrology.usu.edu/taudem/taudem5/)

## Disclaimer

Based on this existing [Dockerfile](https://github.com/WikiWatershed/docker-taudem/blob/develop/Dockerfile).

## Info

To build, create a tag of kind `BASE#BASEVERSION#GDALVERSION_OPENMPIVERSION_TAUDEMVERSION`, such as `python#3.6-slim#2.3.0_1.8.1_5.3.8`.  
The image is built using github actions and pushed to dockerhub.