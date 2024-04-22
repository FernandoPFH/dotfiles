# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gnzh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

setsid fc-cache -f -v &> /dev/null

ins_plugin () {
  DIR=$1
  REP=$2

  if [ -d $DIR ];then
    setsid git -C $DIR pull &> /dev/null
  else
    git clone --depth 1 https://github.com/$REP $DIR
  fi
}

ins_plugin ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting zsh-users/zsh-syntax-highlighting.git
ins_plugin ~/.fzf junegunn/fzf.git
ins_plugin ${zsh_custom:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions zsh-users/zsh-autosuggestions
ins_plugin ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k supercrabtree/k

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( git
  zsh-syntax-highlighting
  fzf
  zsh-autosuggestions
  k
  adb
  aliases
  archlinux
  battery
  colored-man-pages
  colorize
  docker
  docker-compose
  gh
  command-not-found
  gitignore
  kubectl
  python
  sudo
  tmux
  virtualenv)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -d "/snap/bin" ];then
  export PATH="$PATH:/snap/bin"
fi

if [ -d "$HOME/.local/bin" ];then
  export PATH="$PATH:$HOME/.local/bin"
fi

if command -v exa &> /dev/null; then
  alias ls="exa --icons"
else
  echo "Install exa package"
fi

alias pdb='python -m pdb'

if command -v nvim &> /dev/null;then
  export EDITOR='nvim'
  export VISUAL='nvim'
else
  echo "Install neovim package"
fi

if command -v bat &> /dev/null;then
  alias cat="bat"
else
  if command -v batcat &> /dev/null;then
    alias cat="batcat"
  else
    echo "Install bat package"
  fi
fi

if command -v dust &> /dev/null;then
  alias du="dust -r -d 1"
else
  echo "Install dust package"
fi

if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
else
  echo "Install atuin package"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="z"
else
  echo "Install zoxide package"
fi

alias git_hide_dirty="git config --add oh-my-zsh.hide-dirty 1"
alias git_unhide_dirty="git config --add oh-my-zsh.hide-dirty 0"

export VIRTUAL_ENV_DISABLE_PROMPT=
