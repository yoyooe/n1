#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#!/bin/bash
#============================================================
rm -rf ./feeds/freifunk/themes
rm -rf ./package/lean/luci-theme-netgear
rm -rf ./package/lean/luci-theme-argon
rm -rf ./feeds/luci/themes/luci-theme-material

# echo '删除重复插件'
rm -rf ./feeds/packages/net/smartdns
rm -rf ./feeds/packages/admin/netdata
rm -rf ./package/lean/luci-app-netdata
rm -rf ./package/lean/luci-app-cpufreq
rm -rf ./package/lean/luci-app-usb-printer
rm -rf ./package/lean/luci-app-jd-dailybonus
rm -rf ./feeds/luci/applications/luci-app-rp-pppoe-server

# echo '修改 默认IP'
sed -i "s/192.168.1.1/192.168.123.2/g" package/base-files/files/bin/config_generate
# echo '修改 主机名'
sed -i "s/OpenWrt/N1/g" package/base-files/files/bin/config_generate

# echo '替换系统文件'
curl -fsSL https://raw.githubusercontent.com/gd0772/patch/main/zzz-default-settings > ./package/lean/default-settings/files/zzz-default-settings

# 添加argon主题及设置
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/lean/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/diy/luci-app-argon-config
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial ./package/lean/luci-theme-atmaterial
# 添加京东签到
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/diy/luci-app-jd-dailybonus
# echo '添加 eqos'
#svn co https://github.com/281677160/openwrt-package/trunk/luci-app-eqos ./package/diy/luci-app-eqos
# echo '添加 访问限制'
#svn co https://github.com/gd0772/package/trunk/luci-app-control-webrestriction ./package/diy/luci-app-control-webrestriction
# echo ‘添加 cpu 限制’
#svn co https://github.com/gd0772/package/trunk/luci-app-cpufreq ./package/diy/luci-app-cpufreq
# echo '添加 AdGuardHome'
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-adguardhome ./package/diy/luci-app-adguardhome
svn co https://github.com/kenzok8/openwrt-packages/trunk/AdGuardHome ./package/diy/AdGuardHome
# echo '添加 dockerman @修改默认目录'
git clone https://github.com/lisaac/luci-app-dockerman.git ./package/diy/luci-app-dockerman
#sed -i "s:/opt/docker:/mnt/mmcblk2p3/docker:g" package/diy/luci-app-dockerman/root/etc/config/dockerman
# echo '添加 SSR Plus+'
git clone https://github.com/fw876/helloworld package/diy/ssrplus
# echo '添加 小猫咪'
git clone https://github.com/vernesong/OpenClash package/diy/OpenClash
# echo '添加 Passwall'
git clone https://github.com/xiaorouji/openwrt-passwall package/diy/passwall
# echo '添加 HelloWorld'
git clone https://github.com/jerrykuku/luci-app-vssr package/diy/luci-app-vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git package/diy/lua-maxminddb
# echo '添加 SmartDNS'
git clone https://github.com/pymumu/luci-app-smartdns.git -b lede ./package/diy/luci-app-smartdns
git clone https://github.com/pymumu/openwrt-smartdns.git ./feeds/packages/net/smartdns
              
# echo '修改插件名称'
sed -i 's/TTYD 终端/命令行/g' package/lean/luci-app-ttyd/po/zh-cn/terminal.po
sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i 's/PassWall/Pass Wall/g' package/diy/passwall/luci-app-passwall/po/zh-cn/passwall.po
sed -i 's/msgstr "UPnP"/msgstr "UPnP设置"/g' feeds/luci/applications/luci-app-upnp/po/zh-cn/upnp.po
sed -i 's/Docker CE 容器/Docker容器/g' package/lean/luci-app-docker/po/zh-cn/docker.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/京东签到服务/京东签到/g' package/diy/luci-app-jd-dailybonus/luasrc/controller/jd-dailybonus.lua
sed -i 's/带宽监控/统计/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/实时流量监测/流量监测/g' package/lean/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po

