# ~/.config/zsh/completions.zsh - 補完設定

# SSH補完の設定
_setup_ssh_completion() {
    # 既存のSSH補完を無効化
    zstyle ':completion:*:ssh:*' hosts
    zstyle ':completion:*:ssh:*' users
    zstyle ':completion:*:scp:*' hosts
    zstyle ':completion:*:scp:*' users
    
    # カスタムSSH補完を設定
    compdef _ssh_config_completion ssh
}

# SSH設定ファイルからホスト名を取得する補完関数
_ssh_config_completion() {
    local -a config_hosts
    local ssh_config="${HOME}/.ssh/config"
    
    if [[ -f "$ssh_config" ]]; then
        # SSH設定ファイルからHost行を抽出（ワイルドカードを除く）
        config_hosts=($(awk '/^Host / && !/\*/ {for(i=2;i<=NF;i++) print $i}' "$ssh_config"))
    fi
    
    _describe 'ssh hosts' config_hosts
}

# 補完設定を適用
_setup_ssh_completion
