@echo off

echo "Git: aliases"
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.l "log --graph --pretty=format:'%C(yellow)%h%Creset%C(blue)%d%Creset %C(white bold)%s%Creset %C(white dim)(by %an %ar)%Creset'"
git config --global alias.ll "log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --numstat"
git config --global alias.ls "log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate"
git config --global alias.filelog "log -u"
git config --global alias.fl "log -u"
git config --global alias.diff "diff --word-diff"
git config --global alias.dc "diff --cached"

echo "Git: set default push strategy to simple"
git config --global push.default simple

