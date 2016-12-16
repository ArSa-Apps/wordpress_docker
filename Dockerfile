FROM ubuntu:16.04
MAINTAINER Arash Samadi "samadi@sub.uni-goettingen.de"

ENV WORDPRESS_VERSION 4.7
ENV WORDPRESS_DIR /srv/www/wordpress

RUN mkdir -p ${WORDPRESS_DIR} \
	&& apt update \
	&& apt upgrade --yes \
	&& apt install --no-install-recommends --no-install-suggests --yes wget \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /srv/www
RUN wget -O wordpress.tar.gz --no-check-certificate https://wordpress.org/latest.tar.gz \
	&& tar xfvz wordpress.tar.gz -C wordpress \
	&& rm wordpress.tar.gz

EXPOSE 80 443

CMD ["bash"]
