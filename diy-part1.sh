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

# echo '添加argon主题及设置'
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/lean/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/diy/luci-app-argon-config
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial ./package/lean/luci-theme-atmaterial
# echo '添加 SSR Plus+'
git clone https://github.com/fw876/helloworld package/diy/ssrplus
# echo '添加 小猫咪'
git clone https://github.com/vernesong/OpenClash package/diy/OpenClash
# echo '添加 Passwall'
git clone https://github.com/xiaorouji/openwrt-passwall package/diy/passwall
# echo '添加 HelloWorld'
git clone https://github.com/jerrykuku/luci-app-vssr package/diy/luci-app-vssr
# echo '添加 应用过滤'
git clone https://github.com/destan19/OpenAppFilter package/diy/OpenAppFilter
# echo '添加 京东签到'
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus package/diy/luci-app-jd-dailybonus
# echo '添加 SmartDNS'
git clone https://github.com/pymumu/luci-app-smartdns.git -b lede ./package/diy/luci-app-smartdns
git clone https://github.com/pymumu/openwrt-smartdns.git ./feeds/packages/net/smartdns
# echo '添加 dockerman @修改默认目录'
git clone https://github.com/lisaac/luci-app-dockerman.git ./package/diy/luci-app-dockerman
# echo '添加 AdGuardHome'
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-adguardhome ./package/diy/luci-app-adguardhome
svn co https://github.com/kenzok8/openwrt-packages/trunk/AdGuardHome ./package/diy/AdGuardHome
# echo '添加 KPR去广告'
git clone https://github.com/project-lede/luci-app-godproxy package/diy/luci-app-godproxy
# echo '微信推送'
git clone https://github.com/tty228/luci-app-serverchan.git ./package/diy/luci-app-serverchan
# echo '汉化实时监控'
svn co https://github.com/gd0772/patch/trunk/luci-app-netdata ./package/lean/luci-app-netdata
svn co https://github.com/gd0772/patch/trunk/netdata ./feeds/packages/admin/netdata
# echo '替换USB打印'
svn co https://github.com/gd0772/patch/trunk/luci-app-usb-printer ./package/lean/luci-app-usb-printer
# echo '替换aria2'
rm -rf feeds/luci/applications/luci-app-aria2 && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-aria2 feeds/luci/applications/luci-app-aria2
rm -rf feeds/packages/net/aria2 && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/aria2 feeds/packages/net/aria2
rm -rf feeds/packages/net/ariang && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/ariang feeds/packages/net/ariang

