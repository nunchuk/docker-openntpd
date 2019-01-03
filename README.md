# docker-openntpd

Dockerized NTP Server

## Usage

#### Build Docker Image

```shell
$ git clone https://github.com/nunchuk/docker-openntpd.git
$ cd docker-openntpd/
$ nano ntpd.conf
# ntp[1-7].aliyun.com, time.google.com
# https://www.alibabacloud.com/help/doc-detail/92704.html
```

```
$ docker build -t openntpd:v1 .
```

#### Synchronizing from Public NTP service

Force an immediate update

`$ ntpdate time.google.com`

Update the RTC (hardware clock)

`$ hwclock -w`

Compare the system clock with the CMOS clock

`$ hwclock -c`

#### Run Container

```shell
$ docker run --name openntpd -dit --restart always \
  -p 123:123/udp \
  --privileged=true \
  openntpd:v1
```

#### Check Service

Stats

`$ docker exec -ti openntpd ntpctl -s all`

Logs

`$ docker logs -f openntpd`

#### Other Instance to Verify

`$ ntpq -p <docker-openntpd-host-ip>`

Contributors
-------------------
* XinYe (nunchuk@live.com)
