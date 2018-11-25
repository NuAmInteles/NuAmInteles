#!/bin/bash

arecord -d 3 -r 16000 -f S16_LE -t wav data/test.wav
docker run --rm -v $(pwd)/data:/workspace/deepspeech.pytorch/data -w /workspace/deepspeech.pytorch deepspeech2.docker python transcribe.py --model-path data/model.pth  --audio-path = data/test.wav