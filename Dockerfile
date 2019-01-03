############################################################
# Dockerfile to build ntpd image
# Based on Alpine:3.8
############################################################

FROM library/alpine:3.8
MAINTAINER XinYe <nunchuk@live.com>

ENV TIMEZONE=Asia/Shanghai \
	TIMEZONE_DEPS=tzdata

# set timezone
RUN set -xe; \
	apk --update add --no-cache --virtual .build-deps \
                      $TIMEZONE_DEPS ; \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime ; \
	echo ${TIMEZONE} > /etc/timezone

RUN set -xe; \
  apk add --no-cache openntpd

ADD ntpd.conf /etc/ntpd.conf

# clean up
RUN apk del .build-deps && \
	rm -rf /var/cache/apk/*

EXPOSE 123/udp

CMD ["ntpd", "-d"]
