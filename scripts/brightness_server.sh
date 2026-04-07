#!/bin/bash
# 保存为 brightness_server.sh，运行后提供 HTTP 服务
# 需要安装 brightnessctl
while true; do
    echo -e "HTTP/1.1 200 OK\n\n$(brightnessctl g)" | nc -l -p 8080 -q 1
done
