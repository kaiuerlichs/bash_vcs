#!/bin/bash

PREFIX="\033[0;36m[CMS]\033[0m"

create_function() {
    REPOS=$HOME/cms/repositories

    if [[ $1 =~ ['.;!@#$%^&*()\/<>|:'] ]]
    then
        echo -e "$PREFIX The specified name is invalid. Avoid the following characters:"
        echo ". ; ! @ # $ % ^ & * ( ) \ / < > | :"
        return 0;
    fi

    # Create repos folder if it doesnt exist already
    mkdir -p $REPOS

    cd $REPOS
    if [ -e $1 ]
    then
        echo -e "${PREFIX} Repository \"$1\" already exists"
    else
        # Create repository folder and subfolders
        mkdir $1
        cd ./$1
        mkdir .cms
        cd ./.cms
        mkdir logs snapshots versions
        touch file_table
        cd ..

        echo -e "$PREFIX New repository \"$1\" created at $PWD"
    fi
}