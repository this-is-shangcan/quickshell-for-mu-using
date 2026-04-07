#!/bin/bash
# 需要 power-profiles-daemon 运行中
while true; do
    echo -e "HTTP/1.1 200 OK\n\n$(powerprofilesctl get)" | nc -l -p 8082 -q 1
done
