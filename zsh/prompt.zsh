# http://zshwiki.org/home/config/prompt
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Other-Functions

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

source "$ZSH/addons/git-prompt.sh"

# $PS1 should undergo parameter expansion
setopt prompt_subst

# Readable aliases for prompt format string
local user="%n"
local host="%m"
local current_dir="%~"
local sh_jobs="%(1j. [%j].)"     # only print jobs if there's at least one

# Color code cheat sheet: %F{colorname} sets foreground to that color; %f resets.

local pre_git_prompt='%F{cyan}${user}@${host}%F{white}:%f${current_dir}'
local post_git_prompt='%F{yellow}${sh_jobs}%f
%F{blue}$(virtualenv_info)%F{cyan}%# %f'

GIT_PS1_SHOWDIRTYSTATE=yep
GIT_PS1_SHOWCOLORHINTS=yeah
GIT_PS1_SHOWUNTRACKEDFILES=yes

precmd () {
    # Color aliases so that the % chars aren't in the string passed to printf
    wh='%F{white}'
    rs='%f'

    # Use the form of __git_ps1 that sets the prompt itself because it's
    # allegedly faster
    __git_ps1 "$pre_git_prompt" "$post_git_prompt" ' on ${wh}git${rs}:%s'

    # sets the tab title to current dir
    echo -ne "\e]1;${PWD##*/}\a"
}

