#!/bin/bash
FILES=/home/dev/repos/nuaminteles/files/*
for f in $FILES
do
  ffmpeg -i $f -ar 16000 ./converted/$f
done
