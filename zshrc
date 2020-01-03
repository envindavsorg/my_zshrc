# !/bin/zsh
# Created by Cuzeac Florin
# mail@cuzeacflorin.design
# Zsh configuration file


#######################################################################################
############################### ZSH configuration #####################################
#######################################################################################


################################### Exports ###########################################

export ZSH="/Users/envindavsorg/.oh-my-zsh" # path to oh-my-zsh installation
export EDITOR=/usr/bin/vim # default text editor
export BLOCKSIZE=1m # files size
export CLICOLOR=1 # terminal colors


#################################### Themes ############################################

ZSH_THEME=powerlevel10k/powerlevel10k
POWERLEVEL10K_MODE='awesome-fontconfig'
POWERLEVEL10K_MODE="nerdfont-complete" # set name of the theme to load
POWERLEVEL9K_MODE="awesome-patched"
COMPLETION_WAITING_DOTS="true" # display red dots whilst waiting for completion

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh # to customize prompt, run `p10k configure` or edit ~/.p10k.zsh

eval $(thefuck --alias) # thefuck alias config

#################################### History ###########################################

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE # Saving the zsh history

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell


############################ Autocompletion and autocorrect ############################

setopt correct_all # autocorrect commands

autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi # smart autocompletion

zmodload -i zsh/complist # load the complist module, it provides a menu list from where we can highlight and select completion results

setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion


######################################### Plugins #######################################

plugins=(git fast-syntax-highlighting zsh-autosuggestions history-substring-search zsh-syntax-highlighting) # plugins to load


###################################### Directories ######################################

setopt auto_cd
setopt auto_pushd
unsetopt pushd_ignore_dups
setopt pushdminus


#######################################################################################
############################## User configuration #####################################
#######################################################################################

source $ZSH/oh-my-zsh.sh

#   ----------------  #
#   1. Shell options  #
#   ----------------- #

# root
	alias s="sudo -s"

# clear the terminal
	alias c="clear"

# show the curent SHELL
	alias bash="env | grep SHELL"

# update ZSH
	alias update="source .zshrc"

# upgrade ZSH
	alias upgrade="upgrade_oh_my_zsh"

# Auto-complete in terminal
	alias cic="set completion-ignore-case On"

# Recovery an alias
	showa () { /usr/bin/grep --color=always -i -a1 $@ ~/.zshrc | grep -v '^\s*$' | less -FSRXc ; }


#####################################################################################################################################


#   -------------------  #
#   2. Files management  #
#   -------------------  #

# confirm before copy
	alias cp="cp -iv"

# confirm before cut
	alias mv="mv -iv"

# hidden files
	alias hideon="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"

# hide the hidden files
	alias hideoff="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"

# show a file tree ( apt install tree)
	alias tree="tree -CFa -I 'rhel.*.*.package|.git' --dirsfirst"

# create a blank file ( 1MB )
	alias make1mb="mkfile 1m ./1MB.dat"

# create a blank file ( 5MB )
	alias make5mb="mkfile 5m ./5MB.dat"

# create a blank file ( 10MB )
	alias make10mb="mkfile 10m ./10MB.dat"

# file in the trash
	trash () { command mv "$@" ~/.Trash ; }


#####################################################################################################################################


#   ----------------------------------  #
#   3. Folders management and archives  #
#   ----------------------------------  #

# return to the root folder
	alias home="cd ~"

# count files in folder
	alias numfiles="echo $(ls -1 | wc -l)"

# open a folder in Finder
	alias f="open -a Finder ./"

# show folders with .exec files
	alias path="echo -e ${PATH//:/\\n}"

# new folder and jump inside
	mkcd(){ NAME=$1; mkdir -p "$NAME"; cd "$NAME"; }

# confirmation when new folder is created
	alias mkdir="mkdir -pv"

# list infos in folder about files
	alias ll="ls -FGlAhp"

# create a zip archive
	zipf () { zip -r "$1".zip "$1" ; }

# extract
	extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' ne peut pas être extrait via extract()" ;;
             esac
         else
             echo "'$1' fichier non valide"
         fi
    }


#####################################################################################################################################


#   ---------------------  #
#   4. Search in terminal  #
#   ---------------------  #

# Search file quickly
	alias find="find . -name "

# Search files in a specific folder
	ff () { /usr/bin/find . -name "$@" ; }

