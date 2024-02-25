#!/bin/bash

export RELEASE=$(lsb_release -is || echo "Ubuntu")
export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
export FONT_PATH="/usr/share/fonts/NerdFonts"

if [ $RELEASE = "Fedora" ];then
# intall needed packages
sudo dnf -y install zsh httpie fontawesome-fonts curl git fzf
elif [ $RELEASE = "Ubuntu" ];then
sudo apt -y update
sudo apt -y install fonts-font-awesome httpie zsh git fzf
fi

# install zshrc file
rm -f $HOME/.zshrc
cp zshrc $HOME/.zshrc

rm -f $HOME/.config/starship.toml
mkdir -p $HOME/.config
cp starship.toml $HOME/.config/starship.toml

# install external software
mkdir $HOME/bin
cd $HOME/bin
http --download https://github.com/golgoth31/release-installer/releases/download/v2.0.13/ri_v2.0.13_linux_amd64 --output ri
chmod 755 ri
./ri update
./ri install starship -v $(./ri list starship --noformat -n1) -d
./ri install exa -v $(./ri list exa --noformat -n1) -d
./ri install bat -v $(./ri list bat --noformat -n1) -d
./ri install ripgrep -v $(./ri list ripgrep --noformat -n1) -d
./ri install bottom -v $(./ri list bottom --noformat -n1) -d
./ri install httpie-go -v $(./ri list httpie-go --noformat -n1) -d
./ri install msk -v $(./ri list msk --noformat -n1) -d
./ri install kubecolor -v $(./ri list kubecolor --noformat -n1) -d

# install oh-my-zsh
./ht --follow -b -o /tmp/install.sh --download https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
chmod 755 /tmp/install.sh
/tmp/install.sh --unattended
rm -f /tmp/install.sh
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search.git $ZSH_CUSTOM/plugins/zsh-history-substring-search

# install fonts
./ht --follow -b -o /tmp/GoMono.tar.xz --download https://github.com/ryanoasis/nerd-fonts/releases/latest/download/GoMono.tar.xz
./ht --follow -b -o /tmp/FiraMono.tar.xz --download https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraMono.tar.xz
tar xvf /tmp/GoMono.tar.xz -C /tmp
tar xvf /tmp/FiraMono.tar.xz -C /tmp

sudo mkdir -p $FONT_PATH
sudo cp /tmp/*.otf $FONT_PATH
sudo fc-cache -v

# add zsh to user
sudo sed -i "s/^\($USER.*\)bash/\1zsh/" /etc/passwd
