if [[ ! -d "$HOME/.zsh/plugins" ]]; then 
  mkdir -p "$HOME/.zsh/plugins"
fi

if [[ -f "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then 
  source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then 
  source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

ZSH_AUTOSUGGEST_STRATEGY=("completion" "match_prev_cmd")

bindkey '^E' autosuggest-accept
bindkey '^ ' forward-word

source <(fzf --zsh)
source <(starship init zsh)
