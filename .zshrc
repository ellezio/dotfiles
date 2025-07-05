# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

if [[ ! -d "$HOME/.zsh/plugins" ]]; then 
  mkdir -p "$HOME/.zsh/plugins"
fi

if [[ ! -f "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then 
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.zsh/plugins/zsh-autosuggestions
fi

if [[ ! -f "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then 
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/plugins/zsh-syntax-highlighting
fi

source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_AUTOSUGGEST_STRATEGY=("completion" "match_prev_cmd")
bindkey '^E' autosuggest-accept
bindkey '^ ' forward-word

source <(fzf --zsh)
source <(starship init zsh)

eval "$(direnv hook zsh)"
