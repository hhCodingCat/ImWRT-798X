#!/bin/bash
#
# 版权所有 (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 这是一个自由软件，根据 MIT 许可证授权。
# 详细信息请参见 /LICENSE。
#
# https://github.com/P3TERX/Actions-OpenWrt
# 修改默认 IP
CONFIG_FILE="package/base-files/files/bin/config_generate"
if ! grep -q "192.168.2.1" "$CONFIG_FILE"; then
  sed -i 's/192\.168\.6\.1/192.168.2.1/g; s/192\.168\.1\.1/192.168.2.1/g' "$CONFIG_FILE"
  echo "IP 地址已更新为 192.168.2.1"
else
  echo "IP 地址已是 192.168.2.1，无需修改"
fi

# 预装 OpenClash（根据用户需求添加）
# echo "CONFIG_PACKAGE_luci-app-openclash=y" >> .config
