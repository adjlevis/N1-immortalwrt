一键脚本（macvlan + shim + ImmortalWrt 容器）执行run-immortalwrt.sh
使用方法
chmod +x run-immortalwrt.sh
./run-immortalwrt.sh

N1 专用优化（自动识别 eth0 / eth1）

防止 N1 不同固件网卡名不同

📄 files/etc/rc.local
#!/bin/sh

# 自动选择物理网卡
IFACE=$(ls /sys/class/net | grep -E 'eth0|eth1' | head -n 1)

uci set network.lan.device="$IFACE"
uci commit network

exit 0


确保可执行：

chmod +x files/etc/rc.local


<!-- 徽章区 -->
[![Stars](https://img.shields.io/github/stars/adjlevis/N1-immortalwrt)](https://github.com/adjlevis/N1-immortalwrt)

<!-- Star History -->
## ⭐ Star History
[![Star History Chart](https://api.star-history.com/svg?repos=adjlevis/N1-immortalwrt&type=Date)](https://star-history.com/#adjlevis/N1-immortalwrt&Date)