# echo '调整 SSRP 到 GFW 菜单'
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/advanced.lua
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/client.lua
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/client-config.lua
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/control.lua
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/log.lua
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/server.lua
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/server-config.lua
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/servers.lua
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/status.lua
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/view/shadowsocksr/certupload.htm
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/view/shadowsocksr/check.htm
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/view/shadowsocksr/checkport.htm
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/view/shadowsocksr/ping.htm
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/view/shadowsocksr/refresh.htm
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/view/shadowsocksr/reset.htm
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/view/shadowsocksr/server_list.htm
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/view/shadowsocksr/socket.htm
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/view/shadowsocksr/ssrurl.htm
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/view/shadowsocksr/status.htm
sed -i 's/services/vpn/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/view/shadowsocksr/subscribe.htm
# echo '调整 PassWall 到 GFW 菜单'
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/controller/passwall.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/api/api.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/acl.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/app_update.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/auto_switch.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/global.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/haproxy.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/log.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/node_config.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/node_list.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/node_subscribe.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/other.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/rule.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/rule_list.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/shunt_rules.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/index.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/user.lua
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/app_update/brook_version.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/app_update/kcptun_version.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/app_update/trojan_go_version.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/app_update/xray_version.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/global/footer.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/global/status.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/global/status2.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/global/tips.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/haproxy/status.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/log/log.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/node_list/link_add_node.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/node_list/link_share_man.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/node_list/node_list.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/rule/rule_version.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/server/log.htm
sed -i 's/services/vpn/g' package/diy/passwall/luci-app-passwall/luasrc/view/passwall/server/users_list_status.htm
# echo '调整 HelloWorld 到 GFW 菜单'
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/controller/vssr.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/model/cbi/vssr/advanced.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/model/cbi/vssr/client.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/model/cbi/vssr/client-config.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/model/cbi/vssr/control.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/model/cbi/vssr/log.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/model/cbi/vssr/router.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/model/cbi/vssr/server.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/model/cbi/vssr/server-config.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/model/cbi/vssr/servers.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/model/cbi/vssr/socks5.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/model/cbi/vssr/subscribe-config.lua
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/view/vssr/cell_valuefooter.htm
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/view/vssr/cell_valueheader.htm
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/view/vssr/licence.htm
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/view/vssr/refresh.htm
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/view/vssr/ssrurl.htm
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/view/vssr/status_bottom.htm
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/view/vssr/status_top.htm
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/view/vssr/tblsection.htm
sed -i 's/services/vpn/g' package/diy/luci-app-vssr/luasrc/view/vssr/update_subscribe.htm
# echo '调整 OpenClash 到 GFW 菜单'
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/controller/openclash.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/openclash.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/client.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/config.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/config-subscribe.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/config-subscribe-edit.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/game-rules-manage.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/groups-config.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/log.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/other-rules-edit.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/proxy-provider-config.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/proxy-provider-file-manage.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/rule-providers-config.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/rule-providers-file-manage.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/rule-providers-manage.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/rule-providers-settings.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/servers.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/servers-config.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/settings.lua
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/cfg_check.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/config_editor.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/developer.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/download_rule.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/dvalue.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/log.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/myip.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/other_button.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/ping.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/server_list.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/status.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/switch_mode.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/update.htm
sed -i 's/services/vpn/g' package/diy/OpenClash/luci-app-openclash/luasrc/view/openclash/upload.htm


# echo '添加自定义防火墙说明'
curl -fsSL https://raw.githubusercontent.com/gd0772/patch/main/firewall.user > ./package/network/config/firewall/files/firewall.user

# echo '版本号更新'
sed -i "s/R21.2.1/R21.2.1 $(TZ=UTC-8 date "+%Y.%m.%d") Compilde by yoyo/g" package/lean/default-settings/files/zzz-default-settings

# echo '更新feeds'
./scripts/feeds update -a
./scripts/feeds install -a
