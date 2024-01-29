SAVEHIST=10000  # Save most-recent 1000 lines
HISTFILE=~/.zsh_history

source ~/.zplug/init.zsh

setopt hist_ignore_all_dups

# 非同期
zplug "mafredri/zsh-async"

# テーマ
zplug "themes/fishy", from:oh-my-zsh, as:theme

# コマンドのハイライト
zplug "zsh-users/zsh-syntax-highlighting"
# 過去履歴強化
zplug "zsh-users/zsh-history-substring-search"
# 履歴サジェスト
zplug "zsh-users/zsh-autosuggestions"
# 補完強化
zplug "zsh-users/zsh-completions"
# 256色
zplug "chrissicool/zsh-256color"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
	echo; zplug install
  fi
fi
zplug load


zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

zstyle ':completion:*' menu true select

# 前方一致 履歴補完
bindkey ${key[Up]} history-beginning-search-backward
bindkey ${key[Down]} history-beginning-search-forward
