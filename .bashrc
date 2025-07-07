#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

_set_liveuser_PS1() {
    PS1='[\u@\h \W]\$ '
    if [ "$(whoami)" = "liveuser" ] ; then
        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
        if [ -n "$iso_version" ] ; then
            local prefix="eos-"
            local iso_info="$prefix$iso_version"
            PS1="[\u@$iso_info \W]\$ "
        fi
    fi
}
_set_liveuser_PS1
unset -f _set_liveuser_PS1

ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}


alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}

#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################

alias TelegramDesktop='/opt/Telegram/Telegram'
alias Telegram='/opt/Telegram/Telegram'
alias telegram='/opt/Telegram/Telegram'

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
conda activate torch22
# <<< conda initialize <<<

# <<< personal configs <<<

# # Counting number of displays connected
N_DISPLAY="$(xrandr -q | grep ' connected' | wc -l)"

if [[ $N_DISPLAY -gt 1 ]]
then
    #Disable the laptop screen
    xrandr --output eDP-1 --off 
    xrandr --output HDMI-1 --mode "1920x1080"
else
    xrandr --output eDP-1 --auto
fi
# Enable laptop screen again
# xrandr --output eDP-1 --auto

#viMTerm
set -o vi
export EDITOR='/usr/bin/vim'

# Internal keyboard default:
# xmodmap ~/.Xmodmap.orig
# IS_EXT_KEYBOARD="$(lsusb | grep '1dgb:0002' | wc -l)" # TODO: change the id
IS_EXT_KEYBOARD=0
if [[ $IS_EXT_KEYBOARD -gt 0 ]]
then
    xmodmap ~/.Xmodmap_external
else
    xmodmap ~/.Xmodmap
fi



# <<< personal configs <<<
. "$HOME/.cargo/env"

# Dagshub
export DAGSHUB_TOKEN=172e67799e39f154e363e4fd44cb6e5e35b40398

# Cool stuff
echo "Sup!" | figlet | lolcat && echo
alias ccat='pygmentize -g'

# Others
rm -df ~/Downloads
rm -df ~/ti

# General cds
alias cddown='cd /home/kilic/downloads'
alias cddoc='cd /home/kilic/documents'
alias cdws='cd /home/kilic/workspace'

# Project spesific
alias cdtinyfff='cd /home/kilic/workspace/phd/TinyFFF'
export MLFLOW_TRACKING_URI=https://dagshub.com/leocus4/TinyFFF.mlflow 
export MLFLOW_TRACKING_USERNAME=berab 
export MLFLOW_TRACKING_PASSWORD=5caf0258548d586452a73543b1f29844fcf78d81

#alias ccs='pushd /home/kilic/desktop/ti/ccs1250/ccs/eclipse && ./ccstudio && popd'
#To find occurances in files:
#$ grep -oi file file.txt
set -o ignoreeof

# Remote and clusters
alias sshsustainhp='ssh kilic@10.196.235.227'
export SUSTAINHP='kilic@10.196.235.227'

alias sshhpc='ssh renanberan.kilic@hpc2.unitn.it'
export HPC='renanberan.kilic@hpc2.unitn.it'

alias sshmarzola='ssh renanberan.kilic@marzola.disi.unitn.it'
export MARZOLA='renanberan.kilic@marzola.disi.unitn.it'

alias sshgpu='ssh beran@10.196.37.190'
export ggpu='beran@10.196.37.190'

alias sshgpu2='ssh beran@10.196.37.153'
export ggpu2='beran@10.196.37.153'

# Firefox
alias firefoxuni='firefox -P kilic-unitn'

# EdgeAI
alias stm32ai='/opt/stm32ai/stm32ai'
alias mspd='/home/kilic/mspdebug/mspdebug'

# NVIM
alias vim='nvim'
export NVCFG='/home/kilic/.config/nvim/'

# LaTeX
alias texpdf='latexmk -pdf '

# llvm and enzyme
export LLVMEN='/home/kilic/workspace/scratch/Enzyme/enzyme/build/Enzyme/LLVMEnzyme-16.so'
export CLANGEN='/home/kilic/workspace/scratch/Enzyme/enzyme/build/Enzyme/ClangEnzyme-16.so'
alias llvmopt='/home/kilic/workspace/scratch/llvm-project/build/bin/opt'
export LLVM_PATH='/home/kilic/workspace/scratch/llvm-project/build'

# encrpypt
alias ansien='ansible-vault encrypt'
alias ansidec='ansible-vault decrypt'

#doc2pdf
alias doc2pdf='abiword --to=pdf'

#keyboard language
setxkbmap us
xset -dpms # No Sleeping
alias readmevisualizer='grip'
alias arduino-ide='/home/kilic/.local/arduino-ide_2.3.1_Linux_64bit/arduino-ide'

#T TVM
export TVM_HOME=/home/kilic/downloads/tvm
export PYTHONPATH=$TVM_HOME/python:${PYTHONPATH}

export WANB='4cf2bd4f5da9b3bb639b76402564878f8b6d4125'
alias cddaily='cd /home/kilic/documents/phd_daily'
