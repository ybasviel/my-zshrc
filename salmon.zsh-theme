# salmon
# 作業ディレクトリを左に、git 状態を右に出すシンプルなプロンプト。
# ディレクトリ名は末尾 2 階層を残して省略する（リポジトリ名 / worktree 名で運用しているため）。

# PROMPT / RPROMPT で $(...) を毎回評価するために必須。
setopt prompt_subst

# 末尾 2 階層は省略しない。
# 先頭が . のディレクトリは 2 文字、それ以外は 1 文字にする。
_salmon_collapsed_wd() {
  local i
  local -a pwd_parts
  pwd_parts=("${(s:/:)PWD/#$HOME/~}")

  if (( $#pwd_parts > 2 )); then
    for i in {1..$(($#pwd_parts-2))}; do
      if [[ "$pwd_parts[$i]" = .* ]]; then
        pwd_parts[$i]="${${pwd_parts[$i]}[1,2]}"
      else
        pwd_parts[$i]="${${pwd_parts[$i]}[1]}"
      fi
    done
  fi

  echo "${(j:/:)pwd_parts}"
}

# 256 色パレットの 209 (salmon) をディレクトリの色に使う。
# %F{...}/%f は zsh 組み込みのプロンプトエスケープで、%{...%} で括る必要がない。
PROMPT='%F{209}$(_salmon_collapsed_wd)%f %(!.#.>) '
RPROMPT='$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"
