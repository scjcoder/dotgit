export PATH="$HOME/Library/Haskell/bin:$PATH"

#source <(curl code.scj.net/bashal_mac)

# load custom git repo prompts
echo source $HOME/.oh-my-git/prompt.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"

# Powerline
export PATH=$PATH:$HOME/Library/Python/3.6/bin
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh
