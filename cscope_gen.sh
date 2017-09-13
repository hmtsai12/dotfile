#!/bin/bash

MAIN_PATH=`pwd`
CSCOPE_FILELIST="cscope.files"
# include related files that match regex pattern
CSCOPE_PATTERN='\(.*Makefile.*\|.*\.\(c\|h\|s\|S\|cpp\|hpp\|ld\|lds\)\)'
CSCOPE_COMMON_FLAG="-type f -regex $CSCOPE_PATTERN"

echo -e ""
echo -e "\t\e[1;49;32mPATH\e[0m: \e[93m$MAIN_PATH\e[0m"
echo -e "\t\e[1;49;32mFile List\e[0m: \e[93m$CSCOPE_FILELIST\e[0m"
echo -e ""

echo -e "\t\e[96mCollecting file list ...\e[0m"
find $MAIN_PATH -maxdepth 1 $CSCOPE_COMMON_FLAG > $MAIN_PATH/$CSCOPE_FILELIST
find $MAIN_PATH/Source/ $CSCOPE_COMMON_FLAG >> $MAIN_PATH/$CSCOPE_FILELIST

echo -e "\t\e[96mGenerating cscope database ...\e[0m"
cscope -bkqR -i$MAIN_PATH/$CSCOPE_FILELIST
echo -e "\t\e[96mDone!\e[0m"
echo -e ""
