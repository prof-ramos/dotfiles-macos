# ============================================================================
# Zsh – iTerm2 rápido (macOS/Apple Silicon) — Powerlevel10k
# ============================================================================

# Locale
export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8
export LC_CTYPE=pt_BR.UTF-8

# PATH (Homebrew primeiro)
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/node/bin:$PATH"

# P10k instant prompt (tem que ser cedo)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export POWERLEVEL10K_DISABLE_CONFIGURATION_WIZARD=false

# Pare cedo em shells não-interativas
case $- in *i*) : ;; *) return ;; esac

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
export DISABLE_AUTO_UPDATE="true"
export COMPLETION_WAITING_DOTS="false"

if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  plugins=(git)   # plugins pesados entram em lazy mais abaixo
  source "$ZSH/oh-my-zsh.sh"
fi

# Completions com cache
autoload -Uz compinit
ZDOTDIR_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZDOTDIR_CACHE" 2>/dev/null
ZCOMPDUMP="$ZDOTDIR_CACHE/.zcompdump-$HOST"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZDOTDIR_CACHE"
compinit -d "$ZCOMPDUMP" -C

# Opções gerais
setopt prompt_subst
setopt hist_ignore_all_dups share_history inc_append_history
setopt no_beep
bindkey -e

# Aliases
alias ll='eza -alh --icons'
alias grep='grep --color=auto'
alias cls='clear'
alias py='python3'
alias pip='pip3'
alias rg='ripgrep'
alias yt='yt-dlp'
alias serve='python3 -m http.server'
alias updatebrew='brew update && brew upgrade && brew cleanup'

# Docker completions (se existirem)
[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)

# Rust (via rustup: só se existir)
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# fzf (leve)
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# Funções
mkcd() { mkdir -p "$1" && cd "$1"; }

# Lazy-load: plugins após o 1º prompt (mais rápido no iTerm2)
autoload -Uz add-zsh-hook
__deferred_loaded=0
__deferred_init() {
  (( __deferred_loaded )) && return
  __deferred_loaded=1

  [[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] \
    && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

  [[ -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
    && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  [[ -r /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh ]] \
    && source /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh

  [[ -r /opt/homebrew/etc/profile.d/autojump.sh ]] \
    && . /opt/homebrew/etc/profile.d/autojump.sh

  command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"
}
add-zsh-hook -Uz precmd __deferred_init

# P10k principal (gera após rodar `p10k configure`)
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
