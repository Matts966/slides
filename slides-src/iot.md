---
theme : "night"
transition: "convex"
highlightTheme: "darkula"
---

## 総合情報学実習

#### APIを使用した自動制御

<small>[Masahiro Matsui](https://tech-navy.tech)</small>
<div style='display:inline-block;'>
<p>Github</p>
<a rel='nofollow' href='https://github.com/matts966/iot' style='cursor:default;'><img src='https://chart.googleapis.com/chart?cht=qr&chl=https%3A%2F%2Fgithub.com%2Fmatts966%2Fiot%2F&chs=210x210&choe=UTF-8&chld=L|2' alt='https://phics.tech-navy.tech' title='Service'></a>
</div>
<div style='display:inline-block;'>
<p>Slide</p>
<a rel='nofollow' href='https://matts966.github.io/slides/slides-src/iot-export/' style='cursor:default'><img src='https://chart.googleapis.com/chart?cht=qr&chl=https%3A%2F%2Fmatts966.github.io%2Fslides%2Fslides-src%2Fiot-export%2F&chs=210x210&choe=UTF-8&chld=L|2' alt='https://matts966.github.io/slides/slides-src/iot-export/' title='Slide'></a>
</div>

note: 最初のページ。URLのバーコードがあるので画面を長めに表示しておく。

---

## 目次

1. [実習の目的](#/2) 
2. [システムの概要](#/3)
3. [isaax](#/4)
4. [実装の概要](#/5)
5. [エアコン制御](#/6)
6. [今後の課題](#/7)

---

### 実習の目的

- 研究室の体験
- ラズパイでIoTを体験してみる
- 研究室のAPIを使ってみる
- あわよくば研究のテーマ案を見つける

---

## システムの概要

- 人感センサーをつかって電灯の自動制御を行う。
- 電灯がついている状態の場合、一定時間人の動きがないと消灯する。
- 電灯がついていない状態の場合、動きがあればすぐに電灯をつける。


---

## isaax

<img src="images/isaax_logo_vector.svg" style="max-width:40%;" alt="isaax_logo">

デプロイの管理、簡易化のために使用。

--

## isaax 

- `git push` だけで自動でデプロイされる。
    - → Version管理しながら楽に実験できる。
    - → コードをGithub管理する必要がある。
- ラズパイでisaax用のプロセスを立ち上げておくと、デプロイ → 設定したエントリポイントが実行される。
- デプロイ対象が増えると有料枠になる。小規模だと無料で済む。

--

## Githubでの管理

- `dotenv` を用いてAPIの認証情報などはアップロードしないようにした。
- `Python2系` の `dotenv` は動かないのでインストール後動くように書き換える必要がある。　

---

## 実装の概要

- 人感センサーを使って半径7ｍの動きを検知
- 一定時間動きがないとセンサー出力値が変動
- 動きがあるとセンサー出力値が変動
- Callbackでそれぞれに必要な処理を渡す。

--

## 実装の概要

### エントリポイント

```Python
def main():
    ms = motion_sensor.motion_sensor(
        delay_from_last_motion = datetime.timedelta(seconds=3),
        on_callback = control_light.light_on,
        off_callback = control_light.light_off
    )
    ms.start()
```

--

## 実装の概要

### エントリポイント

```Python
def main():
    ms = motion_sensor.motion_sensor(
        delay_from_last_motion = datetime.timedelta(seconds=3),
        on_callback = control_light.light_on,
        off_callback = control_light.light_off
    )
    ms.start()
```

- `on_callback` : 電灯をつけるAPIを呼ぶ関数
- `off_callback` : 消灯するAPIを呼ぶ関数

--

## 実装の概要

### エントリポイント

```Python
def main():
    ms = motion_sensor.motion_sensor(
        delay_from_last_motion = datetime.timedelta(seconds=3),
        on_callback = control_light.light_on,
        off_callback = control_light.light_off
    )
    ms.start()
```

- センサークラスを作成して、センサー自体の動きの有無に関する閾値に加えて、
`off_callback` を呼ぶまでの待機時間を設定できるようにした。

---

## エアコン制御

このシステムにエアコンの管理機能もいれたい

→どうなるか？

--



---

## 今後の課題 -状態管理-


---

## ありがとうございました！

川上さん、お世話になりました 🙇‍♂️