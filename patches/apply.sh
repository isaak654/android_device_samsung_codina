LOCAL_PATH=../../../..

pre_clean() {
    tmp=$PWD
    cd $1

    git reset --hard
    git clean -fd
    git am --abort

    cd $tmp
}

apply_all() {
    tmp=$PWD
    cd $1

    for i in $( ls *.patch )
    do
        echo "applying "$i" for "$1
        git am $i
    done
 
    cd $tmp
}

# pre clean 

echo "get rid of any uncommitted or unstaged changes"

pre_clean bionic
pre_clean build
pre_clean frameworks/av/
pre_clean frameworks/base/
pre_clean frameworks/native/
pre_clean frameworks/opt/net/wifi/
pre_clean frameworks/opt/telephony/
pre_clean packages/apps/Bluetooth/
pre_clean packages/apps/Settings/
pre_clean packages/services/Telecomm
pre_clean packages/services/Telephony
pre_clean system/core


# copy patches
cp -r * $LOCAL_PATH 
cd $LOCAL_PATH

# now apply it 

apply_all bionic 
apply_all build
apply_all frameworks/av/
apply_all frameworks/base/
apply_all frameworks/native/
apply_all frameworks/opt/net/wifi/
apply_all frameworks/opt/telephony/
apply_all packages/apps/Bluetooth/ 
apply_all packages/apps/Settings/
apply_all packages/services/Telecomm
apply_all packages/services/Telephony
apply_all system/core

