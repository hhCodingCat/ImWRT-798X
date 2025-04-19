#!/bin/bash
#
# 版权所有 (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 这是一个自由软件，遵循 MIT 许可证。
# 更多信息请见 /LICENSE 文件。
#
# https://github.com/P3TERX/Actions-OpenWrt
# 文件名: diy-part1.sh
# 描述: OpenWrt DIY 脚本第一部分 (更新 feeds 之前)
#

# 取消注释一个 feed 源
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# 添加一个 feed 源
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 检查 feeds.conf.default 是否变更
if [ -f feeds.conf.default ]; then
  echo "feeds.conf.default 已存在，无需修改"
else
  echo "未找到 feeds.conf.default，将使用默认配置"
fi
