#!/bin/sh

ctags -R
find -depth -type d | egrep -v '\./.git|\./SDK' > test.vim
sed 's/^\.\//set path+=/' test.vim > workspace.vim
rm test.vim
find -type f | egrep '\.[ch]$|\.cc$|\.cpp$|\.mk$' > cscope.files.out
egrep -v '\./.git|\./SDK' cscope.files.out > cscope.files
cscope -bq
rm cscope.files.out
