# executer pour compilation

clear

cd /Users/mattlawer/Desktop/Developer/iPhone/JBDev/Tweaks/nccleaner/
#ln -s /Users/mattlawer/Desktop/Developer/iPhone/JBDev/theos ./theos

make -f Makefile

cp ./control ./layout/DEBIAN

mkdir -p ./layout/Library/MobileSubstrate/DynamicLibraries
cp ./NCCleaner.plist ./layout/Library/MobileSubstrate/DynamicLibraries
cp ./obj/NCCleaner.dylib ./layout/Library/MobileSubstrate/DynamicLibraries

sudo find ./ -name ".DS_Store" -depth -exec rm {} \;

export COPYFILE_DISABLE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true

dpkg-deb -b layout
mv ./layout.deb ./NCCleaner.deb


