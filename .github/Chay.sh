#chamchamfy
export TOME="$GITHUB_WORKSPACE"
export User="User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36"
sudo apt-get update >/dev/null
sudo apt-get install curl binutils zipalign p7zip >/dev/null

sudo rm -rf /usr/share/dotnet
sudo rm -rf /opt/ghc
sudo rm -rf "/usr/local/share/boost"
sudo rm -rf "$AGENT_TOOLSDIRECTORY"
mkdir -p $TOME/NN $TOME/apktoolcc $TOME/DE $TOME/unsign $TOME/signed/apk; 
DE=$TOME/DE; 
chmod -R 777 .github/*.sh >/dev/null

Xem () { curl -s -G -L -N -H "$User" --connect-timeout 20 "$1"; }
Taive () { curl -L -N -H "$User" --connect-timeout 20 "$1" -o "$2"; }
apktoolc() { cd $TOME/apktoolcc/lib 2>/dev/null; java -Xmx1024M -Dfile.encoding=utf-8 -Djdk.util.zip.disableZip64ExtraFieldValidation=true -Djdk.nio.zipfs.allowDotZipEntry=true -jar $TOME/apktoolcc/lib/apktool_2.9.0.jar.jar -p $TOME/apktoolcc "$@"; } 
apksigner() {  cd $TOME/apktoolcc/lib 2>/dev/null; java -Xmx1024M -Dfile.encoding=utf-8 -jar $TOME/apktoolcc/lib/apksigner.jar sign --cert x509 --key cert --v4-signing-enabled "$@"; } 

echo "▼ Tên máy chủ"
uname -a
echo

Taive "https://github.com/chamchamfy/MIUI-14-XML-Vietnamese/archive/master.zip" "$TOME/NN.zip"
7za x -y -tzip $TOME/NN.zip -o$TOME/NN >/dev/null 2>&1
cp -af $TOME/NN/*/*/main/* $TOME/NN 2>/dev/null
rm -rf $TOME/NN/*/res/*mnc01-vi $TOME/NN/*/res/*mnc02-vi $TOME/NN/*/res/*mnc03-vi 2>/dev/null
sed -i 's/````//g' $TOME/NN/*/res/*/*.xml >/dev/null 2>&1 

tar -xJf $TOME/apktoolcc.so -C $TOME/apktoolcc 2>/dev/null
Taive "https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.9.0.jar" "$TOME/apktoolcc/lib/apktool_2.9.0.jar"
7za x -y -tzip $TOME/apktoolcc/lib/apktool_2.9.0.jar -o$TOME/PB >/dev/null 2>&1
vapk=$(grep 'application.version' $TOME/PB/properties/apktool.properties | awk -F= '{print $2}')
7za x -y -tzip $TOME/overlay.zip -o$TOME/VH >/dev/null 2>&1
taott() {
echo "version: $vapk
apkFileName: $ten.apk
isFrameworkApk: false
usesFramework:
  ids:
  - 1
  tag: null
sdkInfo:
packageInfo:
  forcedPackageId: 127
  renameManifestPackage: null
versionInfo:
  versionCode: 2194
  versionName: 21.9.4
resourcesAreCompressed: false
sharedLibrary: false
sparseResources: false
doNotCompress:
- resources.arsc" > $DE/$ten.apk/apktool.yml
tengoi=$(grep 'package=' $DE/$ten.apk/AndroidManifest.xml | awk '{print $8}' | awk -F'"' '{print $2}')
echo '<?xml version="1.0" encoding="utf-8" standalone="no"?><manifest xmlns:android="http://schemas.android.com/apk/res/android" android:compileSdkVersion="31" android:compileSdkVersionCodename="12" package="cc.tengoi.overlay" platformBuildVersionCode="27" platformBuildVersionName="8.1.0">
    <application android:extractNativeLibs="false"/>
    <overlay android:isStatic="true" android:priority="999" android:targetPackage="tengoi"/>
</manifest>' > $DE/$ten.apk/AndroidManifest.xml
sed -i "s/tengoi/$tengoi/g" $DE/$ten.apk/AndroidManifest.xml
}
tusualoi() {
sed -i '/APKTOOL_DUMMY/d' $DE/$ten.apk/res/*/*.xml >/dev/null 2>&1 
log=$DE/log/$ten.log
if [ -f $log ]; then 
kiem() {
sed -i "/Originally defined here/d; /Error parsing XML/d" $log
tt=$(grep ': error:' $log | awk '{print $2}' | awk -F: '{print $1}' | sed -n 1p)
ss=$(grep ': error:' $log | awk -F: '{print $3}' | tr -d '[a-z][A-Z]' | sort -u | sort -nr)
for xs in $ss; do sed -i "${xs}d" $tt; sed -i "/:${xs}:/d" $log; done
}
kiem
[ -n "$ss" ] && echo "  >> Tự sửa lỗi..." && kiem
[ -n "$tt" ] && [ -z "$(grep '</resources>' $tt)" ] && echo '</resources>' >> $tt; 
fi
}
tuchay() { 
solan=$((solan+1))
tusualoi 
apktoolc b -s -f 31 $DE/$ten.apk -o $TOME/unsign/$ten.apk 2>&1 | tee $DE/log/$ten.log; 
if [ -f $TOME/unsign/$ten.apk -a -z "$(grep 'exit code' $DE/log/$ten.log)" ]; then 
apksigner --in $TOME/unsign/$ten.apk --out $TOME/signed/apk/cc.$ten.apk && rm -f $TOME/signed/apk/cc.$ten.apk.idsig 2>/dev/null && echo " Đã xong !"; 
[ -f $TOME/signed/apk/$ten.apk ] && echo -e " $Ye Hoàn thành!" && rm -rf $DE/$ten.apk $DE/log/$ten.log || echo -e " $Ye Xử lý bị lỗi!"; 
unset solan
else 
[ "$solan" -lt 10 ] && tuchay 
fi
} 

cd $TOME/VH/apk
for c in *.apk; do mv -f $c ${c//cc./}; done 
for tenapk in *.apk; do
ten=${tenapk%.apk} 
apktoolc d -f -s $ten.apk -o $DE/$ten.apk 
cp -af $TOME/NN/$ten.apk/* $DE/$ten.apk 2>/dev/null
taott
tuchay
done
mv -f $TOME/signed/apk $TOME/.github
echo "- Kết thúc"
