FROM ubuntu:20.04 as base

ENV DEBIAN_FRONTEND=noninteractive
ENV DBUS_SESSION_BUS_ADDRESS=unix:path=/var/run/dbus/system_bus_socket

COPY environment.yaml /droid/environment.yaml

WORKDIR /droid

RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get update && apt-get install build-essential software-properties-common -y \
    sudo \
    git \
    cmake \
    wget \
    graphviz \
    ffmpeg \
    unzip \
    libgl1-mesa-dev \
    libhdf5-dev \
    libfreetype6-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libavutil-dev \
    libfreeimage-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    /bin/bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh

ENV PATH=$PATH:/opt/conda/bin

RUN conda env create -f environment.yaml

SHELL ["conda", "run", "-n", "droidenv", "/bin/bash", "-c"]

ENV CONDA_DEFAULT_ENV=droidenv

RUN echo "conda activate droidenv" >> ~/.bashrc

RUN pip3 install gdown

RUN python3 setup.py install