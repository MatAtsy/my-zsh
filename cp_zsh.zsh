#!/bin/zsh

# コピー元ディレクトリ
SOURCE_DIR="./zsh"
# コピー先ディレクトリ
DEST_DIR="${HOME}/.config/zsh"

echo "Zsh 設定ファイルのコピーを開始します。"

# ~/.config/zsh ディレクトリが存在するか確認し、なければ作成
if [ ! -d "${DEST_DIR}" ]; then
  echo "${DEST_DIR} が存在しません。作成します..."
  mkdir -p "${DEST_DIR}"
  if [ $? -ne 0 ]; then
    echo "エラー: ${DEST_DIR} の作成に失敗しました。"
    exit 1
  fi
else
  echo "${DEST_DIR} は既に存在します。"
fi

# コピー元ディレクトリが存在するか確認
if [ ! -d "${SOURCE_DIR}" ]; then
  echo "エラー: コピー元のディレクトリ ${SOURCE_DIR} が見つかりません。"
  exit 1
fi

# ./zsh 配下のファイルを ~/.config/zsh にコピー（上書き）
echo "${SOURCE_DIR} から ${DEST_DIR} へファイルをコピーします..."
cp -v "${SOURCE_DIR}"/* "${DEST_DIR}/"

if [ $? -eq 0 ]; then
  echo "Zsh 設定ファイルのコピーが完了しました。"
else
  echo "エラー: ファイルのコピー中に問題が発生しました。"
  exit 1
fi

echo "メインのzshrcファイルは手動で ${HOME}/.zshrc に移動させてください。（このスクリプトでは ${HOME}/.zshrc は扱いません）"
