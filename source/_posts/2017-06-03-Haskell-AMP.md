---
title: Haskell AMP
tags:
  - Haskell
date: 2017-06-03 10:41:23
---


在拜讀[《Learn You a Haskell for Great Good!》](http://learnyouahaskell.com)一書中，介紹 Monad 定義時，提到可以不用下 Applicative 的類別約束，那是因為此書範例仍停留在 `GHC 6.8.2` 版本，但資訊界可是日新月異，在這推陳出新的時代，早已行不通了！

現在來看一下失敗案例：

```haskell
data Maybe' a = Nothing' | Just' a deriving(Show)

instance Functor Maybe' where
    fmap _ Nothing'  = Nothing'
    fmap f (Just' x) = Just' (f x)

instance Monad Maybe' where
    return x = Just' x
    Nothing' >>= _ = Nothing'
    (Just' x) >>= f = (f x)

```

按書中方式，定義 Monad 時不去繼承 Applicative，將無法編譯成功，出現下列錯誤訊息：


```bash
foo.hs:10:10: error:
    • No instance for (Applicative Maybe')
        arising from the superclasses of an instance declaration
    • In the instance declaration for ‘Monad Maybe'’
Failed, modules loaded: none.
```

根據 [Functor-Applicative-Monad Proposal](https://wiki.haskell.org/Functor-Applicative-Monad_Proposal) ，原來早在 `GHC 7.10` 已接受此提議，所以改成一定要宣告 Applicative ，而且 Monad 的 `return` 已經被 Applicative 的 `pure` 取代，可以不用寫了！

這本書已經有點年紀，顯得需要與時並進的地方。