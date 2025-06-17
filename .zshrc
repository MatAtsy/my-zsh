# ~/.zshrc - メイン設定ファイル

# 補完システムの初期化
autoload -U compinit
# -D: 安全でないディレクトリ/ファイルのチェックを無視
# -i: ダンプファイル(.zcompdump)を無条件で再生成する
compinit -D -i

# 設定ディレクトリのパス
ZSHRC_DIR="${HOME}/.config/zsh"

# 設定ファイルを順次読み込み
source "${ZSHRC_DIR}/ll-function.zsh"   # 高機能lsコマンド
source "${ZSHRC_DIR}/network-utils.zsh" # ネットワーク関連ユーティリティ
source "${ZSHRC_DIR}/completions.zsh"   # 補完設定
