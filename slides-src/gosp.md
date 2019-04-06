---
theme : "night"
transition: "convex"
highlightTheme: "darkula"
---

## Go言語でLispインタプリタを書こう

<div style='display:inline-block;'>
<p>source code</p>
<a rel='nofollow' href='https://github.com/Matts966/gosp' style='cursor:default;'><img src='https://chart.googleapis.com/chart?cht=qr&chl=https://github.com/Matts966/gosp&chs=210x210&choe=UTF-8&chld=L|2' alt='https://github.com/Matts966/gosp' title='gosp'></a>
</div>
<div style='display:inline-block;'>
<p>Slide</p>
<a rel='nofollow' href='https://matts966.github.io/slides/slides-src/gosp-export/' style='cursor:default'><img src='https://chart.googleapis.com/chart?cht=qr&chl=https%3A%2F%2Fmatts966.github.io%2Fslides%2Fslides-src%2Fgosp-export%2F&chs=210x210&choe=UTF-8&chld=L|2' alt='https://matts966.github.io/slides/slides-src/gosp-export/' title='Slide'></a>
</div>

<small>Masahiro Matsui</small>

---

### 目次

1. [概要](#/2) 
2. [楽しいところ](#/3)
3. [TODO](#/4)
4. [おまけ](#/5)

---

# 概要

---

# 楽しいところ

--

#### ポインタも実体も投げられる魔法のコード

- `Go` はポインタ型でもインターフェースはそのまま使える
- その結果、構造体はポインタで、 `interface` はそのままで渡したいときなどに
  - タイプスイッチでポインタと実体それぞれについて書く必要...
  - 実体をたぐるときに `panic` する可能性を常に考慮する必要... が生じる

--

#### ポインタも実体も投げられる魔法のコード

全部無視して以下のコードから `interface` 型を取得し、タイプスイッチに渡せば良い！

```go
reflect.Indirect(reflect.ValueOf(pointerOrWhatever)).Interface()
```

---

# おまけ

--


goの中でLispが書ける！


---

### ありがとうございました 🎉

--

## 質問（あれば）