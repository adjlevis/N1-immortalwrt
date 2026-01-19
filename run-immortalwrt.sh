#!/bin/bash
set -e

### ===== 可修改参数 =====
PARENT_IF="eth0"
MACVLAN_NET="macnet"

SUBNET="192.168.2.0/24"
GATEWAY="192.168.2.1"

SHIM_IF="macvlan-shim"
SHIM_IP="192.168.2.2/24"

IMAGE="ghcr.io/adjlevis/n1-immortalwrt:latest"
CONTAINER_NAME="immortalwrt"
### ======================

echo "[1/5] 创建 macvlan 网络（若已存在会跳过）"
docker network inspect ${MACVLAN_NET} >/dev/null 2>&1 || \
docker network create -d macvlan \
  --subnet=${SUBNET} \
  --gateway=${GATEWAY} \
  -o parent=${PARENT_IF} \
  ${MACVLAN_NET}

echo "[2/5] 创建宿主机 macvlan shim 接口"
ip link show ${SHIM_IF} >/dev/null 2>&1 || \
ip link add ${SHIM_IF} link ${PARENT_IF} type macvlan mode bridge

ip addr show ${SHIM_IF} | grep -q "${SHIM_IP}" || \
ip addr add ${SHIM_IP} dev ${SHIM_IF}

ip link set ${SHIM_IF} up

echo "[3/5] 删除旧容器（如存在）"
docker rm -f ${CONTAINER_NAME} >/dev/null 2>&1 || true

echo "[4/5] 启动 ImmortalWrt 容器"
docker run -d \
  --name ${CONTAINER_NAME} \
  --network ${MACVLAN_NET} \
  --privileged \
  --restart unless-stopped \
  ${IMAGE}

echo "[5/5] 完成"
echo "👉 ImmortalWrt 已启动（macvlan 网络）"
