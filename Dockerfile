FROM dhi.io/pytorch:2.11-cuda13.0-cudnn9-debian-dev
LABEL maintainer Felipe Gajardo <fgajardoe@gmail.com>

# Evitar la interacción durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Configurar la selección de la localización
RUN echo 'tzdata tzdata/Areas select America' | debconf-set-selections && \
    echo 'tzdata tzdata/Zones/America select Mexico_City' | debconf-set-selections

RUN apt-get update && apt-get install -y \
    curl \
    bash \
    build-essential \
    procps \
    coreutils \
    findutils \
    grep \
    sed \
    gawk \
    gzip \
    tar \
    && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --upgrade pip

RUN python -m pip install \
    rich==13.9.4 \
    scvi-tools==1.4.2 \
    scanpy==1.11.5 \
    scikit-misc

ENTRYPOINT ["/bin/bash"]