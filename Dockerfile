FROM ubuntu:13.04 AS nginx-builder

ARG NGINX_VER=1.4.0

# archive is outdated, replace with old-releases
RUN sed -i -- 's/archive/old-releases/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
	gcc python python-pip\
	make vim tmux\
	build-essential \
	wget curl \
	libpcre3-dev zlib1g-dev openssl \
	tar \
	&& rm -r /var/lib/apt/lists/*

WORKDIR /tmp
#COPY get-pip.py .
#COPY POC.py .

#RUN python get-pip.py
#RUN python -m pip install --trusted-host httplib

RUN wget -O /tmp/nginx-$NGINX_VER.tar.gz -q http://nginx.org/download/nginx-$NGINX_VER.tar.gz \
	&& tar -zxvf nginx-$NGINX_VER.tar.gz \
	&& cd nginx-$NGINX_VER \
	&& ./configure \
		--prefix=/opt/nginx \
		--with-cpu-opt=generic \
		--with-ld-opt="-static" \
		--with-cc-opt="-O2 -static -static-libgcc" \
	&& sed -i "/CFLAGS/s/ \-O //g" objs/Makefile \
	&& make \
	&& make install
