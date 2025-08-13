#!/bin/bash

# 📂 Dotfiles macOS - Script de Setup Automatizado
# Autor: Gabriel Ramos
# Descrição: Instala e configura todas as dependências e dotfiles

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para log colorido
log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

info() {
    echo -e "${BLUE}[SETUP]${NC} $1"
}

# Verificar se está no macOS
if [[ "$(uname)" != "Darwin" ]]; then
    error "Este script é apenas para macOS!"
    exit 1
fi

info "🚀 Iniciando setup dos dotfiles..."

# Diretório do script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# 1. Verificar/Instalar Homebrew
if ! command -v brew &> /dev/null; then
    info "📦 Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Adicionar ao PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    log "✅ Homebrew já está instalado"
fi

# 2. Atualizar Homebrew
info "🔄 Atualizando Homebrew..."
brew update

# 3. Instalar dependências do Brewfile
if [[ -f "$DOTFILES_DIR/apps/Brewfile" ]]; then
    info "📱 Instalando aplicativos e ferramentas..."
    cd "$DOTFILES_DIR/apps"
    brew bundle install --verbose
    log "✅ Dependências instaladas"
else
    warn "Brewfile não encontrado em $DOTFILES_DIR/apps/"
fi

# 4. Backup de configurações existentes
info "💾 Fazendo backup de configurações existentes..."
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup shell configs
for file in .zshrc .zprofile .p10k.zsh; do
    if [[ -f "$HOME/$file" ]]; then
        cp "$HOME/$file" "$BACKUP_DIR/"
        log "Backup: $file → $BACKUP_DIR/"
    fi
done

# Backup config directories
for dir in raycast gh iterm2; do
    if [[ -d "$HOME/.config/$dir" ]]; then
        cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
        log "Backup: .config/$dir → $BACKUP_DIR/"
    fi
done

# 5. Criar diretórios necessários
mkdir -p ~/.config

# 6. Instalar configurações do shell
info "🐚 Configurando shell (zsh)..."

if [[ -f "$DOTFILES_DIR/shell/.zshrc" ]]; then
    cp "$DOTFILES_DIR/shell/.zshrc" ~/.zshrc
    log "✅ .zshrc instalado"
fi

if [[ -f "$DOTFILES_DIR/shell/.zprofile" ]]; then
    cp "$DOTFILES_DIR/shell/.zprofile" ~/.zprofile
    log "✅ .zprofile instalado"
fi

if [[ -f "$DOTFILES_DIR/shell/.p10k.zsh" ]]; then
    cp "$DOTFILES_DIR/shell/.p10k.zsh" ~/.p10k.zsh
    log "✅ .p10k.zsh instalado"
fi

# 7. Instalar configurações de aplicativos
info "⚙️ Configurando aplicativos..."

# Raycast
if [[ -d "$DOTFILES_DIR/config/raycast" ]]; then
    cp -r "$DOTFILES_DIR/config/raycast/"* ~/.config/raycast/ 2>/dev/null || true
    log "✅ Configurações Raycast instaladas"
fi

# GitHub CLI
if [[ -d "$DOTFILES_DIR/config/gh" ]]; then
    cp -r "$DOTFILES_DIR/config/gh/"* ~/.config/gh/ 2>/dev/null || true
    log "✅ Configurações GitHub CLI instaladas"
fi

# iTerm2
if [[ -d "$DOTFILES_DIR/config/iterm2" ]]; then
    cp -r "$DOTFILES_DIR/config/iterm2/"* ~/.config/iterm2/ 2>/dev/null || true
    log "✅ Configurações iTerm2 instaladas"
fi

# 8. Configurar Git (se não configurado)
if [[ -z "$(git config --global user.name)" ]]; then
    info "📝 Configurando Git..."
    read -p "Digite seu nome para Git: " git_name
    read -p "Digite seu email para Git: " git_email
    
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    git config --global pull.rebase false
    
    log "✅ Git configurado"
fi

# 9. Instalar Oh My Zsh (se não estiver instalado)
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    info "🎨 Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log "✅ Oh My Zsh instalado"
fi

# 10. Instalar Powerlevel10k
P10K_DIR="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
if [[ ! -d "$P10K_DIR" ]]; then
    info "⚡ Instalando Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
    log "✅ Powerlevel10k instalado"
fi

# 11. Configurações do macOS
info "🍎 Aplicando configurações do macOS..."

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock show-recents -bool false

# Finder
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Screenshots
defaults write com.apple.screencapture location -string "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture type -string "png"

# Restart affected applications
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true

log "✅ Configurações do macOS aplicadas"

# 12. Limpar cache do Homebrew
info "🧹 Limpando cache..."
brew cleanup

# Finalização
echo ""
info "🎉 Setup concluído com sucesso!"
echo ""
log "📋 Próximos passos:"
echo "  1. Reinicie o terminal ou execute: source ~/.zshrc"
echo "  2. Configure o Powerlevel10k se necessário: p10k configure"
echo "  3. Abra o Raycast e importe os snippets"
echo "  4. Configurações salvas em: $BACKUP_DIR"
echo ""
warn "⚠️  Algumas alterações podem requerer logout/login ou reinicialização"
echo ""

# Perguntar se quer abrir uma nova sessão do terminal
read -p "Deseja abrir uma nova sessão do terminal agora? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    exec zsh
fi