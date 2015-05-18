#!/bin/bash

# Set color and bold and no echo
_f() { set +x; tput setaf 1; tput bold; }

# Unset color and bold and set echo
_uf() { tput sgr0; set -x; $1; _f; }


_f
echo "This script sets up your environment"
echo "First we are going to update, upgrade, then update again"
echo "This may take a while"

echo -n "Would you like to update / upgrade? [Y/n]:"
read ans
if [ "${ans}" != "n" ]; then
    _uf 'sudo apt-get update'
    _uf 'sudo apt-get upgrade'
    _uf 'sudo apt-get update'
fi


echo -n "Are you going to use vi? [Y/n]:"
read ans
if [ "${ans}" != "n" ]; then

    # Install full vim
    _uf 'sudo apt-get install vim'

    SOURCE="vimrc"
    if [ -f ${SOURCE} ]; then

        TARGET="${HOME}/.virmc"
        echo -n "Replace personal vimrc? [Y/n]:"
        read ans
        if [ "$ans" != 'n' ]; then
            if [ -f ${TARGET} ]; then
                echo "Moving existing ${TARGET} to ${TARGET}.old"
                _uf "mv ${TARGET} ${TARGET}.old"
            fi
            echo "Copying ${SOURCE} to ${TARGET}"
            _uf "cp ${SOURCE} ${TARGET}"
        fi

        TARGET="/etc/skel/.virmc"
        echo -n "Put into /etc/skel/.vimrc? [Y/n]:"
        read ans
        if [ "$ans" != 'n' ]; then
            if [ -f ${TARGET} ]; then
                echo "Moving existing ${TARGET} to ${TARGET}.old"
                _uf "sudo mv ${TARGET} ${TARGET}.old"
            fi
            echo "Copying ${SOURCE} to ${TARGET}"
            _uf "sudo cp ${SOURCE} ${TARGET}"
        fi

        TARGET="/etc/vim/vimrc"
        echo -n "Replace ${TARGET}? [Y/n]:"
        read ans
        if [ "$ans" != 'n' ]; then
            if [ -f ${TARGET} ]; then
                echo "Moving existing ${TARGET} to ${TARGET}.old"
                _uf "sudo mv ${TARGET} ${TARGET}.old"
            fi
            echo "Copying ${SOURCE} to ${TARGET}"
            _uf "sudo cp ${SOURCE} ${TARGET}"
        fi

        echo -n "Updating system-wide default editor"
        _uf 'sudo update-alternatives --config editor'
    fi
fi 

SOURCE="profile"
if [ -f ${SOURCE} ]; then

    TARGET="${HOME}/.profile"
    echo -n "Replace personal profile? [Y/n]:"
    read ans
    if [ "$ans" != 'n' ]; then
        if [ -f ${TARGET} ]; then
            echo "Moving existing ${TARGET} to ${TARGET}.old"
            _uf "mv ${TARGET} ${TARGET}.old"
        fi
        echo "Copying ${SOURCE} to ${TARGET}"
        _uf "cp ${SOURCE} ${TARGET}"
    fi

    TARGET="/etc/skel/.profile"
    echo -n "Put into /etc/skel/.profile? [Y/n]:"
    read ans
    if [ "$ans" != 'n' ]; then
        if [ -f ${TARGET} ]; then
            echo "Moving existing ${TARGET} to ${TARGET}.old"
            _uf "sudo mv ${TARGET} ${TARGET}.old"
        fi
        echo "Copying ${SOURCE} to ${TARGET}"
        _uf "sudo cp ${SOURCE} ${TARGET}"
    fi
fi


SOURCE="bashrc"
if [ -f ${SOURCE} ]; then

    TARGET="${HOME}/.bashrc"
    echo -n "Replace personal bashrc? [Y/n]:"
    read ans
    if [ "$ans" != 'n' ]; then
        if [ -f ${TARGET} ]; then
            echo "Moving existing ${TARGET} to ${TARGET}.old"
            _uf "mv ${TARGET} ${TARGET}.old"
        fi
        echo "Copying ${SOURCE} to ${TARGET}"
        _uf "cp ${SOURCE} ${TARGET}"
    fi

    TARGET="/etc/skel/.bashrc"
    echo -n "Put into /etc/skel/.bashrc? [Y/n]:"
    read ans
    if [ "$ans" != 'n' ]; then
        if [ -f ${TARGET} ]; then
            echo "Moving existing ${TARGET} to ${TARGET}.old"
            _uf "sudo mv ${TARGET} ${TARGET}.old"
        fi
        echo "Copying ${SOURCE} to ${TARGET}"
        _uf "sudo cp ${SOURCE} ${TARGET}"
    fi
fi

echo "Setting up git preferences"
_uf "git config --global core.editor 'vi'"
_uf "git config --global user.email 'github-ifermon@sneakemail.com'"
_uf "git config --global user.name 'Ivan'"

# Get us back to normal
echo "All done!"
_uf :

