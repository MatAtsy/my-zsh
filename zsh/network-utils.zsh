# ~/.config/zsh/network-utils.zsh - ネットワーク関連ユーティリティ

# パブリックIPアドレスを確認
check-public-ip() {
    echo "Checking public IP address..."
    
    # 複数のサービスを試行（フォールバック機能付き）
    local services=(
        "http://checkip.amazonaws.com/"
        "https://ipinfo.io/ip"
        "https://icanhazip.com/"
        "https://ifconfig.me/ip"
    )
    
    for service in "${services[@]}"; do
        echo "Trying: $service"
        if ip=$(curl -s --connect-timeout 5 --max-time 10 "$service" 2>/dev/null); then
            if [[ -n "$ip" && "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                echo "Public IP: $ip"
                return 0
            fi
        fi
    done
    
    echo "Failed to retrieve IP address from all services"
    return 1
}

# ローカルIPアドレスを確認
check-local-ip() {
    echo "Local IP addresses:"
    
    # macOS用の設定
    if command -v ifconfig >/dev/null 2>&1; then
        ifconfig | grep "inet " | grep -v "127.0.0.1" | while read -r line; do
            ip=$(echo "$line" | awk '{print $2}')
            interface=$(echo "$line" | awk '{print $NF}' 2>/dev/null || echo "unknown")
            echo "  $ip"
        done
    elif command -v ip >/dev/null 2>&1; then
        # Linux用の設定
        ip addr show | grep "inet " | grep -v "127.0.0.1" | while read -r line; do
            ip=$(echo "$line" | awk '{print $2}' | cut -d'/' -f1)
            echo "  $ip"
        done
    else
        echo "Network tools not available"
        return 1
    fi
}

# ネットワーク接続の基本チェック
check-network() {
    echo "Network connectivity check:"
    
    # インターネット接続チェック
    if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
        echo "✓ Internet connectivity: OK"
    else
        echo "✗ Internet connectivity: Failed"
    fi
    
    # DNS解決チェック
    if nslookup google.com >/dev/null 2>&1; then
        echo "✓ DNS resolution: OK"
    else
        echo "✗ DNS resolution: Failed"
    fi
    
    # ローカルネットワークの表示
    echo ""
    check-local-ip
    
    # パブリックIPの表示
    echo ""
    check-public-ip
}
