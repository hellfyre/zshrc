# add prompts to fpath
fpath+=( $ZSH/prompt )

# initialize the prompt contrib
autoload promptinit ; promptinit

# if this is me, don't show the name
[[ $USER == valodim ]] && zstyle ':prompt:*:ps1' hide-user 1

# couple of fixed custom hostname colors
zstyle ':prompt:*:tartaros*'    host-color blue
zstyle ':prompt:*:chaos*'       host-color red
zstyle ':prompt:*:cupcake*'     host-color green

# check-for-changes can be really slow. I WANT IT though :P
zstyle ':vcs_info:*' check-for-changes true

# if we are on a rxvt-unicode-256color, chances are we have powerline font enabled
if [[ $TERM == "rxvt-unicode-256color" ]]; then
    # yay, this is home! no way to detect if powerline font is available, but oh well..
    if (( $+functions[prompt_powerline_setup] )); then
        prompt powerline
    else
        prompt valodim
    fi
else
    # no 256 color terminal? fall back to my plain old prompt, then
    prompt valodim
fi
