#!/bin/sh
set -e

### Credit to the Authors at https://rentry.org/CFWGuides
### Script created by Fraxalotl
### Mod by huangqian8

# -------------------------------------------

### Create a few new folders for storing files
if [ -d SwitchSD ]; then
  rm -rf SwitchSD
fi
if [ -e description.txt ]; then
  rm -rf description.txt
fi
mkdir -p ./SwitchSD/atmosphere/config
mkdir -p ./SwitchSD/atmosphere/hosts
mkdir -p ./SwitchSD/atmosphere/contents/420000000007E51Anx-ovlloader
mkdir -p ./SwitchSD/atmosphere/contents/0000000000534C56ReverseNX-RT
mkdir -p ./SwitchSD/atmosphere/contents/4200000000000010ldn_mitm
mkdir -p ./SwitchSD/atmosphere/contents/0100000000000352emuiibo
mkdir -p ./SwitchSD/atmosphere/contents/0100000000000F12Fizeau
mkdir -p ./SwitchSD/atmosphere/contents/4200000000000000sys-tune
mkdir -p ./SwitchSD/atmosphere/contents/420000000000000Bsys-patch
mkdir -p ./SwitchSD/atmosphere/contents/010000000000bd00MissionControl
mkdir -p ./SwitchSD/atmosphere/contents/00FF0000636C6BFFsys-clk
mkdir -p ./SwitchSD/atmosphere/kips
mkdir -p ./SwitchSD/bootloader/payloads
mkdir -p ./SwitchSD/config/ultrahand/lang
mkdir -p ./SwitchSD/switch/Switch_90DNS_tester
mkdir -p ./SwitchSD/switch/DBI
mkdir -p ./SwitchSD/switch/NX-Shell
# mkdir -p ./SwitchSD/switch/HB-App-Store
mkdir -p ./SwitchSD/switch/HekateToolbox
mkdir -p ./SwitchSD/switch/JKSV
mkdir -p ./SwitchSD/switch/Moonlight
# mkdir -p ./SwitchSD/switch/NXThemesInstaller
mkdir -p ./SwitchSD/switch/SimpleModDownloader
mkdir -p ./SwitchSD/switch/SimpleModManager
# mkdir -p ./SwitchSD/switch/Switchfin
# mkdir -p ./SwitchSD/switch/tencent-switcher-gui
# mkdir -p ./SwitchSD/switch/wiliwili
mkdir -p ./SwitchSD/switch/NX-Activity-Log
mkdir -p ./SwitchSD/switch/Linkalho
mkdir -p ./SwitchSD/switch/.overlays
mkdir -p ./SwitchSD/switch/.packages

cd SwitchSD

