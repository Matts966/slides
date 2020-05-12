#!/bin/bash

file=$1
if [[ ! -f $file ]] || [[ $# -ne 1 ]]; then
    echo "Please specify only 1 path to html."
    exit 1
fi

# Use common libs on root.
rm -rf $(dirname $1)/libs
sed -i '' "s/\"libs\/reveal\.js/\"\/slides\/libs\/reveal\.js/g" $1
sed -i '' "s/\'libs\/reveal\.js/\'\/slides\/libs\/reveal\.js/g" $1

# Render math.
tmp=$(mktemp)
./node_modules/mathjax-node-page/bin/mjpage \
    --output CommonHTML --dollars true \
    < $1 > $tmp
cat $tmp > $1
