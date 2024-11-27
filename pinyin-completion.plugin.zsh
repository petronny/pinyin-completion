# shellcheck disable=all
# https://github.com/zdharma-continuum/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

PINYIN_REPO_DIR="${0:h}"
if (( fpath[(I)$PINYIN_REPO_DIR] == 0 )); then
  fpath+=($PINYIN_REPO_DIR)
fi

if [[ ! -e "$PINYIN_REPO_DIR/module/Src/zi/pinyin.so" ]]; then
  builtin print "${fg_bold[magenta]}zi${reset_color}/${fg_bold[yellow]}pinyin${reset_color} is building..."
  autoload -Uz pinyin-compile &&
    pinyin-compile $PINYIN_REPO_DIR
elif [[ ! -f "${PINYIN_REPO_DIR}/module/COMPILED_AT" || ( "$PINYIN_REPO_DIR/module/COMPILED_AT" -ot "${PINYIN_REPO_DIR}/module/RECOMPILE_REQUEST" ) ]]; then
  # Don't trust access times and verify hard stored values
  [[ -e $PINYIN_REPO_DIR/module/COMPILED_AT ]] && local compiled_at_ts="$(<$PINYIN_REPO_DIR/module/COMPILED_AT)"
  [[ -e $PINYIN_REPO_DIR/module/RECOMPILE_REQUEST ]] && local recompile_request_ts="$(<$PINYIN_REPO_DIR/module/RECOMPILE_REQUEST)"

  if [[ "${recompile_request_ts:-1}" -gt "${compiled_at_ts:-0}" ]]; then
    builtin echo "${fg_bold[red]}pinyin: single recompiletion requested by plugin's update${reset_color}"
    autoload -Uz pinyin-compile &&
      pinyin-compile $PINYIN_REPO_DIR
  fi
fi

# Finally load the module - if it has compiled
if [[ -e "$PINYIN_REPO_DIR/module/Src/zi/pinyin.so" ]]; then
  module_path+=("$PINYIN_REPO_DIR/module/Src")
fi

autoload -Uz _pinyin_comp

# pinyin-comp is performed as one part of user-expand
zstyle ':completion:*' user-expand _pinyin_comp

# omit original and all expansions when showing the result of user-expand
zstyle ':completion:*:user-expand:*' tag-order expansions

# make use-expand perform as last, when needed
zstyle ':completion:*' completer _oldlist _expand _complete _match _user_expand

unset PINYIN_REPO_DIR
