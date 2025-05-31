_filedir()
{
    local IFS=$'\t\n' xspec

    _expand || return 0

    local -a toks
    local tmp

    toks=( ${toks[@]-} $(
    compgen -d -- "$(quote_readline "$cur")" | {
    while read -r tmp; do
        echo $tmp
    done
}
))

if [[ "$1" != -d ]]; then
    xspec=${1:+"!*.$1"}
    toks=( ${toks[@]-} $(
    compgen -f -X "$xspec" -- "$(quote_readline "$cur")" | {
    while read -r tmp; do
        [ -n $tmp ] && echo $tmp
    done
}
))
    fi
	chs=($(pinyin-comp "x$1" "$cur"))
	COMPREPLY=( "${COMPREPLY[@]}" "${toks[@]}" "${chs[@]}" )
}

_filedir_xspec()
{
    local IFS cur xspec

    IFS=$'\t\n'
    COMPREPLY=()
    cur=`_get_cword`

    _expand || return 0

    xspec=$( sed -ne $'/^complete .*[ \t]'${1##*/}$'\([ \t]\|$\)/{p;q;}' \
            $BASH_COMPLETION )
    xspec=${xspec#*-X }
    xspec=${xspec%% *}

    local -a toks
    local tmp

    toks=( ${toks[@]-} $(
        compgen -d -- "$(quote_readline "$cur")" | {
        while read -r tmp; do
            # see long TODO comment in _filedir() --David
            echo $tmp
        done
        }
        ))

    toks=( ${toks[@]-} $(
        eval compgen -f -X "$xspec" -- "\$(quote_readline "\$cur")" | {
        while read -r tmp; do
            [ -n $tmp ] && echo $tmp
        done
        }
        ))

    chs=($(pinyin-comp "x$1" "$cur"))
    COMPREPLY=( "${toks[@]}" "${chs[@]}" )
}

complete -o filenames -F _filedir_xspec file

# vim:set ft=bash :