# Search a file with a specific character chain
	ffs () { /usr/bin/find . -name "$@"'*' ; }

# Search a fil who ends with a specfic character chain
	ffe () { /usr/bin/find . -name '*'"$@" ; }


#####################################################################################################################################


#   ------------  #
#   5. Processes  #
#   ------------  #

# show the processes
	my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#####################################################################################################################################


#   -----------  #
#   6. Network   #
#   -----------  #

# show the IP address
	alias myip="curl ip.appspot.com"

# ping
	alias ping="ping 8.8.8.8"

# show the TCP/IP ports
	alias netCons="lsof -i"

# show all the open ports
	alias net="lsof -iTCP -sTCP:LISTEN -n -P"

# clean the DNS cache
	alias flushDNS="dscacheutil -flushcache"

# show open ports in the network
	alias lsock="sudo /usr/sbin/lsof -i -P"

# infos on en0
	alias ipInfo0="ipconfig getpacket en0"

# infos on en1
	alias ipInfo1="ipconfig getpacket en1"

# show the network status
	ii() {
        echo -e "\nConnecté sur ${RED}$HOST"
        echo -e "\nInformations utiles:$NC " ; uname -a
        echo -e "\n${RED}Utilisateurs connectés:$NC " ; w -h
        echo -e "\n${RED}Date :$NC " ; date
        echo -e "\n${RED}Informations machine:$NC " ; uptime
        echo -e "\n${RED}Localisation:$NC " ; scselect
        echo -e "\n${RED}Adresse IP publique:$NC " ;http://whatismyipaddress.com/fr/mon-ip
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }


#####################################################################################################################################


#   -----------------------------------------  #
#   7. System configuration and informations   #
#   -----------------------------------------  #

# system details
	alias hardware="/usr/sbin/system_profiler SPHardwareDataType"

# name and speed CPU
	alias cpu="sysctl -n machdep.cpu.brand_string"

# restart the Finder
	alias restartfinder="killall -kill Finder"

# restart the Dock
	alias restartdock="killall -kill Dock"

# add a blank space in Dock 
	alias space="defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}' && killall Dock"

# restore the default settings in Dock
	alias defaultdock="defaults delete com.apple.dock&&killall Dock"

# restart the menu bar
	alias restartbarmenu="killall -kill SystemUIServer"

# macOS version
	alias version="tail /System/Library/CoreServices/SystemVersion.plist | grep -A 1 "ProductVersion""

# remove all the .DS_Store file
	alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

# screensaver
	alias veille="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background"

# hide stock macOS apps
	alias hideapps="s chflags hidden Automator.app Books.app Calculator.app Calendar.app  Chess.app  Contacts.app  Dashboard.app  Dictionary.app  FaceTime.app  Font\ Book.app Home.app  Image\ Capture.app Launchpad.app  Mail.app  Maps.app  Messages.app  Mission\ Control.app  Notes.app  News.app  Photo\ Booth.app  Photos.app  Preview.app  QuickTime\ Player.app  Reminders.app  Siri.app  Stickies.app  Stocks.app  TextEdit.app  Time\ Machine.app  Utilities  VoiceMemos.app"

# open file in Sublime Text
	alias sublim="open -a /Applications/Sublime\ Text.app"


#####################################################################################################################################


#   ----------------------  #
#   8. Development aliases  #
#   ----------------------  #

#	8.1 - PYTHON

	alias venv2="virtualenv -p python"

	alias venv3="virtualenv -p python3"

	alias pin="pip install"

	alias uwsgi="uwsgi --socket 0.0.0.0:8000 --protocol=http -w main"

	alias pipr="pip install -r requirements.txt"

#	8.2 - NPM

	alias npml="npm list -g --depth=0"

	alias nis="npm install --save "

	alias fix="npm audit fix"

	alias ffix="npm audit fix --force"

	alias nrm="rm -rf package-lock.json & rm -rf node_modules/"

#	8.3 - GIT
	
	alias gac="git add . && git commit -a -m "

#	8.4 - Web servers
	
	alias server="./.servers.sh"

#	8.5 - Install macOS environment
	
	alias server="./.install.sh"


#####################################################################################################################################

#   ----------------------  #
#   9. Software aliases     #
#   ----------------------  #

#	9.1 - Chrome
	
	alias chromenocors=" open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security"



#####################################################################################################################################















	source $ZSH/oh-my-zsh.sh
