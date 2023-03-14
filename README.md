Pandoc lua filter for making minipages in latex.

Turns this:

```
:::::: minipages
::: {.minipage width="40%" align="t" place="t"}
Page 1
:::
::: {.minipage width="50%"}
Page 2
:::
::::::
```

into this:

```latex
\begin{minipage}[t][][t]{0.4\linewidth}

Page 1

\end{minipage}
\begin{minipage}[c][][c]{0.5\linewidth}

Page 2

\end{minipage}
```
