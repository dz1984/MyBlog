---
title: 貝氏統計導論 勘誤表
date: 2019-07-01 18:16:49
tags: [Book, 勘誤]
---

在看這本書時，發現書中有些小地方有錯誤，便決定列出來，提供大家參考使用。

- 書名： 貝氏統計導論：EXCEL應用
- 作者： 楊士慶、陳耀茂
- ISBN： 9789571197197
- 出版年份：2018.06
- 出版商：五南

---

* p.39 式(2)中等號左邊的 $P(A|B)$ 應修正為 $$(A_1|B)$。
* p.42 例3.4，題目 b 壺原為 2 個紅球，應修正為 8 個紅球。
* p.43 例3.5，題目 b 壺原是紅球 1 個，應修正為紅球 2 個。
* p.57 E 表格中，0 列的 $P(E)$ 欄，原為 0.498，應修正為 0.998。
* p.59 中間的式子，應修正為：$$P(B \cap E | A)= \frac {P(A|B \cap E) \cdot P(B \cap E)}{P(A)}。$$
* p.60 在 E 表格中，0 列的 $P(E)$ 欄，原為 0.498，應修正為 0.998。
* p.60 倒數第二行的式子，應修正為：$$P(S|B \cap A) = P(S|A)，P(S|B \cap \bar{A})=P(S|\bar{A})$$
* P.61 中間的 $P(B \cap A)$ 原為 0.0094 修正為 0.00094 ，而 $P(B \cap \bar{A})$ 原為 0.0006 修正為 0.00006 。
* p.61 式(7)中，原 0.0006 應修正為 0.00006 。
* p.63 最後一行，"另外，在第3章第3節…" 應修正為 "另外，在第3章第2節…"。
* p.63 最後一個式子有誤，應參考 P.40 中的式(3)。
* p.64 方框中， 原是 "D 表數碼"，應修正為 "D 表數據"。
* p.67 中間的表格，壺3欄的機率列，原為 $\frac {2}{3}$ 應修正為 1。
* p.72 倒數第二個方框，第一行 "事後分配是與概似和事前分配的乘機成比例"中的，"機" 修改為 "積"。
* p.73 因事前分配的變異數是1，所以，$$ 事前分配=\frac {1}{\sqrt{2\pi}}e^{- \frac{(\mu-100)^2}{2}} $$
* p.74 Memo 的方框中，式(7)，應修正為： $$
\begin{align}
&\propto \frac{1}{\sqrt{2 \pi \times 3}}e^{-\frac{(99-\mu)^2}{2 \times 3}} \frac{1}{\sqrt{2 \pi \times 3}}e^{-\frac{(100-\mu)^2}{2 \times 3}} \frac{1}{\sqrt{2 \pi \times 3}}e^{-\frac{(101-\mu)^2}{2 \times 3}} \frac {1}{\sqrt{2\pi}}e^{- \frac{(\mu-100)^2}{2}} \\\\
&\propto e^{- \frac{(99-\mu)^2+(100-\mu)^2+(101-\mu)^2} {2\times 3} + \frac{(\mu - 100)^2} {2} }
\end{align} $$還有下面的式子，修正為： $$
-\frac{1}{2 \times 3}\lbrace(99-\mu)^2+(100-\mu)^2+(101-\mu)^2\rbrace+\frac{1}{2}(\mu-100)^2 \\\\
=-\frac{1}{2 \times 3}\lbrace6(\mu-100)^2+2\rbrace $$
* p.76 最下面的公式 $ \pi(\theta | D_1) \propto \theta \times 1 = \theta $ 為 (5) 式。
* p.80 公式(2) 修正為：
$$ \text{概似} f(D|\theta) = _5{C_4}\theta^4(1-\theta), (0 \le \theta \le 1)$$
* p.80 下面的公式，應修改為：$$ 事前分配\pi(\theta) = \text{常數} $$
* p.81 修改為：$$ 事前分配\pi(\theta) = 1，(0 \le \theta \le 1)
\tag{3} $$
* p.82 從上數來第5行，平均值…後分配利用"機"分即可簡單計算，修改為積。
* p.89 最下面的式子，修改為： $$
\text{事後分配}=30 \theta^{5-1}(1-\theta)^{2-1}
\tag{答} $$
* p.91 中間的"事後分配的變異數"公式，應修改為： $$ 事後分配的變異數=\frac{5}{196} (\doteq 0.026) $$

