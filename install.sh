#!/usr/bin/env bash
main() {
  printf "\n 
####################################
 SOCIAL-ENGENIERING-TOOLKIT
 IN TERMUX, BY : @ALIENKRISHN
####################################
   
[*] installtion will take upto 700mb internet
and 2gb storage...install it (yes/no)
  "
  read chs
  if [[ $chs == yes ]]; then
    echo "Installing setoolkit in termux..."
    mv setoolkit $PREFIX/bin
  else
    echo -e "Bye bye..."
    sleep 2
    exit 0
  fi
}

checkarch() {
  arch=$(uname -m)
  if [[ $arch != aarch64 ]]; then
    echo -e "Your device arch is not supported"
    sleep 2
    exit 1
  fi
}

insdeps() {
	printf "\n[*] Updating apt cache..."
	apt update -y &> /dev/null
	echo "\n [*] Checking for all required tools..."

	for i in proot tar curl; do
		if [ -e $PREFIX/bin/$i ]; then
			echo "\n  • ${i} is OK"
		else
			echo "\nInstalling ${i}..."
			apt install -y $i || 
                        {
				printf "\nERROR: check your internet connection or apt"
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
  fi
}
main
checkarch
insdeps
inset

