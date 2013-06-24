# vim: set syntax=zsh:

autoload -U add-zsh-hook

setopt promptsubst

# bunch of custom hostname colors. for most, t2cc works just fine. :)
typeset -A hostcolors
hostcolors=(
    chaos $FG[245]
    )


add-zsh-hook precmd valodim_precmd
function valodim_precmd {
  if [[ -w $PWD ]]; then
      pwdstat="%B%F{blue}"
  elif [[ -r $PWD ]]; then
      pwdstat="%B%F{yellow}"
  else
      pwdstat="%B%F{red}"
  fi
  [[ -O $PWD ]] && pwdstat+=":" || pwdstat+="."

  # add info about localhist status
  # note this looks default if no localhist specific stuff happens at all
  [[ -z $localhist ]] && pwdstat+="%F{blue}" || pwdstat+="%F{cyan}"
  [[ -z $localhist_disable ]] && pwdstat+=":" || pwdstat+="."

  vcs_info 'prompt'
}

function lprompt {
    user="%(!.%F{red}root%f@.%n@)"

    if [[ -n $hostcolors[$HOST] ]]; then
      local host_color="${hostcolors[$HOST]}"
    else
      local host_color=$FG[$(t2cc $HOST)] #$'\e'"[`$ZSH/t2cc $HOSTNAME`m"
    fi
    local host="%{${host_color}%}%M%{$reset_color%}"

    local shlvl="%(4L.%L .)"
    local exstat="%(?..%B%F{red}%?)"

    local gitinfo='${${vcs_info_msg_0_%%.}/$HOME/~}'

    pwdstat="%B%F{blue}::"

    PROMPT="[${user}${host}] ${shlvl}\${pwdstat}${exstat} $gitinfo %b%f"
}

function rprompt {
    local hist='%!'
    RPS1="${hist}"
}

lprompt
rprompt
