Pinyin Completion Lite
========

Complete path by acronym of pinyin initials.

用拼音补全命令行中的中文名称和路径

### Features

* Fully rewritten and optimized in Python 3 (262 ➡️ 54 lines 🤯)
* Accelerated loading with pickle
* No additional dependencies or builds required

### Example

```bash
$ ls .
SVN培训  全球眼  浙江建行  浙江农信
$ cd S     <tab>             进入[SVN培训]
$ cd q     <tab>             进入[全球眼]
$ cd z     <tab>             自动补全[浙江]
$ cd zj    <tab><tab>        提示[浙江建行 浙江农信]备选
$ cd zj1   <tab>             进入[浙江建行]
$ cd zj2   <tab>             进入[浙江农信]
$ cd 浙江j <tab>             进入[浙江建行]
$ cd zjj   <tab>             进入[浙江建行]
```

### Installation

1. Clone this repository and add `pinyin-comp` to your `PATH`.
2. Source `shell/pinyin-comp.bash` or `shell/pinyin-comp.zsh` for your shell.

### Others

`tools/table-generator.py` is used to generate `tools/pinyin_initial.pkl` from `tools/unicode-han-pinyin.txt`.

If you feel the default table is too large and causes noticeable delays or unwanted ambiguity, you can modify `tools/unicode-han-pinyin.txt` and regenerate `tools/pinyin_initial.pkl` by running:

```bash
$ cd tools
$ python table-generate.py unicode-han-pinyin.txt pinyin_initial.pkl
```
