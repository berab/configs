# wakatime for bash
#
# include this file in your "~/.bashrc" file with this command:
#   . path/to/bash-wakatime.sh
#
# or this command:
#   source path/to/bash-wakatime.sh
#
# Don't forget to create and configure your "~/.wakatime.cfg" file.

# hook function to send wakatime a tick
pre_prompt_command() {
    version="1.0.0"
    entity=$(echo $(fc -ln -0) | cut -d ' ' -f1)
    [ -z "$entity" ] && return # $entity is empty or only whitespace
    $(git rev-parse --is-inside-work-tree 2> /dev/null) && local project="$(basename $(git rev-parse --show-toplevel))" || local project="Terminal"
    (~/.wakatime/wakatime-cli --write --plugin "bash-wakatime/$version" --entity-type app --project "$project" --entity "$entity" 2>&1 > /dev/null &)
}

PROMPT_COMMAND="pre_prompt_command; $PROMPT_COMMAND"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ZOXIDE
_z_cd() {
    cd "$@" || return "$?"

    if [ "$_ZO_ECHO" = "1" ]; then
        echo "$PWD"
    fi
}

z() {
    if [ "$#" -eq 0 ]; then
        _z_cd ~
    elif [ "$#" -eq 1 ] && [ "$1" = '-' ]; then
        if [ -n "$OLDPWD" ]; then
            _z_cd "$OLDPWD"
        else
            echo 'zoxide: $OLDPWD is not set'
            return 1
        fi
    else
        _zoxide_result="$(zoxide query -- "$@")" && _z_cd "$_zoxide_result"
    fi
}

zi() {
    _zoxide_result="$(zoxide query -i -- "$@")" && _z_cd "$_zoxide_result"
}


alias za='zoxide add'

alias zq='zoxide query'
alias zqi='zoxide query -i'

alias zr='zoxide remove'
zri() {
    _zoxide_result="$(zoxide query -i -- "$@")" && zoxide remove "$_zoxide_result"
}


_zoxide_hook() {
    if [ -z "${_ZO_PWD}" ]; then
        _ZO_PWD="${PWD}"
    elif [ "${_ZO_PWD}" != "${PWD}" ]; then
        _ZO_PWD="${PWD}"
        zoxide add "$(pwd -L)"
    fi
}

case "$PROMPT_COMMAND" in
    *_zoxide_hook*) ;;
    *) PROMPT_COMMAND="_zoxide_hook${PROMPT_COMMAND:+;${PROMPT_COMMAND}}" ;;
esac
alias cd='z'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Unwanted dirs
rm -rf ~/GP_HTML
rm -drf ~/Downloads

# Turn off main display
IF_OFFICE_DISPLAY="$(xrandr -q | grep 'DP-1-1 connected' | wc -l)"
IF_SINAN_DISPLAY="$(xrandr -q | grep 'HDMI-1 connected' | wc -l)"
IF_HOME_DISPLAY="$(xrandr -q | grep 'DP-1 connected' | wc -l)"
if [[ $IF_OFFICE_DISPLAY -gt 0 ]]; then
    source /home/kilic/.screenlayout/main_3k_hdmi.sh
elif [[ $IF_SINAN_DISPLAY -gt 0 ]]; then
    # xmodmap -e 'keycode 49 = Escape' 
    source /home/kilic/.screenlayout/sinan.sh
elif [[ $IF_HOME_DISPLAY -gt 0 ]]; then
    source /home/kilic/.screenlayout/home.sh
else
    # xmodmap -e 'keycode 49 = Escape' 
    xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off 
fi

# encrpypt
alias ansien='ansible-vault encrypt'
alias ansidec='ansible-vault decrypt'

# Remote and clusters
alias sshhpc='ssh renanberan.kilic@192.168.115.242'
export HPC='renanberan.kilic@hpc.unitn.it'

alias sshmarzola='ssh renanberan.kilic@marzola.disi.unitn.it'
export MARZOLA='renanberan.kilic@marzola.disi.unitn.it'

