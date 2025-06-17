# 準備
1. ダウンロードして解凍 or cloneする。
2. ダウンロードしたフォルダに入って、コマンドをを実行する。
```
./cp_zsh.zsh
```
3. `.zshrc` をホームディレクトリにコピーする。 (すでに設定がいろいろある場合はコマンドを使わずに自分で調整して追加)
```
cp ./zshrc ~/.zshrc
```
  
4. `source ./zshrc` を実行する。
```
source ./zshrc
```


# 使い方

## ll
`ll` で chmod用の数字 + `ls -al`と同じ機能
見やすくなるように、カラム名等を表示

OCT = chmodのpermissionの数字

白: file
シアン: directory
緑: symbolic link
```
% ll
OCT PERMISSIONS LNK OWNER     GROUP        SIZE UPDATED_AT       NAME
755 drwxr-xr-x    6 MatAtsy   staff         192 2025-01-18 05:40 .
755 drwxr-xr-x    3 MatAtsy   staff          96 2025-01-18 05:19 ..
755 drwxr-xr-x   12 MatAtsy   staff         384 2025-01-18 05:44 .git
644 -rw-r--r--    1 MatAtsy   staff         579 2025-01-18 05:22 .zshrc
755 -rwxr-xr-x    1 MatAtsy   staff        1312 2025-01-18 05:40 cp_zsh.zsh
755 drwxr-xr-x    5 MatAtsy   staff         160 2025-01-18 05:22 zsh
```

## check IP

### ローカルIP(v4)確認 
```
check-local-ip
```

### パブリックIP(v4)確認
```
check-public-ip
```

### 接続状況/ローカルIP/パブリックIPを確認
```
check-network
```


## 補完機能

### ssh
`ssh <TAB>`で出てくる補完を `~/.ssh/config` の `Host` に設定してある項目に制限
