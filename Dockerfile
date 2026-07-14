FROM dhi.io/pytorch:2.11-cuda13.0-cudnn9-debian-dev
LABEL maintainer Felipe Gajardo <fgajardoe@gmail.com>


# Evitar la interacción durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Configurar la selección de la localización
RUN echo 'tzdata tzdata/Areas select America' | debconf-set-selections && \
    echo 'tzdata tzdata/Zones/America select Mexico_City' | debconf-set-selections


# Install software.
RUN apt-get update && apt-get install -y curl

RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba && mv bin/micromamba /usr/bin/
RUN micromamba create -y -n scvi-tools -c conda-forge scikit-misc scvi-tools
RUN alias ll='ls -l'
RUN alias l='ls'
RUN alias xx='exit'

RUN eval "$(micromamba shell hook --shell bash)" && micromamba activate scvi-tools

CMD ["/bin/bash"]