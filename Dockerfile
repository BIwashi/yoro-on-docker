# Ubuntu 18.04 and yolo v3
#  darknet: https://github.com/pjreddie/darknet

FROM ubuntu:18.04
# MAINTAINER biwashi

#  
# -- if you are using docker behind proxy, please set ENV --
#

#ENV http_proxy "http://proxy.yourdomain.com:8080/"
#ENV https_proxy "http://proxy.yourdomain.com:8080/"

ENV DEBIAN_FRONTEND nonineractive

# -- build step --
RUN apt-get update && apt-get upgrade -y

RUN apt-get install python3 -y
RUN apt-get install python3-pip -y
RUN apt-get install python3-dev -y
RUN python3 -V
RUN pip3 -V
RUN pip3 install --upgrade pip
RUN pip -V

RUN apt-get install git -y
RUN apt-get install vim -y
RUN apt-get install wget -y

#
# ------ yolo v3 ---
#
RUN mkdir /root/work 
WORKDIR /root/work/
RUN git clone https://github.com/pjreddie/darknet.git
WORKDIR /root/work/darknet
RUN make
RUN wget https://pjreddie.com/media/files/yolov3.weights
RUN wget https://pjreddie.com/media/files/yolov3-tiny.weights

RUN ln -s /root/work/darknet/libdarknet.so /usr/lib/libdarknet.so

#-- copy ---
WORKDIR /root/work/
RUN git clone https://github.com/mganeko/python3_yolov3.git
RUN cp /root/work/python3_yolov3/darknet-tiny-label.py /root/work/darknet/python/


# --- for running --

WORKDIR /root/work/darknet/