* p.94 最下面的事前分配，應修改為：$$ 
\begin{align}
事前分配 & \propto = \frac{1}{\sqrt{2\pi}}e^{-\frac{(100-\mu)^2}{2}}\frac{1}{\sqrt{2\pi}}e^{-\frac{(102-\mu)^2}{2}}\frac{1}{\sqrt{2\pi}}e^{-\frac{(104-\mu)^2}{2}}\frac{1}{\sqrt{2\pi}}e^{-\frac{(\mu-100)^2}{2}} \\\\
&\propto e^{\frac{1}{2 \times \frac{1}{4}} (\mu -101.5)^2}
\end{align} $$
* p.103 式(6)，e 的指數部份有誤，應修改為： $$
\large
\text{事後分配} \propto (\sigma^2)^{-\frac{n_1+1}{2} -1 } e^{-\frac{n_1s_1+m_1(\mu -\mu_1)^2}{2\sigma^2}}
\tag{6} $$
* p.111 例 5.6 中 $M_1$的 $\theta = 0.5 $。
* p.113 中間的95%信賴區間，原為 $ 99367 \le \mu \le 100.93 $，應修改為：$$ 99.67 \le \mu \le 100.93 $$
下面式(3)應修改為：$$
\large
f(x)=\frac{1}{\sqrt{2\pi} \times \frac{0.64}{\sqrt{4}}}e^{-\frac{(\chi-\mu)^2}{2\times(\frac{0.64}{\sqrt{4}})^2}}
\tag{3} $$
* p.131 最後一行，修改為： $$
n_0 = 0.02 \text{，} s_0=1 $$
* p.132 中間的 $n_1s_1$ 和 $\mu_1$，應修改為： $$
n_1s_1 = 0.02 \times 1 + 138.22 + \frac{0.25 \times 30} {0.25+30} \times (5.11-5)^2 = 138.24 \\\\
\mu_1 = \frac{30 \times 5.11 + 0.25 \times 5} {0.25+30} = 5.11 $$
* p.145 方框內的式(1)，應修改為： $$
\large
\text{事後分配} \propto (\sigma^2)^{-\frac{n_1+1}{2} -1 } e^{-\frac{n_1s_1+m_1(\mu -\mu_1)^2}{2\sigma^2}}
\tag{1} $$
* p.150 "在「P_原」工作單…"中，"原"修改為 "元"。
* p.163 上面的式(3)，應修改為：$$
q_i = \frac{1}{1+e^{-(\beta - \gamma_i)}}
\tag{3} $$
* p.164 式(6) 最未項分母的x，應修改為 $\times$ 符號。
* p.165 上面的式(7)的$q_i$部份，應修改為：$$
q_i = \frac{1}{1+e^{-(\beta - \gamma_i)}} $$
另外，式(8)有誤，其最末項是乘上式(5)。
* p.166 中間的$q_i$部份，同上一頁修改。
* p.169 中間$q$部份，也同樣要補上括號。
* p.176 中間的$q_i$部份，補上括號。
* p.179 式(2)的$q_i$部份補上括號。
* p.191 和 p.192 的 Excel 計算有誤。(註：因 F9 未設定為 3，導致計算錯誤。)
* p.216 方框與中間表格，當出席人數為10時，其便當預約數應為 20。
* p.231 第一行應修改為： $$
\text{(5)的指數部份}=-\frac{1}{2} \times \frac{1}{25} \lbrace 21593.8\alpha^2 - 2\times 6603.1\alpha^2 \rbrace + C $$
* p.238 從上往下第5行，"...依序設為 x,y,..."，應修改為：...依序設為 x,u ,..."
* p.240 式(7)的符號錯誤，P 應修改為 $\beta$，X 修改為$\Sigma_0$。
* p.248 最下面的式(4)，應修改為： $$ \large \text{概似}f(D|\mu) \propto e^{-\frac{n(\bar{x}-\mu)^2}{2\sigma^2}} \tag{4} $$
* p.249 式(6) 的推導過程，應修變為： $$
\large
\begin{align}
\text{(6)式的指數} &= -\frac{n(\bar{x}-\mu)^2}{2\sigma^2}-\frac{(\mu-\mu_0)^2}{2\sigma_0^2} \\\\
&= -\frac{1}{2}\lbrace[\frac{n}{\sigma^2}+\frac{1}{\sigma_0^2}]\mu^2-2[\frac{n\bar{x}}{\sigma^2}+\frac{\mu_0}{\sigma_0^2}]\mu\rbrace+\lbrace不含\mu之項\rbrace \\\\
&= -\frac{1}{2}[\frac{n}{\sigma^2}+\frac{1}{\sigma_0^2}][\mu^2-2(\frac{\frac{n\bar{x}}{\sigma^2}+\frac{\mu_0}{\sigma_0^2}}{\frac{n}{\sigma^2}+\frac{1}{\sigma_0^2}})\mu]+\lbrace不含\mu之項\rbrace \\\\
&= -\frac{1}{2}[\frac{n}{\sigma^2}+\frac{1}{\sigma_0^2}][\mu-\frac{\frac{n\bar{x}}{\sigma^2}+\frac{\mu_0}{\sigma_0^2}}{\frac{n}{\sigma^2}+\frac{1}{\sigma_0^2}}]^2+\lbrace不含\mu之項\rbrace
\end{align} $$
* p.250 最後一行式子，應修改為：$$ (\chi_1 - \bar{x})+(\chi_2 - \bar{x})+\dots+(\chi_n-\bar{x}) = 0 $$
* p.252 式(4)事後分配公式中，最後一行應修改為：$$
\large
\propto (\sigma^2)^{-a-\frac{n}{2}-\frac{3}{2}}e^{-\frac{Q+n(\mu-\bar{x})^2+m_0(\mu-\mu_0)^2+2\lambda}{2\sigma^2}}
\tag{4}
$$
式(5) 第一行應修為： $$
\text{分子}=\mathcal{Q}+n(\mu - \bar{x})^2+m_0(\mu - \mu_0)^2 + 2\lambda $$
式(6) 事後分配，應修改為：$$
\large
\text{事後分配} \propto (\sigma^2)^{-a-\frac{n}{2}-\frac{3}{2}}e^{-\frac{Q+(m_0+n)(\mu-\mu_1)^2+\frac{m_0 n}{m_0+n}(\bar{x}-\mu_0)+2\lambda}{2\sigma^2}}
\tag{6} $$
式 (7) 應修改為： $$
\large
\mu_1 = \frac{n\bar{x}+m_0\mu_0}{m_0 + n}
\tag{7} $$
* p.253 中間 $m_1$ 和 $n_1$，以及 $n_1s_1$ 部份，應修改為： $$
m_1 = m_0 +n \text{，} n_1=n_0+n \\\\
n_1s_1 = n_0s_0 + \mathcal{Q} + \frac{m_0n}{m_0+n_0}(\bar{x} - \mu_0)^2 $$
* p.255 式(4)應修改為： $$
\text{事後分配} \propto e^{-n\theta}\theta^{n\bar{x}}\times\theta^{a-1}e^{-\lambda\theta} = \theta^{a+n\bar{x}-1}e^{-(\lambda+n)\theta}
\tag{4} $$
以及 第二行原為 $ Ga(\alpha+\bar{n}, \lambda+n) $ 修改為 $ Ga(\alpha+n\bar{x}, \lambda+n) $。
* p.262 於"可利用下式定義"的下面須插入一式： $$
E[g(\theta)] = \int_a^b g(\theta)\cdot p(\theta) \cdot d\theta
\tag{1} $$
* p.264 公式推導的符號有誤，像是方框內的底標重複，而非按照預期的。
* p.266 最後一行，原為： $ w_1 , w\_2, \dots ,w_{t-2},w\_t,w\_{t+1},\dots $，應修改為：
$$ w_1,w\_2,\dots,w_{t-1},w\_t,w\_{t+1},\dots $$