# FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu18.04
# FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04
# FROM nvidia/cuda:12.0.0-cudnn8-devel-ubuntu22.04
# FROM nvidia/cuda:12.0.0-cudnn8-devel-ubuntu20.04
FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get upgrade -y

RUN apt-get install -y gcc
RUN apt-get install libstdc++6
RUN apt-get upgrade -y

RUN apt-get install -y vim git
RUN apt-get install -y libgl1-mesa-glx
RUN apt-get install -y libglib2.0-0 libsm6 libxrender1 libxext6
RUN apt-get install -y tmux
RUN apt-get install -y wget
RUN apt-get install -y htop

ENV PYTHONIOENCODING=UTF-8
# x86_64-linux-gnu
# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_22.11.1-1-Linux-x86_64.sh
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_23.5.2-0-Linux-x86_64.sh 

RUN mkdir /root/.conda
# RUN bash Miniconda3-py39_22.11.1-1-Linux-x86_64.sh -b
# RUN rm -f Miniconda3-py39_22.11.1-1-Linux-x86_64.sh
RUN bash Miniconda3-py39_23.5.2-0-Linux-x86_64.sh -b 
RUN rm -f Miniconda3-py39_23.5.2-0-Linux-x86_64.sh 
RUN conda init bash

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade setuptools==68.2.2
# RUN pip3 install torch==1.9.0+cu111 torchvision==0.10.0+cu111 -f https://download.pytorch.org/whl/torch_stable.html # Used to be this, and not the one below:
RUN pip3 install torch==2.2.2+cu121 torchvision==0.17.2+cu121 -f https://download.pytorch.org/whl/torch_stable.html

RUN conda update -n base conda
RUN conda install -n base conda-libmamba-solver
RUN conda config --set solver libmamba

RUN conda install -y -c numba numba==0.59.1
RUN conda install -y -c anaconda numpy==1.26.4
RUN conda install -y -c conda-forge h5py==2.10.0 blosc-hdf5-plugin==1.0.0 scikit-video==1.1.11 prettytable==2.1.0
RUN python3 -m pip install yacs==0.1.8 pytz==2021.1 tensorboard==2.14.0 tensorboard-data-server==0.7.2 opencv-python==4.5.2.54 einops==0.7.0 matplotlib scipy==1.8.1 protobuf==3.20.1

ARG DEBIAN_FRONTEND=teletype
