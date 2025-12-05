#!/bin/bash

### 1. 建立 .env （如果不存在）
if [ ! -f .env ]; then
    echo "CLOUDFLARE_TUNNEL_TOKEN=" > .env
    echo ".env 已建立"
else
    echo ".env 已存在，略過建立"
fi


### 2. Clone TennisProject（如果不存在）
if [ ! -d "TennisProject" ]; then
    git clone https://github.com/violetzu/TennisProject.git
else
    echo "TennisProject 目錄已存在，略過 git clone"
fi

### 3. Build TennisProject docker
if [ -d "TennisProject" ]; then
    cd TennisProject
    docker build -f docker/Dockerfile -t tennis:latest .
    cd ..
else
    echo "找不到 TennisProject，無法 build"
fi


### 4. Clone qwen3-vl（如果不存在）
if [ ! -d "qwen3-vl" ]; then
    git clone https://github.com/violetzu/qwen3-vl.git
else
    echo "qwen3-vl 目錄已存在，略過 git clone"
fi

### 5. Build qwen3-vl docker
if [ -d "qwen3-vl" ]; then
    cd qwen3-vl
    docker build -f docker/Dockerfile -t qwen3vl:latest .
    cd ..
else
    echo "找不到 qwen3-vl，無法 build"
fi


### 6. 啟動 docker-compose
if [ -f docker-compose.yml ]; then
    docker-compose up -d
else
    echo "找不到 docker-compose.yml，無法啟動"
fi
