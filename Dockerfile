
FROM jupyterhub/jupyterhub:latest

RUN apt-get -y update 
RUN apt-get -y upgrade
RUN apt-get -y update 
RUN apt-get -y install gcc g++ ninja-build python3-tk python3-dev python3-opencv wget zip ffmpeg python3.8-venv
RUN python3 -m pip install --upgrade pip
COPY requirements.txt /root/requirements.txt
RUN python3 -m pip install -r /root/requirements.txt
RUN python3 -m pip install torch==1.9.0+cu102 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchvision==0.10.0+cu102 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cu102/torch1.9/index.html
RUN python3 -m pip install --upgrade jupyterhub
COPY run.sh /root/run.sh
RUN chmod 777 /root/run.sh
RUN chmod +x /root/run.sh
WORKDIR /data
CMD ["sh", "-c", "/root/run.sh"]