### atmosphere
latest_release_info=$(curl -sL https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*atmosphere[^"]*.zip' | sed 's/"//g')
curl -sL "$download_url" -o atmosphere.zip && {
    echo "atmosphere download\033[32m success\033[0m."
    unzip -oq atmosphere.zip
    rm atmosphere.zip
} || echo "atmosphere download\033[31m failed\033[0m."

### fusee.bin
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*fusee.bin' | sed 's/"//g')
curl -sL "$download_url" -o fusee.bin && {
    echo "fusee download\033[32m success\033[0m."
    mv fusee.bin ./bootloader/payloads
} || echo "fusee download\033[31m failed\033[0m."

### Hekate + Nyx CHS
latest_release_info=$(curl -sL https://api.github.com/repos/easyworld/hekate/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*hekate_ctcaer[^"]*_sc.zip' | sed 's/"//g')
curl -sL "$download_url" -o hekate.zip && {
    echo "Hekate + Nyx CHS download\033[32m success\033[0m."
    unzip -oq hekate.zip
    rm hekate.zip
} || echo "Hekate + Nyx CHS download\033[31m failed\033[0m."

### Fetch Sigpatches from https://hackintendo.com/download/sigpatches
curl -sL https://raw.githubusercontent.com/huangqian8/SwitchPlugins/main/plugins/sigpatches.zip -o sigpatches.zip
if [ $? -ne 0 ]; then
    echo "sigpatches download\033[31m failed\033[0m."
else
    echo "sigpatches download\033[32m success\033[0m."
    unzip -oq sigpatches.zip
    rm sigpatches.zip
fi

### Fetch logo
curl -sL https://raw.githubusercontent.com/huangqian8/SwitchPlugins/main/theme/logo.zip -o logo.zip
if [ $? -ne 0 ]; then
    echo "logo download\033[31m failed\033[0m."
else
    echo "logo download\033[32m success\033[0m."
    unzip -oq logo.zip
    rm logo.zip
    rm bootloader/bootlogo.bmp
fi

### Fetch latest Lockpick_RCM.bin
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/Lockpick_RCMDecScots/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*Lockpick_RCM.bin' | sed 's/"//g')
curl -sL "$download_url" -o Lockpick_RCM.bin && {
    echo "Lockpick_RCM download\033[32m success\033[0m."
    mv Lockpick_RCM.bin ./bootloader/payloads
} || echo "Lockpick_RCM download\033[31m failed\033[0m."

### Fetch latest TegraExplorer.bin
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/TegraExplorer/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*TegraExplorer.bin' | sed 's/"//g')
curl -sL "$download_url" -o TegraExplorer.bin && {
    echo "TegraExplorer download\033[32m success\033[0m."
    mv TegraExplorer.bin ./bootloader/payloads
} || echo "TegraExplorer download\033[31m failed\033[0m."

### Fetch latest CommonProblemResolver.bin
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/CommonProblemResolver/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*CommonProblemResolver.bin' | sed 's/"//g')
curl -sL "$download_url" -o CommonProblemResolver.bin && {
    echo "CommonProblemResolver download\033[32m success\033[0m."
    mv CommonProblemResolver.bin ./bootloader/payloads
} || echo "CommonProblemResolver download\033[31m failed\033[0m."

### Fetch latest picofly_toolbox_0.2.bin from
curl -sL https://raw.github.com/Ansem-SoD/Picofly/main/Firmwares/picofly_toolbox_0.2.bin -o picofly_toolbox_0.2.bin
if [ $? -ne 0 ]; then
    echo "picofly_toolbox download\033[31m failed\033[0m."
else
    echo "picofly_toolbox download\033[32m success\033[0m."
    mv picofly_toolbox_0.2.bin ./bootloader/payloads
fi

### Fetch lastest Switch_90DNS_tester
latest_release_info=$(curl -sL https://api.github.com/repos/meganukebmp/Switch_90DNS_tester/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*Switch_90DNS_tester.nro' | sed 's/"//g')
curl -sL "$download_url" -o Switch_90DNS_tester.nro && {
    echo "Switch_90DNS_tester download\033[32m success\033[0m."
    mv Switch_90DNS_tester.nro ./switch/Switch_90DNS_tester
} || echo "Switch_90DNS_tester download\033[31m failed\033[0m."

### Fetch lastest DBI from https://github.com/rashevskyv/dbi/releases/tag/658
latest_release_info=$(curl -sL https://api.github.com/repos/rashevskyv/dbi/releases/135856657)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*DBI.nro' | sed 's/"//g')
curl -sL "$download_url" -o DBI.nro && {
    echo "DBI download\033[32m success\033[0m."
    mv DBI.nro ./switch/DBI
} || echo "DBI download\033[31m failed\033[0m."

### Fetch lastest Awoo Installer from https://github.com/dragonflylee/Awoo-Installer/releases/latest
# latest_release_info=$(curl -sL https://api.github.com/repos/dragonflylee/Awoo-Installer/releases/latest)
# download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*Awoo-Installer.zip' | sed 's/"//g')
# curl -sL "$download_url" -o Awoo-Installer.zip && {
#     echo "Awoo Installer download\033[32m success\033[0m."
#     unzip -oq Awoo-Installer.zip
#     rm Awoo-Installer.zip
# } || echo "Awoo Installer download\033[31m failed\033[0m."

### Fetch lastest Hekate-toolbox from https://github.com/WerWolv/Hekate-Toolbox/releases/latest
latest_release_info=$(curl -sL https://api.github.com/repos/WerWolv/Hekate-Toolbox/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*HekateToolbox.nro' | sed 's/"//g')
curl -sL "$download_url" -o HekateToolbox.nro && {
    echo "HekateToolbox download\033[32m success\033[0m."
    mv HekateToolbox.nro ./switch/HekateToolbox
} || echo "HekateToolbox download\033[31m failed\033[0m."

### Fetch lastest NX-Activity-Log
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/NX-Activity-Log/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*NX-Activity-Log.nro' | sed 's/"//g')
curl -sL "$download_url" -o NX-Activity-Log.nro && {
    echo "NX-Activity-Log download\033[32m success\033[0m."
    mv NX-Activity-Log.nro ./switch/NX-Activity-Log
} || echo "NX-Activity-Log download\033[31m failed\033[0m."

### Fetch lastest NXThemesInstaller from https://github.com/exelix11/SwitchThemeInjector/releases/latest
# latest_release_info=$(curl -sL https://api.github.com/repos/exelix11/SwitchThemeInjector/releases/latest)
# download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*NXThemesInstaller.nro' | sed 's/"//g')
# curl -sL "$download_url" -o NXThemesInstaller.nro && {
#    echo "NXThemesInstaller download\033[32m success\033[0m."
#    mv NXThemesInstaller.nro ./switch/NXThemesInstaller
# } || echo "NXThemesInstaller download\033[31m failed\033[0m."

### Fetch lastest JKSV from https://github.com/J-D-K/JKSV/releases/latest
latest_release_info=$(curl -sL https://api.github.com/repos/J-D-K/JKSV/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*JKSV.nro' | sed 's/"//g')
curl -sL "$download_url" -o JKSV.nro && {
    echo "JKSV download\033[32m success\033[0m."
    mv JKSV.nro ./switch/JKSV
} || echo "JKSV download\033[31m failed\033[0m."

### Fetch lastest tencent-switcher-gui from https://github.com/CaiMiao/Tencent-switcher-GUI/releases/latest
# latest_release_info=$(curl -sL https://api.github.com/repos/CaiMiao/Tencent-switcher-GUI/releases/latest)
# download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*tencent-switcher-gui.nro' | sed 's/"//g')
# curl -sL "$download_url" -o tencent-switcher-gui.nro && {
#    echo "Tencent-switcher-GUI download\033[32m success\033[0m."
#    mv tencent-switcher-gui.nro ./switch/tencent-switcher-gui
# } || echo "Tencent-switcher-GUI download\033[31m failed\033[0m."

### Fetch lastest aio-switch-updater from https://github.com/HamletDuFromage/aio-switch-updater/releases/latest
# latest_release_info=$(curl -sL https://api.github.com/repos/HamletDuFromage/aio-switch-updater/releases/latest)
# download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*aio-switch-updater.zip' | sed 's/"//g')
# curl -sL "$download_url" -o aio-switch-updater.zip && {
#    echo "aio-switch-updater download\033[32m success\033[0m."
#    unzip -oq aio-switch-updater.zip
#    rm aio-switch-updater.zip
# } || echo "aio-switch-updater download\033[31m failed\033[0m."

### Fetch latest wiliwili from https://github.com/xfangfang/wiliwili/releases/latest
# download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*wiliwili-NintendoSwitch.zip' | sed 's/"//g')
# curl -sL "$download_url" -o wiliwili-NintendoSwitch.zip && {
#    echo "wiliwili download\033[32m success\033[0m."
#    unzip -oq wiliwili-NintendoSwitch.zip
#    mv wiliwili/wiliwili.nro ./switch/wiliwili
#    rm -rf wiliwili
#    rm wiliwili-NintendoSwitch.zip
# } || echo "wiliwili download\033[31m failed\033[0m."

### linkalho
curl -sL https://raw.github.com/JosiahJiang/SwitchScript/main/plugins/linkalho.nro -o linkalho.nro
if [ $? -ne 0 ]; then
    echo "linkalho.nro download\033[31m failed\033[0m."
else
    echo "linkalho.nro download\033[32m success\033[0m."
    mv linkalho.nro ./switch/Linkalho
fi

### Fetch lastest SimpleModDownloader from https://github.com/PoloNX/SimpleModDownloader/releases/latest
latest_release_info=$(curl -sL https://api.github.com/repos/PoloNX/SimpleModDownloader/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*SimpleModDownloader.nro' | sed 's/"//g')
curl -sL "$download_url" -o SimpleModDownloader.nro && {
    echo "SimpleModDownloader download\033[32m success\033[0m."
    mv SimpleModDownloader.nro ./switch/SimpleModDownloader
} || echo "SimpleModDownloader download\033[31m failed\033[0m."

### Fetch lastest SimpleModManager from https://github.com/nadrino/SimpleModManager/releases/latest
curl -sL https://api.github.com/repos/nadrino/SimpleModManager/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*SimpleModManager.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o SimpleModManager.nro
if [ $? -ne 0 ]; then
    echo "SimpleModManager download\033[31m failed\033[0m."
else
    echo "SimpleModManager download\033[32m success\033[0m."
    mv SimpleModManager.nro ./switch/SimpleModManager
fi

### Fetch lastest Switchfin from https://github.com/dragonflylee/switchfin/releases/latest
# latest_release_info=$(curl -sL https://api.github.com/repos/dragonflylee/switchfin/releases/latest)
# download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*Switchfin.nro' | sed 's/"//g')
# curl -sL "$download_url" -o Switchfin.nro&& {
#    echo "Switchfin download\033[32m success\033[0m."
#    mv Switchfin.nro ./switch/Switchfin
# } || echo "Switchfin download\033[31m failed\033[0m."

### Fetch lastest Moonlight from https://github.com/XITRIX/Moonlight-Switch/releases/latest
latest_release_info=$(curl -sL https://api.github.com/repos/XITRIX/Moonlight-Switch/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*Moonlight-Switch.nro' | sed 's/"//g')
curl -sL "$download_url" -o Moonlight-Switch.nro&& {
    echo "Moonlight download\033[32m success\033[0m."
    mv Moonlight-Switch.nro ./switch/Moonlight
} || echo "Moonlight download\033[31m failed\033[0m."

### Fetch NX-Shell
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/NX-Shell/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*NX-Shell.nro' | sed 's/"//g')
curl -sL "$download_url" -o NX-Shell.nro&& {
    echo "NX-Shell download\033[32m success\033[0m."
    mv NX-Shell.nro ./switch/NX-Shell
} || echo "NX-Shell download\033[31m failed\033[0m."

### Fetch lastest hb-appstore from https://github.com/fortheusers/hb-appstore/releases/latest
# latest_release_info=$(curl -sL https://api.github.com/repos/fortheusers/hb-appstore/releases/latest)
# download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*appstore.nro' | sed 's/"//g')
# curl -sL "$download_url" -o appstore.nro&& {
#    echo "hb-appstore download\033[32m success\033[0m."
#    mv appstore.nro ./switch/HB-App-Store
# } || echo "hb-appstore download\033[31m failed\033[0m."

### Fetch daybreak_x
curl -sL https://raw.githubusercontent.com/huangqian8/SwitchPlugins/main/plugins/daybreak_x.zip -o daybreak_x.zip
if [ $? -ne 0 ]; then
    echo "daybreak download\033[31m failed\033[0m."
else
    echo "daybreak download\033[32m success\033[0m."
    unzip -oq daybreak_x.zip
    rm daybreak_x.zip
fi

### Fetch lastest theme-patches from https://github.com/exelix11/theme-patches
# git clone https://github.com/exelix11/theme-patches
# if [ $? -ne 0 ]; then
#     echo "theme-patches download\033[31m failed\033[0m."
# else
#     echo "theme-patches download\033[32m success\033[0m."
#     mkdir themes
#     mv -f theme-patches/systemPatches ./themes/
#     rm -rf theme-patches
# fi

### Fetch nx-ovlloader
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/nx-ovlloader/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*nx-ovlloader.zip' | sed 's/"//g')
curl -sL "$download_url" -o nx-ovlloader.zip&& {
    echo "nx-ovlloader download\033[32m success\033[0m."
    unzip -oq nx-ovlloader.zip
    rm nx-ovlloader.zip
} || echo "nx-ovlloader download\033[31m failed\033[0m."

### Fetch lastest Ultrahand-Overlay
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/Ultrahand-Overlay/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*Ultrahand.zip' | sed 's/"//g')
curl -sL "$download_url" -o Ultrahand.zip&& {
    echo "Ultrahand-Overlay download\033[32m success\033[0m."
    unzip -oq Ultrahand.zip
    rm Ultrahand.zip
} || echo "Ultrahand-Overlay download\033[31m failed\033[0m."

### Fetch EdiZon
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/EdiZon-Overlay/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*EdiZon.zip' | sed 's/"//g')
curl -sL "$download_url" -o EdiZon.zip&& {
    echo "EdiZon download\033[32m success\033[0m."
    unzip -oq EdiZon.zip
    rm EdiZon.zip
} || echo "EdiZon download\033[31m failed\033[0m."

### Fetch ovl-sysmodules
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/ovl-sysmodules/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*ovl-sysmodules.zip' | sed 's/"//g')
curl -sL "$download_url" -o ovl-sysmodules.zip&& {
    echo "ovl-sysmodules download\033[32m success\033[0m."
    unzip -oq ovl-sysmodules.zip
    rm ovl-sysmodules.zip
    sed -i "s/powerControlEnabled=1/powerControlEnabled=0/g" config/ovl-sysmodules/config.ini
} || echo "ovl-sysmodules download\033[31m failed\033[0m."

### Fetch StatusMonitor
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/Status-Monitor-Overlay/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*StatusMonitor.zip' | sed 's/"//g')
curl -sL "$download_url" -o StatusMonitor.zip&& {
    echo "StatusMonitor download\033[32m success\033[0m."
    unzip -oq StatusMonitor.zip
    rm StatusMonitor.zip
} || echo "StatusMonitor download\033[31m failed\033[0m."

### Fetch ReverseNX-RT
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/ReverseNX-RT/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*ReverseNX-RT.zip' | sed 's/"//g')
curl -sL "$download_url" -o ReverseNX-RT.zip&& {
    echo "ReverseNX-RT download\033[32m success\033[0m."
    unzip -oq ReverseNX-RT.zip
    rm ReverseNX-RT.zip
} || echo "ReverseNX-RT download\033[31m failed\033[0m."

### Fetch ldn_mitm
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/ldn_mitm/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*ldn_mitm.zip' | sed 's/"//g')
curl -sL "$download_url" -o ldn_mitm.zip&& {
    echo "ldn_mitm download\033[32m success\033[0m."
    unzip -oq ldn_mitm.zip
    rm ldn_mitm.zip
} || echo "ldn_mitm download\033[31m failed\033[0m."

### Fetch emuiibo
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/emuiibo/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*emuiibo.zip' | sed 's/"//g')
curl -sL "$download_url" -o emuiibo.zip&& {
    echo "emuiibo download\033[32m success\033[0m."
    unzip -oq emuiibo.zip
    rm emuiibo.zip
} || echo "emuiibo download\033[31m failed\033[0m."

### Fetch QuickNTP
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/QuickNTP/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*QuickNTP.zip' | sed 's/"//g')
curl -sL "$download_url" -o QuickNTP.zip&& {
    echo "QuickNTP download\033[32m success\033[0m."
    unzip -oq QuickNTP.zip
    rm QuickNTP.zip
} || echo "QuickNTP download\033[31m failed\033[0m."

### Fetch Fizeau
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/Fizeau/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*Fizeau.zip' | sed 's/"//g')
curl -sL "$download_url" -o Fizeau.zip&& {
    echo "Fizeau download\033[32m success\033[0m."
    unzip -oq Fizeau.zip
    rm Fizeau.zip
    rm config/Fizeau/config.ini
} || echo "Fizeau download\033[31m failed\033[0m."

### Fetch Zing
curl -sL https://raw.githubusercontent.com/huangqian8/SwitchPlugins/main/plugins/Zing.zip -o Zing.zip
if [ $? -ne 0 ]; then
    echo "Zing download\033[31m failed\033[0m."
else
    echo "Zing download\033[32m success\033[0m."
    unzip -oq Zing.zip
    rm Zing.zip
fi

### Fetch lastest sys-tune from https://github.com/HookedBehemoth/sys-tune/releases/latest
# latest_release_info=$(curl -sL https://api.github.com/repos/HookedBehemoth/sys-tune/releases/latest)
# download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-tune[^"]*.zip' | sed 's/"//g')
# curl -sL "$download_url" -o sys-tune.zip&& {
#    echo "sys-tune download\033[32m success\033[0m."
#    unzip -oq sys-tune.zip
#    rm sys-tune.zip
# } || echo "sys-tune download\033[31m failed\033[0m."

### Fetch sys-patch from https://github.com/impeeza/sys-patch/releases/latest
latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/sys-patch/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-patch.zip' | sed 's/"//g')
curl -sL "$download_url" -o sys-patch.zip&& {
    echo "sys-patch download\033[32m success\033[0m."
     unzip -oq sys-patch.zip
    rm sys-patch.zip
} || echo "sys-patch download\033[31m failed\033[0m."

### Fetch sys-clk from https://github.com/retronx-team/sys-clk/releases/latest
# latest_release_info=$(curl -sL https://api.github.com/repos/zdm65477730/sys-clk/releases/latest)
# download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-clk[^"]*.zip' | sed 's/"//g')
# curl -sL "$download_url" -o sys-clk.zip&& {
#    echo "sys-clk download\033[32m success\033[0m."
#    unzip -oq sys-clk.zip
#    rm sys-clk.zip
# } || echo "sys-clk download\033[31m failed\033[0m."

### Fetch sys-clk-oc from https://github.com/halop/OC_Toolkit_SC_EOS/releases/latest
curl -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-clk[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sys-clk-oc.zip
if [ $? -ne 0 ]; then
    echo "sys-clk-oc download\033[31m failed\033[0m."
else
    echo "sys-clk-oc download\033[32m success\033[0m."
    unzip -oq sys-clk-oc.zip
    rm sys-clk-oc.zip
fi

### Fetch lastest OC_Toolkit_SC_EOS from https://github.com/halop/OC_Toolkit_SC_EOS/releases/latest
latest_release_info=$(curl -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest)
download_url_1=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*kip.zip' | sed 's/"//g')
download_url_2=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*OC.Toolkit.u.zip' | sed 's/"//g')
curl -sL "$download_url_1" -o kip.zip&&curl -sL "$download_url_2" -o OC.Toolkit.u.zip&& {
    echo "OC_Toolkit_SC_EOS download\033[32m success\033[0m."
    unzip -oq kip.zip -d ./atmosphere/kips/
    unzip -oq OC.Toolkit.u.zip -d ./switch/.packages/
    rm kip.zip
    rm OC.Toolkit.u.zip
} || echo "OC_Toolkit_SC_EOS download\033[31m failed\033[0m."

### Fetch MissionControl from https://github.com/ndeadly/MissionControl/releases/latest
latest_release_info=$(curl -sL https://api.github.com/repos/ndeadly/MissionControl/releases/latest)
download_url=$(echo "$latest_release_info" | grep -oP '"browser_download_url": "\Khttps://[^"]*MissionControl[^"]*.zip' | sed 's/"//g')
curl -sL "$download_url" -o MissionControl.zip&& {
    echo "MissionControl download\033[32m success\033[0m."
    unzip -oq MissionControl.zip
    rm MissionControl.zip
} || echo "MissionControl download\033[31m failed\033[0m."

###
cat >> ../description.txt << ENDOFFILE
Atmosphere
fusee
Hekate + Nyx CHS
sigpatches
Lockpick_RCM
TegraExplorer
CommonProblemResolver
picofly_toolbox
Switch_90DNS_tester
DBI
Hekate-Toolbox
NX-Activity-Log
JKSV
SimpleModDownloader
SimpleModManager
Moonlight
NX-Shell
daybreak
nx-ovlloader
Ultrahand-Overlay
EdiZon
ovl-sysmodules
StatusMonitor
ReverseNX-RT
ldn_mitm
emuiibo
QuickNTP
Fizeau
Zing
sys-patch
sys-clk-oc
OC_Toolkit_SC_EOS
MissionControl
linkalho-v2.0.1
ENDOFFILE

### Rename hekate_ctcaer_*.bin to payload.bin
find . -name "*hekate_ctcaer*" -exec mv {} payload.bin \;
if [ $? -ne 0 ]; then
    echo "Rename hekate_ctcaer_*.bin to payload.bin\033[31m failed\033[0m."
else
    echo "Rename hekate_ctcaer_*.bin to payload.bin\033[32m success\033[0m."
fi

### Write hekate_ipl.ini in /bootloader/
cat > ./bootloader/hekate_ipl.ini << ENDOFFILE
[config]
autoboot=2
autoboot_list=0
bootwait=3
backlight=100
noticker=0
autohosoff=1
autonogc=1
updater2p=0
bootprotect=0

{大气层-自动识别}
[Fusee]
icon=bootloader/res/icon_ams.bmp
payload=bootloader/payloads/fusee.bin

{大气层-虚拟系统}
[CFW (emuMMC)]
emummcforce=1
fss0=atmosphere/package3
kip1=atmosphere/kips/loader.kip
atmosphere=1
icon=bootloader/res/icon_Atmosphere_emunand.bmp
id=cfw-emu

# {大气层-真实系统}
# [CFW (sysMMC)]
# emummc_force_disable=1
# fss0=atmosphere/package3
# atmosphere=1
# icon=bootloader/res/icon_Atmosphere_sysnand.bmp
# id=cfw-sys

{机身正版系统}
[Stock SysNAND]
emummc_force_disable=1
fss0=atmosphere/package3
icon=bootloader/res/icon_stock.bmp
stock=1
id=ofw-sys
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing hekate_ipl.ini in ./bootloader/ directory\033[31m failed\033[0m."
else
    echo "Writing hekate_ipl.ini in ./bootloader/ directory\033[32m success\033[0m."
fi

### write exosphere.ini in root of SD Card
cat > ./exosphere.ini << ENDOFFILE
[exosphere]
debugmode=1
debugmode_user=0
disable_user_exception_handlers=0
enable_user_pmu_access=0
; 控制真实系统启用隐身模式。
blank_prodinfo_sysmmc=1
; 控制虚拟系统启用隐身模式。
blank_prodinfo_emummc=1
allow_writing_to_cal_sysmmc=0
log_port=0
log_baud_rate=115200
log_inverted=0
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing exosphere.ini in root of SD card\033[31m failed\033[0m."
else
    echo "Writing exosphere.ini in root of SD card\033[32m success\033[0m."
fi

### Write emummc.txt & sysmmc.txt in /atmosphere/hosts
cat > ./atmosphere/hosts/emummc.txt << ENDOFFILE
# 屏蔽任天堂服务器
127.0.0.1 *nintendo.*
127.0.0.1 *nintendo-europe.com
127.0.0.1 *nintendoswitch.*
127.0.0.1 ads.doubleclick.net
127.0.0.1 s.ytimg.com
127.0.0.1 ad.youtube.com
127.0.0.1 ads.youtube.com
127.0.0.1 clients1.google.com
207.246.121.77 *conntest.nintendowifi.net
207.246.121.77 *ctest.cdn.nintendo.net
69.25.139.140 *ctest.cdn.n.nintendoswitch.cn
95.216.149.205 *conntest.nintendowifi.net
95.216.149.205 *ctest.cdn.nintendo.net
95.216.149.205 *90dns.test
ENDOFFILE
cp ./atmosphere/hosts/emummc.txt ./atmosphere/hosts/sysmmc.txt
if [ $? -ne 0 ]; then
    echo "Writing emummc.txt and sysmmc.txt in ./atmosphere/hosts\033[31m failed\033[0m."
else
    echo "Writing emummc.txt and sysmmc.txt in ./atmosphere/hosts\033[32m success\033[0m."
fi

### Write boot.ini in root of SD Card
cat > ./boot.ini << ENDOFFILE
[payload]
file=payload.bin
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing boot.ini in root of SD card\033[31m failed\033[0m."
else
    echo "Writing boot.ini in root of SD card\033[32m success\033[0m."
fi

### Write override_config.ini in /atmosphere/config
cat > ./atmosphere/config/override_config.ini << ENDOFFILE
[hbl_config]
program_id_0=010000000000100D
override_address_space=39_bit
; 按住R键点击相册进入HBL自制软件界面。
override_key_0=R
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing override_config.ini in ./atmosphere/config\033[31m failed\033[0m."
else
    echo "Writing override_config.ini in ./atmosphere/config\033[32m success\033[0m."
fi

### Write system_settings.ini in /atmosphere/config
cat > ./atmosphere/config/system_settings.ini << ENDOFFILE
[eupld]
; 禁用将错误报告上传到任天堂
upload_enabled = u8!0x0

[ro]
; 控制 RO 是否应简化其对 NRO 的验证。
; （注意：这通常不是必需的，可以使用 IPS 补丁。
ease_nro_restriction = u8!0x1

[atmosphere]
; 是否自动开启所有金手指。0=关。1=开。
dmnt_cheats_enabled_by_default = u8!0x0

; 如果你希望大气记住你上次金手指状态，请删除下方；号
; dmnt_always_save_cheat_toggles = u8!0x1

; 如果大气崩溃，10秒后自动重启
; 1秒=1000毫秒，转换16进制
fatal_auto_reboot_interval = u64!0x2710

; 使电源菜单的“重新启动”按钮重新启动到payload
; 设置"normal"正常重启l 设置"rcm"重启RCM，
; power_menu_reboot_function = str!payload

; 启动90DNS与任天堂服务器屏蔽
enable_dns_mitm = u8!0x1
add_defaults_to_dns_hosts = u8!0x1

; 是否将蓝牙配对数据库用与虚拟系统
enable_external_bluetooth_db = u8!0x1

[usb]
; 开启USB3.0，尾数改为0是关闭
usb30_force_enabled = u8!0x1

[tc]
sleep_enabled = u8!0x0
holdable_tskin = u32!0xEA60
tskin_rate_table_console = str!”[[-1000000, 28000, 0, 0], [28000, 42000, 0, 51], [42000, 48000, 51, 102], [48000, 55000, 102, 153], [55000, 60000, 153, 255], [60000, 68000, 255, 255]]”
tskin_rate_table_handheld = str!”[[-1000000, 28000, 0, 0], [28000, 42000, 0, 51], [42000, 48000, 51, 102], [48000, 55000, 102, 153], [55000, 60000, 153, 255], [60000, 68000, 255, 255]]”
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing system_settings.ini in ./atmosphere/config\033[31m failed\033[0m."
else
    echo "Writing system_settings.ini in ./atmosphere/config\033[32m success\033[0m."
fi

### Delete unneeded files
rm -f switch/haze.nro
rm -f switch/reboot_to_payload.nro
rm -f switch/daybreak.nro

# -------------------------------------------

echo ""
echo "\033[32mYour Switch SD card is prepared!\033[0m"