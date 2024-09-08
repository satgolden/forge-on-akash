FROM nvidia/cuda:12.2.0-base-ubuntu22.04
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y && apt install -y wget tzdata git python3.10-venv libgl1-mesa-dev libglib2.0-0 libsm6 libxrender1 libxext6 ffmpeg && apt-get clean && useradd -s /bin/bash -m  f>
RUN apt update && apt -y install -qq aria2
WORKDIR /
RUN git clone https://github.com/lllyasviel/stable-diffusion-webui-forge.git && chmod 777 -R stable-diffusion-webui-forge && chown -R fcb:fcb stable-diffusion-webui-forge
USER fcb
ENV COMMANDLINE_ARGS="--listen --port=9999 --enable-insecure-extension-access"
EXPOSE 9999
ENTRYPOINT ["bash", "/stable-diffusion-webui-forge/webui.sh"]
