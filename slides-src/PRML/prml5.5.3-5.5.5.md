---
title: "PRML 5.5.3 ~ 5.5.5"
---

# PRML勉強会

1. [5.5.3 不変性](#/1)
2. [5.5.4 接線伝播法](#/2)
3. [5.5.5 変換されたデータを用いた訓練](#/3)

---

## 5.5.3 不変性

<img src="./images/prml/Figure5.14.png" style="max-width:60%;background:white;" alt="figure5.14">


---

## 5.5.4 接線伝播法

<img src="./images/prml/Figure5.15.png" style="max-width:60%;background:white;" alt="figure5.15">


- a
  - 元画像
- b
  - 無限小の時計回りの回転に対する接ベクトル $\tau$ （<span style="color:blue">正</span>, <span style="color:yellow">負</span>）
- c
  - $\epsilon=15^\circ$として、 $x+\epsilon\tau$
- d
  - 回転させた真の画像

<div style='display:inline;'>
<img src="./images/prml/Figure5.16a.png" style="max-width:40%;background:white;" alt="figure5.16a">
</div>
<div style='display:inline;'>
<img src="./images/prml/Figure5.16b.png" style="max-width:40%;background:white;" alt="figure5.16b">
</div>

<div style='display:inline;'>
<img src="./images/prml/Figure5.16c.png" style="max-width:40%;background:white;" alt="figure5.16c">
</div>
<div style='display:inline;'>
<img src="./images/prml/Figure5.16d.png" style="max-width:40%;background:white;" alt="figure5.16d">
</div>

---

## 5.5.5 変換されたデータを用いた訓練
