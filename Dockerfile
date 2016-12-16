FROM php-fpm:7
MAINTAINER Arash Samadi "samadi@sub.uni-goettingen.de"

ENV WORDPRESS_VERSION 4.7
ENV WORDPRESS_URL "https://wordpress.org/latest.tar.gz"
ENV WORDPRESS_DIR /srv/www/wordpress

ENV SRC_DIR /usr/src
ENV WWW_DIR /srv/www
ENV APT_INSTALL "apt install --no-install-recommends --no-install-suggests --yes"
ENV WGET_CMD "wget --no-check-certificate"
ENV BUILD_PRE "openjpeg-tools ghostscript xml-core xml2 lzma zip p7zip pngtools libltdl-dev libjpeg-dev libgif-dev libpng16-dev"

ENV IMAGEMAGICK_URL "https://www.imagemagick.org/download/ImageMagick.tar.gz"
ENV IMAGEMAGICK_BUILD_ARGS "--without-x --without-perl --disable-dependency-tracking --with-modules --with-quantum-depth=16 \
	--with-png --with-jpeg --with-zlib --with-openjp2 --with-xml --with-lzma --with-gslib --prefix=/opt"

RUN mkdir -p ${WORDPRESS_DIR} \
	&& mkdir -p ${SRC_DIR}/imagemagick \
	&& apt update \
	&& apt upgrade --yes \
	&& ${APT_INSTALL} ${BUILD_PRE} \
	&& ldconfig /usr/lib \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR ${SRC_DIR}
RUN ${WGET_CMD} -O imagemagick.tgz ${IMAGEMAGICK_URL} \
	&& tar xfvz imagemagick.tgz --strip-components=1 -C imagemagick/ \
	&& cd ${SRC_DIR}/imagemagick \
	&&./configure ${IMAGEMAGICK_BUILD_ARGS} \
	&& make && make install \
	&& ldconfig /usr/lib /usr/local/lib \
	&& cd ../ && rm -Rf imagemagick*

WORKDIR ${WWW_DIR}
RUN ${WGET_CMD} -O wordpress.tgz ${WORDPRESS_URL} \
	&& tar xfvz wordpress.tgz --strip-components=1 -C wordpress \
	&& rm wordpress.tgz

EXPOSE 80 443

CMD ["bash"]
