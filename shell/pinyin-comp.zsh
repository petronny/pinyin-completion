
# use pinyin-comp to perform completion based upon pinyin acronym
function _pinyin_comp()
{
    # chsdir print one candidate per line
    # this looks weird, bug IFS='\n' does not work in interactive shell
    local IFS=$'\n'

    if [ "$words[1]" = "cd" ] ; then
        reply=(${(q)$(pinyin-comp x-d $*)} $*)
    else
        reply=(${(q)$(pinyin-comp 0 $*)} $*)
    fi
}

# force rehash when command not found
# Refer to http://zshwiki.org/home/examples/compsys/general
#
#
_force_rehash_pinyin_comp() {
        (( CURRENT == 1 )) && rehash
        return 1 # Because we did not really complete anything
}

# pinyin-comp is performed as one part of user-expand
zstyle ':completion:*' user-expand _pinyin_comp

# omit original and all expansions when showing the result of user-expand
zstyle ':completion:*:user-expand:*' tag-order expansions

# make use-expand perform as last, when needed
zstyle ':completion:*' completer \
    _oldlist _expand _force_rehash_pinyin_comp _complete _match _user_expand

# vim:set ft=zsh et:
