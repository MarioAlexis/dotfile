# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# bplug: bash plugin manager
BPLUG_REPO_DIR=~/.bplug/repos
BPLUG_BIN_DIR=~/.bplug/bin
function bplug_init() {
    [ ! -d $BPLUG_REPO_DIR ] && mkdir -p $BPLUG_REPO_DIR
    [ ! -d $BPLUG_BIN_DIR ] && mkdir -p $BPLUG_BIN_DIR
    [[ ":$PATH:" == *":$BPLUG_BIN_DIR:"* ]] || export PATH=$BPLUG_BIN_DIR:$PATH
}
function bplug() {
    [ ! -d $BPLUG_REPO_DIR/${1} ] && git clone http://github.com/${1} $BPLUG_REPO_DIR/${1}
    [ ! -z "${2}" ] && source $BPLUG_REPO_DIR/${1}/${2}
}
function bplug_bin() {
    [ ! -e $BPLUG_BIN_DIR/${3} ] && wget -qO- $(curl -s "https://api.github.com/repos/${1}/releases/latest" | awk  "/browser_download_url.*${2}/{print \$2}"|tr -d \") | tar -xz -C $BPLUG_BIN_DIR
}
# /bplug

[ -e ~/.shell_alias ] && source ~/.shell_alias        
[ -e ~/.shell_env ] && source ~/.shell_env            
[ -e ~/.shell_functions ] && source ~/.shell_functions

# Plugins
bplug_init
bplug     'mrzool/bash-sensible'      'sensible.bash'
bplug     'nojhan/liquidprompt'       'liquidprompt'
bplug_bin 'junegunn/fzf-bin'          'linux_amd64'             'fzf'
bplug     'junegunn/fzf'              'shell/key-bindings.bash'
bplug     'chriskempson/base16-shell' ''

# Select color palette
eval "$(~/.bplug/repos/chriskempson/base16-shell/profile_helper.sh)"

# if command isn't found, suggests a likely package to install
export COMMAND_NOT_FOUND_INSTALL_PROMPT=1

# # k8s completion
command -v kubectl >/dev/null 2>&1 && source <(kubectl completion bash)
command -v helm >/dev/null 2>&1 && source <(helm completion bash)

# Make bash auto-complete liek zsh (similar, not the same)
# https://askubuntu.com/questions/870470/zsh-fish-filename-autocompletion-in-bash
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
        echo "Running bash"
    fi
fi

if [ -n "$zsh_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
        . "$HOME/.zshrc"
        echo "Running zsh"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    echo $PATH | grep -q "$HOME/bin"
    if [ $? -eq 0 ]; then
        echo "$HOME/bin already in PATH"
    else
        PATH="$HOME/bin:$PATH"
    fi
fi
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    echo $PATH | grep -q "$HOME/.local/bin"
    if [ $? -eq 0 ]; then
        echo "$HOME/.local/bin already in PATH"
    else
        PATH="$HOME/.local/bin:$PATH"
    fi
fi
