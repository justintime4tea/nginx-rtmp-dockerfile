FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
ENV PATH $PATH:/usr/local/nginx/sbin

EXPOSE 1935
EXPOSE 80

# create directories
RUN mkdir /src && mkdir /config && mkdir /logs && mkdir /data && mkdir /static

# update and upgrade packages
RUN apt-get update && apt-get upgrade -y && apt-get clean
RUN apt-get install -y build-essential wget nano

# ffmpeg
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:mc3man/trusty-media
RUN apt-get update
RUN apt-get install -y ffmpeg

# nginx dependencies
RUN apt-get install -y libpcre3-dev zlib1g-dev libssl-dev
RUN apt-get install -y wget git

# get nginx and rtmp-module source
RUN cd /src && git clone https://github.com/nginx/nginx.git && git clone https://github.com/arut/nginx-rtmp-module.git

# configure nginx
RUN cd /src/nginx && git checkout tags/release-1.10.1 && ./auto/configure --add-module=/src/nginx-rtmp-module --with-http_ssl_module

# make and install
RUN cd /src/nginx && make && make install

ADD nginx.conf /config/nginx.conf
ADD static /static

CMD "nginx"