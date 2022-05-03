### shell scripts

shell style guide. <https://google.github.io/styleguide/shellguide.html>

> Indentation
> Indent 2 spaces. No tabs. Use blank lines between blocks to improve readability. Indentation is two spaces. Whatever you do, don’t use tabs. For existing files, stay faithful to the existing indentation.

Linter: [GitHub - koalaman/shellcheck](https://github.com/koalaman/shellcheck)  
Formatter: [GitHub - mvdan/sh](https://github.com/mvdan/sh)

```
shfmt -i 2 -ci -w scripts/*
```
