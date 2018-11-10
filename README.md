# my_lisp
## 概要
言語開発をしてみたかったので作ってみたプログラミング言語です。

多分、純lispになってます。(car,cdr,cons,eq,atom,quote,if,lambdaが使えます。)
## 注意点
バグがバグバグしてます。(メモリリークや読み取りのチェックなど)
## コンパイル方法
```bash
make build
```
## 使い方
REPLのみ対応しています。

```bash
./my_lisp
```
## ファイル一覧
- README.md ... 今見ているファイル
- makefile ... buildとcleanがあります。(詳細はファイル内容を見てください)
- my_lisp.c ... c言語での純lisp実装
- my_lisp.lisp ... common lisp言語での純lisp実装
- tests ... テストケース
