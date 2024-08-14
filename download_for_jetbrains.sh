#!/bin/bash


#wget  wget https://download.jetbrains.com/idea/code-with-me/backend/jetbrains-clients-downloader-linux-x86_64-1867.tar.gz
#tar -xvf jetbrains-clients-downloader-linux-x86_64-1867.tar.gz

cd /data/misc/codewithme/out/jetbrains-clients-downloader-linux-x86_64-1867/bin

echo "************* Downloading Code With Me clients *************"

# JetBrains Products Codes:
# IU - IntelliJ IDEA Ultimate
# IC - IntelliJ IDEA Community
# IE - IntelliJ IDEA Educational
# PS - PhpStorm
# WS - WebStorm
# PY - PyCharm Professional         <---- Download
# PC - PyCharm Community            <---- Download
# PE - PyCharm Educational
# RM - RubyMine                     <---- Download
# OC - AppCode
# CL - CLion                        <---- Download
# GO - GoLand
# DB - DataGrip
# RD - Rider
# AI - Android Studio

#./jetbrains-clients-downloader -verbose --platforms-filter linux-x64,windows-x64 --versions-filter 2021.3+ --products-filter CL,PC,PY,RM  /data/misc/codewithme/tmp
./jetbrains-clients-downloader -verbose --versions-filter 2024.1+ --platforms-filter linux-x64,windows-x64 --products-filter CL,PC,PY,RM,RR  /data/misc/codewithme/tmp
./jetbrains-clients-downloader -verbose --versions-filter 2024.1+ --platforms-filter linux-x64 --products-filter CL,PC,PY,RM,RR  --download-backends /data/misc/codewithme/tmp