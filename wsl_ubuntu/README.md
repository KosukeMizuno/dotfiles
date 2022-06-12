# 設定ファイル管理

https://qiita.com/bezeklik/items/a66f1cfdba7fb4e368f6
```sh
sudo apt install etckeeper
sudo etckeeper init
```

# /etc/wsl.conf の設定

https://scratchpad.jp/ubuntu-on-windows11-11/

- [x] PATHを引き継がないようにする
- [ ] cronを初めから立ち上がるようにする
  - 再起動してもcronが走ってない。。なぜ？

# hwclockを自動化

https://zenn.dev/kaityo256/articles/wsl_cron_hwclock

- [x] hwclockがパスワード不要で呼べるようにする
- [x] cronからhwclockを自動で呼ぶ

# WSL側から利用するWindowsバイナリのPATHを設定

Windows側の`$PREFIX/bin_wsl`に使いたいバイナリorそれへのリンクを設置する
- vscode
- gocopy
- gopaste
など

以下のようにシステム環境変数を設定
- `PATH_TO_WSL=$PREFIX/bin_wsl`
- `WSLENV=PATH_TO_WSL/ul`

注意：
Windows側のフォルダをPATHに含めると補完が重くなるので、aliasをひとつずつ貼っている。新しく追加するときは`sh/path.sh`の変更が必要となる。
`PATH_TO_WSL`を設定しているのは、Windows側のホームフォルダの場所をどうやって得るか知らなかったのでこうしてみた。

TODO: `WSLENV=USERPROFILE/ul`として引き継げる事に気づいたけどめんどいのでそのうち書き換える

参考：https://docs.microsoft.com/ja-jp/windows/wsl/filesystems#wslenv-flags
