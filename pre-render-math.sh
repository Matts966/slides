#!/bin/bash
./node_modules/mathjax-node-page/bin/mjpage \
    --output CommonHTML --dollars true \
    < $1
