FROM continuumio/miniconda3

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# RUN conda create -n env python=3.6
# RUN echo "source activate env" > ~/.bashrc
# ENV PATH /opt/conda/envs/env/bin:$PATH

ADD pixel2style2pixel /app/pixel2style2pixel
WORKDIR /app/pixel2style2pixel

# OVERWITES / HACKS
ADD app /app

ADD psp_env.yaml /psp_env.yaml
RUN conda env create -f /psp_env.yaml

# Pull the environment name out of the environment.yml
RUN echo "source activate $(head -1 /psp_env.yaml | cut -d' ' -f2)" > ~/.bashrc
ENV PATH /opt/conda/envs/$(head -1 /psp_env.yaml | cut -d' ' -f2)/bin:$PATH