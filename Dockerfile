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
RUN micromamba install -y -c conda-forge scikit-misc scvi-tools

#RUN pip install scikit-learn
#RUN pip install scvi-tools[cuda]

RUN apt-get install -y passwd

# Set user.
RUN useradd -ms /bin/bash user
USER user

# Include some aliases.
RUN alias ll='ls -l'
RUN alias l='ls'
RUN alias xx='exit'

WORKDIR /home/user

CMD ["/bin/bash"]