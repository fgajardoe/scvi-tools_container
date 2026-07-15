FROM dhi.io/pytorch:2.11-cuda13.0-cudnn9-debian-dev
LABEL maintainer Felipe Gajardo <fgajardoe@gmail.com>

# Evitar la interacción durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Configurar la selección de la localización
RUN echo 'tzdata tzdata/Areas select America' | debconf-set-selections && \
    echo 'tzdata tzdata/Zones/America select Mexico_City' | debconf-set-selections


# Install software.
RUN apt-get update && apt-get install -y curl \
    bash \
    procps \
    coreutils \
    findutils \
    grep \
    sed \
    gawk \
    gzip \
    tar

RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba && mv bin/micromamba /usr/bin/
ENV MAMBA_ROOT_PREFIX=/opt/micromamba
RUN micromamba create -y -n scvi-tools -c conda-forge scikit-misc scvi-tools

# Set up the environment.
ENV PATH="/opt/micromamba/envs/scvi-tools/bin:$PATH"
ENTRYPOINT ["/bin/bash"]