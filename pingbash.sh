#!/bin/bash

read -p "Enter the host to ping: " host
loss_count=0
while true; do
output=$(ping -n 1 -w 1000 "$host" 2>/dev/null)
 if echo "$output" | grep -q "TTL="; then
        loss_count=0
        ping_time=$(echo "$output" | grep -oE "[0-9]+ms" | head -1 | tr -d "ms")
        echo "Ping: ${ping_time} ms"
 if [ "$ping_time" -gt 100 ]; then
            echo "Ping time exceeds 100 ms!"
        fi
    else
((loss_count++))
        echo "Ping failed $loss_count/3 times"
    fi
 if [ "$loss_count" -ge 3 ]; then
        echo "Ping has failed 3 times in a row!"
        loss_count=0
    fi
 sleep 1
done


