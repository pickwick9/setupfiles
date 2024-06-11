export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# vim-like editing
stty intr "^G"
bindkey -v
bindkey -s "^C" "^["

# dynamic cursor shape based on current vim mode
function set_cursor_shape() {
  if [[ $KEYMAP == "vicmd" ]]; then
    echo -ne "\033[2 q"  # set cursor to block
  else
    echo -ne "\033[6 q"  # set cursor to beam
  fi
}
zle-line-init() {
  set_cursor_shape
}
zle-keymap-select() {
  set_cursor_shape
}
zle -N zle-line-init
zle -N zle-keymap-select

# fuzzy find directories
function telescope() {
  local dir=$(find . -type d 2> /dev/null | cut -b3- | fzf)
  if [[ -n $dir ]]; then
    cd -- "$dir"
    zle reset-prompt
  fi
}
zle -N telescope
bindkey "^T" telescope

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# flutter
export PATH="/usr/bin/flutter/bin:$PATH"

# chromium as chrome executable
export CHROME_EXECUTABLE=$(which chromium)
