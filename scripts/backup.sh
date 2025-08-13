#!/bin/bash

# 📂 Dotfiles macOS - Script de Backup
# Autor: Gabriel Ramos
# Descrição: Atualiza o repositório com as configurações atuais do sistema

set -e

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[BACKUP]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Diretório do script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

info "🔄 Atualizando dotfiles com configurações atuais..."

cd "$DOTFILES_DIR"

# 1. Atualizar Brewfile
log "📦 Atualizando Brewfile..."
cd apps/
brew bundle dump --force --describe
brew list --formula > brew-formulas.txt
brew list --cask > brew-casks.txt
cd ..

# 2. Atualizar configurações shell
log "🐚 Atualizando configurações shell..."
cp ~/.zshrc shell/ 2>/dev/null || warn ".zshrc não encontrado"
cp ~/.zprofile shell/ 2>/dev/null || warn ".zprofile não encontrado"
cp ~/.p10k.zsh shell/ 2>/dev/null || warn ".p10k.zsh não encontrado"

# 3. Atualizar configurações de aplicativos
log "⚙️ Atualizando configurações de aplicativos..."

# Raycast
if [[ -d ~/.config/raycast ]]; then
    cp -r ~/.config/raycast config/ 2>/dev/null || true
    log "✅ Raycast atualizado"
fi

# GitHub CLI
if [[ -d ~/.config/gh ]]; then
    cp -r ~/.config/gh config/ 2>/dev/null || true
    log "✅ GitHub CLI atualizado"
fi

# iTerm2
if [[ -d ~/.config/iterm2 ]]; then
    cp -r ~/.config/iterm2 config/ 2>/dev/null || true
    log "✅ iTerm2 atualizado"
fi

# 4. Limpar arquivos desnecessários
log "🧹 Limpando arquivos temporários..."
find . -name ".DS_Store" -delete 2>/dev/null || true
find . -name "*.log" -delete 2>/dev/null || true

# 5. Verificar mudanças
if git diff --quiet && git diff --cached --quiet; then
    info "✨ Nenhuma mudança detectada"
else
    info "📝 Mudanças detectadas:"
    git status --porcelain
    
    echo ""
    read -p "Deseja commitar as mudanças? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add .
        git commit -m "backup: update dotfiles $(date '+%Y-%m-%d %H:%M')"
        
        read -p "Deseja fazer push para o GitHub? (y/n): " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git push
            log "✅ Backup enviado para GitHub"
        fi
    fi
fi

log "🎉 Backup concluído!"