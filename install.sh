#!/bin/sh

PACKAGE_PATH="$1"
SETUP_PATH="/usr/local/bin/"
FW_NAME="hi"

echo "start installing $FW_NAME..."

if [ -n "$PACKAGE_PATH" ];then
	PACKAGE_PATH="${PACKAGE_PATH}/$FW_NAME" #add sub folder for $FW_NAME 
   echo "use defined PATH: "${PACKAGE_PATH}
else
   PACKAGE_PATH="/usr/local/$FW_NAME"
   echo "use default PATH: ${PACKAGE_PATH}"
fi

mkdir -p $PACKAGE_PATH
mkdir -p $SETUP_PATH

rm -rf $SETUP_PATH/$FW_NAME
rm -rf $PACKAGE_PATH/*


echo "install $FW_NAME cli to $SETUP_PATH"

echo "#!/bin/sh" > tmp_work_bin
echo "FW_PACKAGE_PATH=$PACKAGE_PATH" >> tmp_work_bin
echo "if [ \"\$1\" = \"path\" ] " >> tmp_work_bin #space should be @ both side of ==
echo "then " >> tmp_work_bin
echo "echo \"\$FW_PACKAGE_PATH\" " >> tmp_work_bin
echo "else" >> tmp_work_bin
echo "exec 'luajit' -e 'package.path=\"$PACKAGE_PATH/?.lua;$PACKAGE_PATH/?/init.lua\"; package.cpath=\"$PACKAGE_PATH/?.so\"' '$PACKAGE_PATH/bin/$FW_NAME' \"\$@\"">>tmp_work_bin
echo "fi ">> tmp_work_bin

mv tmp_work_bin $SETUP_PATH/$FW_NAME
chmod 755 $SETUP_PATH/$FW_NAME

echo "install $FW_NAME package to $PACKAGE_PATH"
cp -a ./* $PACKAGE_PATH/

echo "$FW_NAME framework installed."
