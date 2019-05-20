---
theme : "night"
transition: "convex"
highlightTheme: "darkula"
---

## IoTリモコン制作実習

<small>[Masahiro Matsui](https://tech-navy.tech)</small>
<div style='display:inline-block;'>
<p>Github</p>
<a rel='nofollow' href='https://github.com/Koshizuka-lab/2019_DUCRB_Remocon_Project/matsui' style='cursor:default;'><img src='https://chart.googleapis.com/chart?cht=qr&chl=https://github.com/Koshizuka-lab/2019_DUCRB_Remocon_Project/matsui&chs=210x210&choe=UTF-8&chld=L|2' alt='https://phics.tech-navy.tech' title='Service'></a>
</div>
<div style='display:inline-block;'>
<p>Slide</p>
<a rel='nofollow' href='https://matts966.github.io/slides/slides-src/iot2-export/' style='cursor:default'><img src='https://chart.googleapis.com/chart?cht=qr&chl=https%3A%2F%2Fmatts966.github.io%2Fslides%2Fslides-src%2Fiot-export%2F&chs=210x210&choe=UTF-8&chld=L|2' alt='https://matts966.github.io/slides/slides-src/iot2-export/' title='Slide'></a>
</div>

note: 最初のページ。URLのバーコードがあるので画面を長めに表示しておく。

---

### 目次

1. [ライトトグル用リモコン](#/2) 
2. [Elm版Webリモコン](#/3)
3. [環境構築](#/4)
4. [研究の方針](#/5)

---

# やったこと

--

- ライトトグル用リモコン（ラズパイ上）
- Elm版Webリモコン
- ↑が乗る環境の構築
- 研究の方針を考える

---

# Elm版Webリモコン

--

# Elmとは？

--

#### Elm Architecture

![elm_arch.png](./images/elm_arch.png)

---

# 環境構築

--

![iot2-layer.png](./images/iot2-layer.png)

--

- Makefile (webpack、rsync等を自動化)
- ローカルアドレスの付与
- 80版ポートへのバインド
- コンテナ内へのデバイス権限の受け渡し
- コンテナ→Go→Lisp→Server→Elm
- Elmに環境変数をWebpack経由で付与

---

# 研究の方針

---

## 引用

- The Elm Architecture のイメージ図 https://qiita.com/A_kirisaki/items/8fa5563a035c8c4d977c より引用
- ラズベリーパイのロゴは公式サイトから http://www.raspberrypi.org
- docker のロゴは公式サイトから https://www.docker.com/legal
- gopher-front.{ai,svg,png} was created by Takuya Ueda (https://twitter.com/tenntenn). Licensed under the Creative Commons 3.0 Attributions license.
- Elmのロゴは githubより引用 https://github.com/elm/foundation.elm-lang.org/blob/gh-pages/assets/elm_logo.svg
- docker-composeの画像は