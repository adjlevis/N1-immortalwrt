FROM scratch

ADD immortalwrt-24.10.0-rc3-armsr-armv8-rootfs.tar.gz /
COPY files/ /

ENV PATH=/usr/sbin:/usr/bin:/sbin:/bin
STOPSIGNAL SIGTERM
CMD ["/sbin/init"]
