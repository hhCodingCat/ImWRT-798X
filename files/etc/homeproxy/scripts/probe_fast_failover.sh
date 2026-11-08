#!/bin/sh

API="http://127.0.0.1:9090"
CHECK_URL="http%3A%2F%2Fcp.cloudflare.com%2Fgenerate_204"

while true; do
    # 1. 查询当前选中的活动节点
    CURRENT_NOW=$(curl -s -m 1 "$API/proxies/main-out" | tr "," "\n" | grep "\"now\"" | cut -d "\"" -f 4)
    
    if [ -n "$CURRENT_NOW" ]; then
        # 2. 探针测速当前活动节点（超时阈值缩至 1.5s）
        RES=$(curl -s -m 2 "$API/proxies/$CURRENT_NOW/delay?url=$CHECK_URL&timeout=1500")
        
        # 3. 如果当前节点报错（Timeout / Error），立即触发 urltest 重新优选并清空当前节点记录
        if echo "$RES" | grep -qE "Timeout|error|Error|message"; then
            echo "[$(date +%H:%M:%S)] Node $CURRENT_NOW failed: $RES, triggering instant failover!" >> /var/run/homeproxy/failover.log
            curl -s -m 2 "$API/proxies/main-out/delay?url=$CHECK_URL&timeout=1500" >/dev/null 2>&1
        fi
    fi
    sleep 2
done
