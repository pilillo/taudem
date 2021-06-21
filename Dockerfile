
# based on https://github.com/WikiWatershed/docker-taudem/blob/develop/Dockerfile
ARG BASE_CONTAINER=python:3.6-slim
FROM ${BASE_CONTAINER}

ARG GDAL_VERSION=2.3.0
ARG OPEN_MPI_VERSION=1.8.1
ARG OPEN_MPI_SHORT_VERSION=${OPEN_MPI_VERSION%.*}
ARG TAUDEM_VERSION=5.3.8

ENV GDAL_VERSION=${GDAL_VERSION}
ENV OPEN_MPI_VERSION=${OPEN_MPI_VERSION}
ENV OPEN_MPI_SHORT_VERSION=${OPEN_MPI_SHORT_VERSION}
ENV TAUDEM_VERSION=${TAUDEM_VERSION}

RUN apt-get update \
    && apt-get install -y \ 
    wget \
    build-essential \
    g++ \
    gfortran

# install gdal
RUN wget -qO- http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz \
    | tar -xzC /usr/src \
    && cd /usr/src/gdal-${GDAL_VERSION} \
    && ./configure --with-python --with-spatialite \
    && make install

# install openmpi
RUN wget -qO- https://www.open-mpi.org/software/ompi/v${OPEN_MPI_SHORT_VERSION}/downloads/openmpi-${OPEN_MPI_VERSION}.tar.gz \
    | tar -xzC /usr/src \
    && cd /usr/src/openmpi-${OPEN_MPI_VERSION} \
    && ./configure \
    && make install \
    && ldconfig

# install taudem
RUN wget -qO- https://github.com/dtarb/TauDEM/archive/v${TAUDEM_VERSION}.tar.gz \
    | tar -xzC /usr/src \
    && rm -rf /usr/src/TauDEM-${TAUDEM_VERSION}/TestSuite \
    && cd /usr/src/TauDEM-${TAUDEM_VERSION}/src \
    && make
RUN ln -s /usr/src/TauDEM-${TAUDEM_VERSION} /opt/taudem
ENV PATH /opt/taudem:$PATH

RUN pip install --upgrade pip