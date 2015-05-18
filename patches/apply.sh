LOCAL_PATH=../../../..

pre_clean() {
    tmp=$PWD
    cd $1

    git reset --hard > /dev/null
    git clean -fd > /dev/null

    cd $tmp
}

apply() {
    patch -p1 -i $1
    git commit -am "$1"
}

apply_all() {
    tmp=$PWD
    cd $1

    for i in $( ls *.patch )
    do
        echo "applying "$i" for "$1
        apply $i
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
apply_all packages/services/Telecomm
apply_all packages/services/Telephony
apply_all system/core

