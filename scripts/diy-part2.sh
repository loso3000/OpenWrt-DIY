#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
rm -rf ./package/lean/luci-theme-argon
rm -rf ./package/lean/luci-theme-opentomcat
rm -rf ./package/lean/ddns-scripts_aliyun
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/ddns-scripts_aliyun./package/lean/ddns-scripts_aliyun
rm -rf ./package/lean/ddns-scripts_dnspod
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/ddns-scripts_dnspod ./package/lean/ddns-scripts_dnspod
rm -rf ./feeds/packages/net/smartdns
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ./package/diy/smartdns
rm -rf ./package/lean/luci-app-netdata
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata ./package/lean/luci-app-netdata
rm -rf ./feeds/packages/admin/netdata
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata ./feeds/packages/admin/netdata
rm -rf ./feeds/packages/net/mwan3
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/mwan3 ./feeds/packages/net/mwan3
rm -rf ./feeds/packages/net/https-dns-proxy  && svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy ./feeds/packages/net/https-dns-proxy
#rm -rf ./package/diy/autocore
rm -rf ./package/diy/netdata
rm -rf ./package/diy/mwan3
#rm -rf ./package/diy/default-settings
rm -rf ./package/lean/autocore
rm -rf ./package/lean/default-settings
rm -rf ./package/lean/automount
rm -rf ./package/lean/autosamba
rm -rf ./package/lean/luci-app-cpufreq
#curl -fsSL https://raw.githubusercontent.com/loso3000/other/master/patch/autocore/files/x86/index.htm > package/lean/autocore/files/x86/index.htm
#curl -fsSL https://raw.githubusercontent.com/loso3000/other/master/patch/autocore/files/arm/index.htm > package/lean/autocore/files/arm/index.htm
#curl -fsSL  https://raw.githubusercontent.com/loso3000/other/master/patch/default-settings/zzz-default-settings > ./package/lean/default-settings/files/zzz-default-settings
curl -fsSL  https://raw.githubusercontent.com/loso3000/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/loso3000/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
sed -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/Turbo ACC 网络加速/ACC网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/Turbo ACC 网络加速/ACC网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
sed -i 's/家庭云//g' package/lean/luci-app-familycloud/luasrc/controller/familycloud.lua
sed -i 's/invalid/# invalid/g' package/lean/samba4/files/smb.conf.template
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template
sed -i 's/a.default = "0"/a.default = "1"/g' ./package/lean/luci-app-cifsd/luasrc/controller/cifsd.lua
sed -i 's/$(VERSION_DIST_SANITIZED)/$(shell TZ=UTC-8 date +%Y%m%d)-Ipv6-Mini/g' include/image.mk
cp -f ./package/diy/banner ./package/base-files/files/etc/
date1='Ipv6-Mini-S'`TZ=UTC-8 date +%Y.%m.%d -d +"0"days`
sed -i 's/$(VERSION_DIST_SANITIZED)/$(VERSION_DIST_SANITIZED)-${date1}/g' include/image.mk
echo "DISTRIB_REVISION='${date1} by Sirpdboy'" > ./package/base-files/files/etc/openwrt_release1
echo ${date1}' by Sirpdboy ' >> ./package/base-files/files/etc/banner
echo '---------------------------------' >> ./package/base-files/files/etc/banner
sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' ./package/base-files/files/etc/shadow
sed -i  '/filter_/d' package/network/services/dnsmasq/files/dhcp.conf
#内核 设置
#sed -i '/CONFIG_NVME_MULTIPATH /d' ./package/target/linux/x86/config-5.4
#sed -i '/CONFIG_NVME_TCP /d' ./package/target/linux/x86/config-5.4
#echo  'CONFIG_BINFMT_MISC=y' >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_EXTRA_FIRMWARE="i915/kbl_dmc_ver1_04.bin"'   >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"'  >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_NVME_FABRICS=y'  >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_NVME_FC=y' >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_NVME_MULTIPATH=y' >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_NVME_TCP=y' >> ./package/target/linux/x86/config-5.4

echo  "        option tls_enable 'true'" >> ./package/lean/luci-app-frpc/root/etc/config/frp
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/diy/luci-app-openclash
git clone https://github.com/xiaorouji/openwrt-passwall package/diy1
# git clone https://github.com/garypang13/luci-app-dnsfilter.git package/diy/luci-app-dnsfilter
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./package/diy/luci-app-serverchan
git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/diy/OpenAppFilter
rm -rf ./package/lean/luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/diy/luci-app-jd-dailybonus
#bypass
git clone -b master --single-branch https://github.com/fw876/helloworld ./package/hw
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/diy/luci-app-vssr
#git clone https://github.com/garypang13/luci-app-bypass.git package/diy/luci-app-bypass
#sed -i 's/shadowsocksr-libev-alt/shadowsocksr-libev-ssr-redir/g' package/*/*/Makefile
#sed -i 's/shadowsocksr-libev-server/shadowsocksr-libev-ssr-server/g' package/*/*/Makefile

# sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
# sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
#sed -i "/mediaurlbase/d" package/*/luci-theme*/root/etc/uci-defaults/*
#sed -i "/mediaurlbase/d" feed/*/luci-theme*/root/etc/uci-defaults/*
#  rm -rf ./package/diy1/trojan
#  rm -rf ./package/diy1/v2ray
#  rm -rf ./package/diy1/v2ray-plugin
rm -rf ./package/lean/trojan
rm -rf ./package/lean/v2ray
rm -rf ./package/lean/v2ray-plugin
rm -rf package/hw/xray-core
rm -rf package/diy1/tcping
#rm -rf package/diy1/xray-core
#rm -rf package/diy/vssr
./scripts/feeds update -i

