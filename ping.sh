#!/bin/bash

target="$1"
consecutive_failures=0

echo "Start pinging $target..."

while true; do
    ping_result=$(ping -c 1 "$target" | grep 'time=' | awk '{print $7}' | cut -d '=' -f2)
    if [[ -n "$ping_result" ]]; then
        echo "Ping to $target successful. Time: ${ping_result}ms"
        consecutive_failures=0
    else
        echo "Ping to $target failed."
        ((consecutive_failures++))
    fi

    if ((consecutive_failures >= 3)); then
        echo "Failed to ping $target for 3 consecutive times."
        break
    fi

    sleep 1
done
