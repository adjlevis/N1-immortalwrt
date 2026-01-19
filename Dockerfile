FROM scratch

# 1️⃣ 解压 ImmortalWrt rootfs
ADD immortalwrt-24.10.0-rc3-armsr-armv8-rootfs.tar.gz /

# 2️⃣ 复制文件（网络配置 / rc.local 等）
COPY files/ /
COPY scripts/install-packages.sh /tmp/install-packages.sh

ENV PATH=/usr/sbin:/usr/bin:/sbin:/bin

# 3️⃣ 构建阶段安装插件
RUN /tmp/install-packages.sh && rm -f /tmp/install-packages.sh

STOPSIGNAL SIGTERM
CMD ["/sbin/init"]
