# 📂 Dotfiles macOS

Configurações pessoais e setup automatizado para macOS com foco em desenvolvimento e produtividade.

## 🚀 Setup Rápido

```bash
# Clonar repositório
git clone https://github.com/prof-ramos/dotfiles-macos.git ~/dotfiles
cd ~/dotfiles

# Instalar Homebrew (se não estiver instalado)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar todas as dependências
brew bundle install

# Executar script de configuração
./scripts/setup.sh
```

## 📁 Estrutura

```
├── apps/               # Configurações do Homebrew
│   ├── Brewfile       # Bundle completo (formulae + casks + taps)
│   ├── brew-formulas.txt  # Lista de pacotes CLI
│   └── brew-casks.txt     # Lista de aplicativos GUI
├── shell/             # Configurações do terminal
│   ├── .zshrc         # Configuração principal do zsh
│   ├── .zprofile      # Profile do zsh
│   └── .p10k.zsh      # Tema Powerlevel10k
├── config/            # Configurações de aplicativos
│   ├── raycast/       # Snippets e comandos Raycast
│   ├── gh/            # Configurações GitHub CLI
│   └── iterm2/        # Perfis e configurações iTerm2
├── scripts/           # Scripts de instalação e automação
└── docs/              # Documentação adicional
```

## 🛠️ Ferramentas Incluídas

### 📱 Aplicativos (via Homebrew Cask)
- **Produtividade**: Raycast, Alfred, Rectangle
- **Desenvolvimento**: Visual Studio Code, iTerm2, Docker Desktop
- **Comunicação**: Discord, Slack, Telegram
- **Utilitários**: CleanMyMac, The Unarchiver, AppCleaner
- **Design**: Figma, ImageOptim, GIMP

### ⚡ CLI Tools (via Homebrew Formula)
- **Shell**: zsh, oh-my-zsh, powerlevel10k
- **Development**: git, node, python, gh, docker
- **Utilities**: htop, tree, wget, curl, jq
- **AI Tools**: claude-cli, gemini-cli
- **Productivity**: thefuck, fzf, ripgrep

### 🔧 Configurações Personalizadas

#### Zsh + Oh My Zsh + Powerlevel10k
- Tema customizado com informações Git
- Aliases úteis para desenvolvimento
- Integração com ferramentas de IA
- Histórico aprimorado e autocompletion

#### Raycast
- Snippets para prompts de IA organizados
- Comandos personalizados
- Integração com ferramentas de desenvolvimento

#### GitHub CLI
- Configurações otimizadas
- Templates personalizados
- Aliases úteis

## 📋 Pré-requisitos

- macOS (testado no macOS Sonoma)
- Xcode Command Line Tools
- Homebrew (será instalado automaticamente se necessário)

## 🔄 Instalação Manual

### 1. Homebrew
```bash
# Instalar Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar dependências
cd ~/dotfiles/apps
brew bundle install
```

### 2. Configurações Shell
```bash
# Backup configurações existentes
cp ~/.zshrc ~/.zshrc.backup 2>/dev/null || true
cp ~/.zprofile ~/.zprofile.backup 2>/dev/null || true

# Copiar novas configurações
cp ~/dotfiles/shell/.zshrc ~/.zshrc
cp ~/dotfiles/shell/.zprofile ~/.zprofile
cp ~/dotfiles/shell/.p10k.zsh ~/.p10k.zsh

# Recarregar shell
source ~/.zshrc
```

### 3. Configurações de Aplicativos
```bash
# Raycast
cp -r ~/dotfiles/config/raycast/* ~/.config/raycast/

# GitHub CLI
cp -r ~/dotfiles/config/gh/* ~/.config/gh/

# iTerm2
cp -r ~/dotfiles/config/iterm2/* ~/.config/iterm2/
```

## 🔧 Personalização

### Adicionar Novos Aplicativos
```bash
# Adicionar ao Brewfile
echo 'cask "nome-do-app"' >> apps/Brewfile

# Ou atualizar Brewfile automaticamente
brew bundle dump --force --describe
```

### Backup de Configurações
```bash
# Atualizar dotfiles com configurações atuais
./scripts/backup.sh
```

## 📚 Recursos Úteis

- [Homebrew](https://brew.sh/) - Gerenciador de pacotes para macOS
- [Oh My Zsh](https://ohmyz.sh/) - Framework para zsh
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Tema zsh
- [Raycast](https://raycast.com/) - Launcher de aplicativos
- [GitHub CLI](https://cli.github.com/) - GitHub na linha de comando

## ⚠️ Notas Importantes

- **Backup**: Sempre faça backup de suas configurações antes de instalar
- **Compatibilidade**: Testado no macOS Sonoma, pode precisar ajustes em outras versões
- **Personalização**: Adapte as configurações às suas necessidades
- **Segurança**: Nunca commite arquivos com informações sensíveis (.env, chaves SSH, etc.)

## 🤝 Contribuição

Sinta-se livre para usar, modificar e sugerir melhorias!

---

**Autor**: Gabriel Ramos  
**Última atualização**: $(date '+%Y-%m-%d')  
**Sistema**: macOS $(sw_vers -productVersion)