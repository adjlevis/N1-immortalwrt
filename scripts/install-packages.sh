#!/bin/sh
set -e

echo "[1/4] 更新 opkg 源"
opkg update

echo "[2/4] 安装 LuCI 插件 & 必备组件"
opkg install \
  luci-i18n-ttyd-zh-cn \
  luci-i18n-filebrowser-go-zh-cn \
  luci-i18n-argon-config-zh-cn \
  luci-i18n-samba4-zh-cn \
  openssh-sftp-server

echo "[3/4] 清理缓存，减小镜像体积"
rm -rf /var/opkg-lists/*

echo "[4/4] 完成插件安装"