# echo '修改插件名称'
sed -i 's/"管理权"/"改密码"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's/TTYD 终端/命令行/g' package/lean/luci-app-ttyd/po/zh-cn/terminal.po
sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/diy/ssrplus/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i 's/PassWall/Pass Wall/g' package/diy/passwall/luci-app-passwall/po/zh-cn/passwall.po
sed -i 's/广告屏蔽大师 Plus+/广告屏蔽/g' package/lean/luci-app-adbyby-plus/po/zh-cn/adbyby.po
sed -i 's/GodProxy滤广告/KPR去广告/g' package/diy/luci-app-godproxy/luasrc/controller/koolproxy.lua
sed -i 's/GodProxy滤广告/KoolProxyR去广告/g' package/diy/luci-app-godproxy/luasrc/model/cbi/koolproxy/global.lua
sed -i 's/GodProxy 访问控制/KoolProxyR 访问控制/g' package/diy/luci-app-godproxy/luasrc/model/cbi/koolproxy/global.lua
sed -i 's/GodProxy 帮助支持/KoolProxyR帮助支持/g' package/diy/luci-app-godproxy/luasrc/model/cbi/koolproxy/global.lua
sed -i 's/GodProxy是/是/g' package/diy/luci-app-godproxy/luasrc/model/cbi/koolproxy/global.lua
sed -i 's/GodProxy/KoolProxyR/g' package/diy/luci-app-godproxy/luasrc/model/cbi/koolproxy/global.lua
sed -i 's/GodProxy滤广告/KPR去广告/g' package/diy/luci-app-godproxy/luasrc/model/cbi/koolproxy/rss_rule.lua
sed -i 's/Shaoxia的KoolProxyR详细使用说明/关于 KoolProxyR 的详细使用说明/g' package/diy/luci-app-godproxy/luasrc/view/koolproxy/feedback.htm
sed -i 's/GodProxy/KoolProxyR/g' package/diy/luci-app-godproxy/luasrc/view/koolproxy/feedback.htm
sed -i 's/京东签到服务/京东签到/g' package/diy/luci-app-jd-dailybonus/luasrc/controller/jd-dailybonus.lua
sed -i 's/KMS 服务器/KMS 激活/g' package/lean/luci-app-vlmcsd/po/zh-cn/vlmcsd.zh-cn.po
sed -i 's/msgstr "UPnP"/msgstr "UPnP设置"/g' feeds/luci/applications/luci-app-upnp/po/zh-cn/upnp.po
sed -i 's/Frp 内网穿透/Frp 客户端/g' package/lean/luci-app-frpc/po/zh-cn/frp.po
sed -i 's/Frps/Frp 服务端/g' package/lean/luci-app-frps/luasrc/controller/frps.lua
sed -i 's/Nps 内网穿透/NPS 客户端/g' package/lean/luci-app-nps/po/zh-cn/nps.po
sed -i 's/解锁网易云灰色歌曲/音乐解锁/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
sed -i 's/Docker CE 容器/Docker容器/g' package/lean/luci-app-docker/po/zh-cn/docker.po
sed -i 's/UU游戏加速器/UU加速器/g' package/lean/luci-app-uugamebooster/po/zh-cn/uuplugin.po
sed -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/挂载 SMB 网络共享/挂载共享/g' package/lean/luci-app-cifs-mount/po/zh-cn/cifs.po
sed -i 's/"文件浏览器"/"文件浏览"/g' package/diy/luci-app-filebrowser/po/zh-cn/filebrowser.po
sed -i 's/msgstr "FTP 服务器"/msgstr "FTP 服务"/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/Rclone/网盘挂载/g' package/lean/luci-app-rclone/luasrc/controller/rclone.lua
sed -i 's/msgstr "Aria2"/msgstr "Aria2下载"/g' feeds/luci/applications/luci-app-aria2/po/zh-cn/aria2.po
sed -i 's/BaiduPCS Web/百毒网盘/g' package/lean/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua
sed -i 's/IPSec VPN 服务器/IPSec 服务/g' package/lean/luci-app-ipsec-vpnd/po/zh-cn/ipsec.po
sed -i 's/V2ray 服务器/V2ray 服务/g' package/lean/luci-app-v2ray-server/po/zh-cn/v2ray_server.po
sed -i 's/SoftEther VPN 服务器/SoftEther/g' package/lean/luci-app-softethervpn/po/zh-cn/softethervpn.po
sed -i 's/"OpenVPN 服务器"/"OpenVPN"/g' package/lean/luci-app-openvpn-server/po/zh-cn/openvpn-server.po
sed -i 's/firstchild(), "VPN"/firstchild(), "GFW"/g' package/lean/luci-app-zerotier/luasrc/controller/zerotier.lua
sed -i 's/firstchild(), "VPN"/firstchild(), "GFW"/g' package/lean/luci-app-ipsec-vpnd/luasrc/controller/ipsec-server.lua
sed -i 's/firstchild(), "VPN"/firstchild(), "GFW"/g' package/lean/luci-app-softethervpn/luasrc/controller/softethervpn.lua
sed -i 's/firstchild(), "VPN"/firstchild(), "GFW"/g' package/lean/luci-app-openvpn-server/luasrc/controller/openvpn-server.lua
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/MWAN3 分流助手/分流助手/g' package/lean/luci-app-mwan3helper/po/zh-cn/mwan3helper.po
sed -i 's/运行环境检测失败，请先关闭ACC加速模块!/运行环境检测失败，请关闭 网络加速!/g' package/diy/OpenAppFilter/luci-app-oaf/luasrc/model/cbi/appfilter/appfilter.lua
sed -i 's/带宽监控/统计/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/实时流量监测/流量监测/g' package/lean/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
sed -i 's/invalid/# invalid/g' package/lean/samba4/files/smb.conf.template

# echo '移动 网络共享 到 存储菜单'
sed -i 's/\"services\"/\"nas\"/g' package/lean/luci-app-samba4/luasrc/controller/samba4.lua
# echo '移动 分流助手 到 网络菜单'
sed -i 's/\"services\"/\"network\"/g' package/lean/luci-app-mwan3helper/luasrc/controller/mwan3helper.lua
curl -fsSL https://raw.githubusercontent.com/gd0772/patch/main/mwan3helper_status.htm > ./package/lean/luci-app-mwan3helper/luasrc/view/mwan3helper/mwan3helper_status.htm

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
# echo '调整 V2ray服务器 到 GFW 菜单'
sed -i 's/services/vpn/g' package/lean/luci-app-v2ray-server/luasrc/controller/v2ray_server.lua
sed -i 's/services/vpn/g' package/lean/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/index.lua
sed -i 's/services/vpn/g' package/lean/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/user.lua
sed -i 's/services/vpn/g' package/lean/luci-app-v2ray-server/luasrc/view/v2ray_server/log.htm
sed -i 's/services/vpn/g' package/lean/luci-app-v2ray-server/luasrc/view/v2ray_server/users_list_status.htm
sed -i 's/services/vpn/g' package/lean/luci-app-v2ray-server/luasrc/view/v2ray_server/v2ray.htm

# echo '添加自定义防火墙说明'
curl -fsSL https://raw.githubusercontent.com/gd0772/patch/main/firewall.user > ./package/network/config/firewall/files/firewall.user

# echo '版本号更新'
sed -i "s/R21.2.1/R21.2.1 $(TZ=UTC-8 date "+%Y.%m.%d") Compilde by gd772/g" package/lean/default-settings/files/zzz-default-settings

# echo '更新feeds'
./scripts/feeds update -a
./scripts/feeds install -a
