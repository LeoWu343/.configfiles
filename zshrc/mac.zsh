# necessary for macOS Sierra's ssh key forwarding to work
ssh-add -K &> /dev/null

# brew shortcuts
alias brew-update="brew update && brew upgrade"
alias brew-cleanup="brew cleanup && brew cleanup -s"
alias brew-brew="brew-update && brew-cleanup"

