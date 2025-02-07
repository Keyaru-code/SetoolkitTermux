#!/usr/bin/env bash
main() {
  cat assets/logo
  printf "\e\t\t[0;1msetoolkit in termux"
  printf "\e[32m 
-------------------------------------
\e[0m[*] installtion will take upto
\e[32m700mb\e[0m internet and \e[32m2gb\e[0m
storage...install it (yes/no): "
  read chs
  if [[ $chs == yes ]]; then
    echo -e "\e\v[36mInstalling setoolkit in termux...\e[0m]"
    mv assets/setoolkit $PREFIX/bin
  else
    echo -e "\vBye bye..."
    sleep 1
    exit 0
  fi
}

checkarch() {
  arch=$(uname -m)
  if [[ $arch != aarch64 ]]; then
    echo -e "\e[31mYour device arch is not supported\e[0m"
    sleep 2
    exit 1
  fi
}

insdeps() {
	printf "\n\e[34m[*] Updating apt cache...\e[0m"
	apt update -y &> /dev/null
	echo "\n [*] Checking for all required tools..."

	for i in proot tar curl; do
		if [ -e $PREFIX/bin/$i ]; then
			echo "\n  • ${i} is OK"
		else
			echo "\nInstalling ${i}..."
			apt install -y $i || 
                        {
				printf "\n\e[31mERROR: check your internet connection or apt\e[0m"
				printf "\n Exiting...\n"
				exit 1
			}
		fi
	done
	apt upgrade -y
}

inset() {
  if [[ -d $PREFIX/share/setoolkit ]]; then
    printf "\nHein..setoolkit is already installed"
    exit 0
  else
    mkdir -p $PREFIX/share/setoolkit
    cd $PREFIX/share/setoolkit
    echo -e "\e[32mDownloading setoolkit tar file please wait...\e[0m\n"
    curl -LO https://github.com/Keyaru-code/SetoolkitTermux/releases/download/8.0.3/setoolkit.tar.xz
    tar -xvJf setoolkit.tar.xz
    rm -rf setoolkit.tar.xz
    printf "
    setoolkit installed...now you can execute it 
    by typing '\e[32msetoolkit\e[0m' !!
    "
  fi
}
clear
main
checkarch
insdeps
inset

