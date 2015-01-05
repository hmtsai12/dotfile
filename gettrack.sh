#!/bin/sh

ctags -R
find -depth -type d | grep -v 'svn' > test.vim
sed 's/^\.\//set path+=/' test.vim > workspace.vim
rm test.vim
find -type f | egrep '\.[ch]$|\.cc$|\.cpp$' > cscope.files
cscope -bq