alias sshdiol1='ssh beran@diol-ws1.disi.unitn.it'
alias sshws1='ssh beran@diol-ws1.disi.unitn.it'
alias sshggpu1='ssh beran@10.196.36.136'
export GGPU1='beran@10.196.36.136'
export WS1='beran@10.196.36.136'

alias sshdiol2='ssh beran@diol-ws2.disi.unitn.it'
alias sshws2='ssh beran@diol-ws2.disi.unitn.it'
alias sshggpu2='ssh beran@10.196.36.137'
export GGPU2='beran@10.196.36.137'
export WS2='beran@10.196.36.137'

#viMTerm
set -o vi
export EDITOR='/usr/bin/vim'

# Cool stuff
# echo "Sup!" | figlet | lolcat && echo
alias ccat='pygmentize -g'

export TERM=xterm-256color

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kilic/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kilic/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kilic/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kilic/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
rm -rf javasharedresources/

export BROWSER='firefox'
alias energia='/home/kilic/apps/energia-1.8.10E23/energia'

alias ccstudio='/home/kilic/ti/ccs2011/ccs/theia/ccstudio'

export PATH="$PATH:/home/kilic/apps/SEGGER/JLink_Linux_V798e_x86_64"
export PATH="$PATH:/home/kilic/apps/SEGGER/segger_embedded_studio_8.16a/bin"
export PATH="$PATH:/opt/SEGGER/JLink_Linux_V798e_x86_64"
export PATH="$PATH:/usr/local/gcc-13.3.0/bin"
export PATH="$PATH:/home/kilic/ti/ccs2011/ccs/theia/ccstudio"

#Apollo
alias apollo_debugserver='JLinkGDBServerCLExe -singlerun -nogui -port 61238 -device AMAP42KL-KBR'

#ST
export ST_PATH="/opt/st/stm32cubeide_1.16.0/plugins/"
export ST_CP_PATH="${ST_PATH}/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.linux64_2.1.400.202404281720/tools/bin"

alias st_debugserver='ST-LINK_gdbserver -p 61238 -l 1 -d -s -cp ${ST_CP_PATH} -m 0 -g'

# STM
export PATH="$PATH:/usr/local/LinkServer"
export PATH="$PATH:/opt/st/stm32cubeide_1.16.0/plugins/com.st.stm32cube.ide.mcu.externaltools.stlink-gdb-server.linux64_2.1.400.202404281720/tools/bin"
export PATH="$PATH:/opt/st/stm32cubeide_1.16.0/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.linux64_2.1.400.202404281720/tools/bin"
export PATH="$PATH:/home/kilic/apps/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/"
# export PATH="$PATH:/home/kilic/apps/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi/bin/"
#export PATH="$PATH:/opt/st/stm32cubeide_1.16.0/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.12.3.rel1.linux64_1.0.200.202406132123/tools/bin"
export PATH="$PATH:$HOME/apps/st/stm32cubeide_1.16.0/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.12.3.rel1.linux64_1.0.200.202406132123/tools/bin/"

alias "STM32CubeMX"="/home/kilic/apps/STM32CubeMX/STM32CubeMX"

conda deactivate
conda activate
alias "unitnvpn"="globalprotect connect --portal vpn-out.icts.unitn.it"
TMPDIR="~/.local/tmp"
. "$HOME/.cargo/env"

rpl() {
  if [ "$#" -ne 3 ]; then
    echo "Usage: rpl<directory> <old_string> <new_string>"
    return 1
  fi

  dir="$1"
  old="$2"
  new="$3"

  find "$dir" -type f -exec sed -i "s/${old//\//\\/}/${new//\//\\/}/g" {} +
}

# Git stuff
alias store_token="git config --global credential.helper store" # Do before using the token

# VIM AI stuff
alias vim=nvim
export PATH="$HOME/apps/zen/:$PATH"

# Screen saver off
xset s off
xset -dpms 
xset s noblank

export HYDRA_FULL_ERROR=1
