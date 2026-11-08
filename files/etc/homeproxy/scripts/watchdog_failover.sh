#!/bin/sh

LOG_FILE="/var/run/homeproxy/sing-box-c.log"
API_URL="http://127.0.0.1:9090/proxies/main-out/delay?url=http%3A%2F%2Fcp.cloudflare.com%2Fgenerate_204&timeout=2000"

[ -f "$LOG_FILE" ] || exit 0

tail -Fn 0 "$LOG_FILE" 2>/dev/null | while read -r line; do
    case "$line" in
        *"connection reset by peer"*|*"context deadline exceeded"*|*"broken pipe"*|*"handshake timeout"*)
            # 遇到报错立即对当前 main-out 测速触发秒级切换
            curl -s -m 3 "$API_URL" >/dev/null 2>&1 &
            ;;
    esac
done
