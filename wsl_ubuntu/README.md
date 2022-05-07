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

- hwclockがパスワード不要で呼べるようにする
- cronからhwclockを自動で呼ぶ
