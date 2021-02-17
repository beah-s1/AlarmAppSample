# AlarmAppSample
プッシュ通知を使った目覚ましアプリ ~~（1度のバイブで起きれるわけがない）~~

# Library
- RealmSwift

# Usage
- `git clone`
- Xcode12で開く（Xcode11でも動くかも・・・？）
- ビルドする
- おわり（SwiftPMなので、ライブラリはXcodeが勝手にダウンロードします）

# アプリの使い方

- TableViewで表示しています
![IMG_1022](https://user-images.githubusercontent.com/30878285/108257914-ce9d7b80-71a2-11eb-8c33-023bfaa7b7b2.PNG)

- 右上の「＋」をタップし、時間を選んで「追加する！」をタップすると、通知が予約されます
![IMG_1020](https://user-images.githubusercontent.com/30878285/108257942-d78e4d00-71a2-11eb-804e-0f9f735d8a53.PNG)

- こんな感じになります
![IMG_1018](https://user-images.githubusercontent.com/30878285/108257954-da893d80-71a2-11eb-80ed-9bd693e4a9c4.PNG)

- スワイプで削除できます（通知もされなくなります）
![IMG_1021](https://user-images.githubusercontent.com/30878285/108257919-d0ffd580-71a2-11eb-80fe-bcc436f7d91b.PNG)

# Xcodeの対応について
- Swift Package Managerがまともに使えるのがXcode11≤なので、Xcode10.2などはCocoaPodsを使う必要があります。
- Realmの使い方自体は変わっていないので、ViewControllerのロジックなどはそっくりそのままコピペで動くと思います。
