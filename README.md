# pinyin-completion

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/petronny/pinyin-completion/main.svg)](https://results.pre-commit.ci/latest/github/petronny/pinyin-completion/main)
[![github/workflow](https://github.com/petronny/pinyin-completion/actions/workflows/main.yml/badge.svg)](https://github.com/petronny/pinyin-completion/actions)

[![github/downloads](https://shields.io/github/downloads/petronny/pinyin-completion/total)](https://github.com/petronny/pinyin-completion/releases)
[![github/downloads/latest](https://shields.io/github/downloads/petronny/pinyin-completion/latest/total)](https://github.com/petronny/pinyin-completion/releases/latest)
[![github/issues](https://shields.io/github/issues/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/issues)
[![github/issues-closed](https://shields.io/github/issues-closed/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/issues?q=is%3Aissue+is%3Aclosed)
[![github/issues-pr](https://shields.io/github/issues-pr/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/pulls)
[![github/issues-pr-closed](https://shields.io/github/issues-pr-closed/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/pulls?q=is%3Apr+is%3Aclosed)
[![github/discussions](https://shields.io/github/discussions/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/discussions)
[![github/milestones](https://shields.io/github/milestones/all/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/milestones)
[![github/forks](https://shields.io/github/forks/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/network/members)
[![github/stars](https://shields.io/github/stars/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/stargazers)
[![github/watchers](https://shields.io/github/watchers/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/watchers)
[![github/contributors](https://shields.io/github/contributors/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/graphs/contributors)
[![github/commit-activity](https://shields.io/github/commit-activity/w/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/graphs/commit-activity)
[![github/last-commit](https://shields.io/github/last-commit/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/commits)
[![github/release-date](https://shields.io/github/release-date/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/releases/latest)

[![github/license](https://shields.io/github/license/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion/blob/main/LICENSE)
[![github/languages](https://shields.io/github/languages/count/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion)
[![github/languages/top](https://shields.io/github/languages/top/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion)
[![github/directory-file-count](https://shields.io/github/directory-file-count/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion)
[![github/code-size](https://shields.io/github/languages/code-size/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion)
[![github/repo-size](https://shields.io/github/repo-size/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion)
[![github/v](https://shields.io/github/v/release/petronny/pinyin-completion)](https://github.com/petronny/pinyin-completion)

Complete path by acronym of pinyin initials.

用拼音补全命令行中的中文名称和路径。

```sh
% ls
自然语言处理  '自然语言处理 课程结课作业.md'
% ls zr<TAB>
expansions
自然语言处理                   自然语言处理\ 课程结课作业.md
% cd zr<TAB>
% cd 自然语言处理/
```

## Dependencies

- [cpp-pinyin](https://github.com/wolfgitpr/cpp-pinyin/)
- [pkg-config](https://www.freedesktop.org/wiki/Software/pkg-config/)
- [make](https://www.gnu.org/software/make/)
- A C compiler

Or:

- [pypinyin](https://github.com/mozillazg/python-pinyin)

## Install

This plugin respects
[zsh plugin standard](https://github.com/zdharma-continuum/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc),
so if you use any plugin manager and follow the instructions of your plugin
manager, it can be installed correctly. Otherwise:

```zsh
. /the/path/of/this/plugin/pinyin-completion.plugin.zsh
```

## Configure

If you cannot distinguish `n` and `l`, try:

```sh
declare -A FUZZY=(
    [n]=l
)
```

Then always use `l`.

By default, this plugin will change Chinese punctuation to English punctuation.
You can add more punctuation maps:

```sh
declare -A FUZZY=(
    […]=...
)
```

Then use `...` to search the file whose name contains `…`.
