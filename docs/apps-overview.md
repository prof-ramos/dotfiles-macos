# 📱 Aplicativos e Ferramentas Instaladas

Este documento descreve todas as ferramentas e aplicativos incluídos neste setup de dotfiles.

## 🛠️ CLI Tools (Homebrew Formulas)

### Desenvolvimento
- **git** - Sistema de controle de versão
- **gh** - GitHub CLI para interagir com GitHub
- **node** - Runtime JavaScript
- **python@3.13** - Linguagem de programação Python
- **hugo** - Gerador de sites estáticos
- **docker** - Containerização
- **docker-compose** - Orquestração de containers

### Produtividade Terminal
- **zsh** - Shell avançado
- **oh-my-zsh** - Framework para zsh
- **powerlevel10k** - Tema para zsh
- **autojump** - Navegação rápida entre diretórios
- **fzf** - Fuzzy finder para linha de comando
- **thefuck** - Correção automática de comandos

### Utilitários Sistema
- **bat** - Clone do cat com syntax highlighting
- **eza** - Substituto moderno do ls
- **fd** - Alternativa rápida ao find
- **ripgrep (rg)** - Busca de texto ultrarrápida
- **htop** - Monitor de processos interativo
- **btop** - Monitor de recursos modernizado
- **tree** - Visualização de estrutura de diretórios

### Multimedia
- **ffmpeg** - Conversão de áudio/vídeo
- **exiftool** - Manipulação de metadados de arquivos
- **imagemagick** - Manipulação de imagens

### IA e ML
- **huggingface-cli** - CLI para Hugging Face
- **claude-cli** - Cliente CLI para Claude AI
- **gemini-cli** - Cliente CLI para Google Gemini

### Rede e Downloads
- **wget** - Download de arquivos
- **curl** - Transferência de dados
- **httpie** - Cliente HTTP amigável

## 📱 Aplicativos GUI (Homebrew Casks)

### Desenvolvimento
- **visual-studio-code** - Editor de código principal
- **iterm2** - Terminal avançado para macOS
- **docker** - Docker Desktop
- **github-desktop** - Cliente gráfico do GitHub
- **figma** - Design e prototipagem
- **postman** - Teste de APIs

### Produtividade
- **raycast** - Launcher e automação (substituto do Spotlight)
- **alfred** - Launcher alternativo
- **rectangle** - Gerenciamento de janelas
- **cleanmymac** - Limpeza e otimização do sistema
- **the-unarchiver** - Descompactação de arquivos
- **appcleaner** - Desinstalação completa de apps

### Comunicação
- **discord** - Chat e comunidades
- **slack** - Comunicação corporativa
- **telegram** - Mensagens instantâneas
- **whatsapp** - WhatsApp Desktop
- **zoom** - Videoconferências

### Navegação Web
- **google-chrome** - Navegador principal
- **firefox** - Navegador alternativo
- **tor-browser** - Navegação anônima

### Multimedia
- **vlc** - Player de vídeo universal
- **spotify** - Streaming de música
- **keka** - Compactação de arquivos
- **imageoptim** - Otimização de imagens
- **gimp** - Editor de imagens

### Utilitários
- **1password** - Gerenciador de senhas
- **dropbox** - Armazenamento em nuvem
- **google-drive** - Drive do Google
- **transmission** - Cliente BitTorrent
- **cyberduck** - Cliente FTP/SFTP

## 🔧 Configurações Especiais

### Shell (Zsh)
- **Oh My Zsh** framework instalado
- **Powerlevel10k** tema configurado
- Plugins: git, autojump, fzf, thefuck
- Aliases personalizados para desenvolvimento
- Histórico aprimorado

### Raycast
- Snippets organizados para IA (Claude, Gemini, GPT)
- Comandos personalizados
- Calculadora avançada
- Clipboard manager

### GitHub CLI
- Autenticação configurada
- Templates para issues e PRs
- Aliases úteis

### iTerm2
- Perfis de cor customizados
- Atalhos de teclado otimizados
- Integração com shell

## 📊 Estatísticas

- **Total Formulas**: ~184 pacotes CLI
- **Total Casks**: ~53 aplicativos GUI
- **Categorias**: Desenvolvimento, Produtividade, Multimedia, Utilitários
- **Tamanho aproximado**: ~15GB de aplicativos

## 🔄 Atualizações

Para manter tudo atualizado:

```bash
# Atualizar Homebrew e pacotes
brew update && brew upgrade

# Atualizar Oh My Zsh
omz update

# Atualizar configurações dos dotfiles
./scripts/backup.sh
```

## 📋 Checklist Pós-Instalação

- [ ] Configurar 1Password e importar senhas
- [ ] Fazer login no Spotify, Discord, Slack
- [ ] Configurar Google Drive e Dropbox
- [ ] Importar perfis do iTerm2
- [ ] Configurar snippets no Raycast
- [ ] Configurar extensões do VS Code
- [ ] Testar integração Git + GitHub CLI
- [ ] Executar p10k configure para personalizar tema

---

**Nota**: Esta lista é gerada automaticamente pelo Brewfile. Para ver a lista completa e atualizada, execute `brew list` no terminal.