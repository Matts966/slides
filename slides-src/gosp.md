---
theme : "night"
transition: "convex"
highlightTheme: "darkula"
---

### Go言語で書くLispインタプリタ

<div style='display:inline-block;'>
<p>Code</p>
<a rel='nofollow' href='https://github.com/Matts966/gosp' style='cursor:default;'><img src='https://chart.googleapis.com/chart?cht=qr&chl=https://github.com/Matts966/gosp&chs=210x210&choe=UTF-8&chld=L|2' alt='https://github.com/Matts966/gosp' title='gosp'></a>
</div>
<div style='display:inline-block;'>
<p>Slide</p>
<a rel='nofollow' href='https://matts966.github.io/slides/slides-src/gosp-export/' style='cursor:default'><img src='https://chart.googleapis.com/chart?cht=qr&chl=http://matts966.github.io/slides/slides-src/gosp-export/&chs=210x210&choe=UTF-8&chld=L|2' alt='https://matts966.github.io/slides/slides-src/gosp-export/' title='Slide'></a>
</div>

<small>Masahiro Matsui</small>

---

### 目次

1. [概要](#/2)
2. [ポインタ渡し/値渡し](#/3)
3. [苦労した点](#/4)
4. [TODO](#/5)
5. [おまけ](#/6)

---

## 概要

### やったこと

Rui ueyamaさんの `minilisp` を参考にミニマムなLispを~~書いた~~（書こうとした）

--

### Lispとは？

<p class="fragment">
![alien](./images/lisplogo_alien_256.png)
</p>

--

### Lispとは？

```lisp
(defun fact (n)
   (if (= n 0) 
       1 
       (* n (fact (- n 1)))))
```

```lisp
(defun fib (n)
  (if (= n 1)
    1
    (if (= n 2)  
      1
      (+ (fib (- n 1)) (fib (- n 2))))))
```

こういうやつ

--

### LL(1)文法

[link](https://github.com/Matts966/gosp/blob/master/repl/reader/read_expr.go#L144)

- ↑にあるように、一文字先読みして再帰的に降りていって構文解析する（再帰降下構文解析）
- さらにいうと、Lispのトークンは基本1文字なので、Lexerを用意しなくとも良い。
- （ミニマムな実装であることもある）

--

### GCは？

<p class="fragment">
→ いらない
</p>

<p class="fragment">
Goのマークアンドスイープアルゴリズムがやってくれるから。
</p>

<p class="fragment">
実際には環境の扱い方に注意が必要。
</p>

--

### 全体像

![flow](./images/interperter_flow.svg)

<!-- st=>start: プログラム＝文字列
e=>end: Evaluator 解釈実行
repl=>operation: REPL メインループ
read=>operation: Reader 構造体へ変換
cond1=>condition: err != nil:
print_err=>operation: エラーを出力
cond2=>condition: err != nil:
print_err2=>operation: エラーを出力

st->repl->read->cond1
cond1(yes)->print_err
cond1(no)->e->cond2
cond2(yes)->print_err2
cond2(no)->repl -->

---

## ポインタ渡しor値渡し

--

#### ポインタも実体も投げられる魔法のコード

- `Go` はポインタ型でもインターフェースはそのまま使える
- その結果、構造体はポインタで、 `interface` はそのままで渡したいときなどに
  - タイプスイッチでポインタと実体それぞれについて書く必要...
  - 実体をたぐるときに `panic` する可能性を常に考慮する必要... が生じる

--

#### ポインタも実体も投げられる魔法のコード

全部無視して以下のコードから `interface` 型を取得し、タイプスイッチに渡せば良い！

```Go
import "reflect"

func main() {
  var pointerOrValue interface{}
  reflect.Indirect(reflect.ValueOf(pointerOrWhatever)).Interface()
}
```

- `nil` を渡すと `panic` するので注意...

--

#### ポインタも実体も投げられる魔法のコード

最終的には

- 強力すぎる
- 暗黙知が増える
- コードが冗長になる

ことを考えて全てポインタで扱うようにした。

--

- とはいえ、毎回 `nil` チェックが必要になる
- ので、破壊的更新が必要なところ以外は値渡しに変更していっても良いかもしれない。

---

## 苦労した点

--

### 循環参照

- Goではモジュール間の循環参照はできない。
- `Evaluator` も `PrimitiveFunctions` も、お互いがお互いを必要になってしまった。
- 評価を行うような処理は出来るだけ `Evaluator` に寄せ、なんとか分離できた。
- 改めて、モジュールごとの責務を綺麗に分離することの重要さを感じた。

--

### Singly Linked List (Cons Cell) の実装

- 可変長配列があれば再帰的なセルの実装を行う必要はない。
- 言語機能が十分強力な場合、自分で作らず利用した方が早いということ。
- ↑に気づくことができなかった。

--

### 先読みの際のバグ

- bufioでスキャナを作ったとき、バッファがひとつであるという当たり前の事実を忘れて、UnreadRuneを二回やって失敗していた。
- バグるはずがないとエラーを握りつぶしていたので、やはり最初からエラーハンドリングはしっかりやるべき。

--

とはいえ一文字の先読みだとツラいこともある。

```Go
swith c {
  case '-':

    scn.Next()

    if isDigit(scn.Peek()) {

      return types.Int{
        Value: -readNumber(scn, int(scn.Next()-'0')),
      }, nil
    }

    // Can not use scn.Back() for used scn.Peek() already.
    return prims.Intern(symbolTable, "-")

  default:
    if isDigit(p) {

      scn.Next()

      return types.Int{
        Value: readNumber(scn, int(p-'0')),
      }, nil
    }

    return readSymbol(symbolTable, scn)
  }
  p = scn.Peek()
}
```

--

### シンボルテーブルの追加

[link to commit](https://github.com/Matts966/gosp/commit/8a2c6c939536ea51cb349beada6a0d7373c07408)

--

```lisp
(eq (gensym) 'G__0)
```

以下をreturnしないといけない

```lisp
()
```

つまり`False`

--

### スコープのデバッグ

- 再帰関数などを実装するためには、関数の持つ環境の中にその関数自身が定義されている必要がある。
- それ自体が再帰的構造なので、デバッグプリントすると無限ループになる。

---

# TODO

--

- マクロの実装

--

- while 構文の実装
  - マクロで書いても良いがループがなく再帰しか書けない
  - そのため、空間計算量を考えるとビルトインでつくりたい

--

- 可変長引数のバグ修正

--

- クロージャのバグ修正
  - 現状グローバルな変数はキャプチャ可能。
  - ローカルになるとおかしくなる。
  - 環境の扱い方をもう一度確認する。

--

- その他バグを見つかり次第潰す...
  - 引数がない場合のセグフォなど
- テストを増やしていく...

---

# おまけ

--

#### xerrors with xerrchk は最高

```Go
gosp~> a
error occured while evaluating obj in repl.Run obj=&types.Symbol{Name:(*string)(0xc000012db0)} :
    github.com/Matts966/gosp/repl.(*repl).Run
        /Users/masahiromatsui/gosp/repl/repl.go:78
  - undefined symbol: a:
    github.com/Matts966/gosp/repl/evaluator.Eval
        /Users/masahiromatsui/gosp/repl/evaluator/eval.go:18
```

--

#### そのままエラーでパニックすると...

```Go
gosp~> a                    
panic: undefined symbol: a

goroutine 1 [running]:
main.main()
        /Users/masahiromatsui/gosp/cmd/gosp/main.go:44 +0x62
exit status 2
```

--

#### goの中でLispが書ける！

```Go
obj, err := gosp.Interpret(`
(define sym (cons '111 '123)) 
(setcar sym '789) 
sym
`)
if err != nil {
  panic(err)
}
fmt.Println("returned:", obj.String())
```

↓ stdout

```Go
(111 . 123)
(789 . 123)
(789 . 123)
returned: (789 . 123)
```

--

#### サーバーが立ち上がる！

- 実装する言語の能力が強力であれば、ビルトイン関数として実装することはとても楽だと分かった。
- 反対に、初めてC言語などの高級言語を完成させた人類は大変だったはず。
- すでにWebAssemblyに対応しているなど、これからRustPythonみたいな言語はアツイかも？

---

### ありがとうございました 🎉

--

## 質問（あれば）