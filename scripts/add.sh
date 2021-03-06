#!/bin/bash

# GROUP MEMBERS
# ---NAME---            ---Matric. no---
# Nicole Jackson        2415277
# Christopher O'May     2418120
# Kai Uerlichs          2421101       



# ADD.SH
# Takes a repo name and file names as arguments; adds the files into the repo and creates logs and version folder



# Create colour output variables
PREFIX="\033[0;36m[CMS]\033[0m"
CYAN="\033[0;36m"
NOCL="\033[0m"

add_function() {
    # Check if any of these characters are within contained within the specfied repository name
    if [[ $1 =~ ['.;!@#$%^&*()\/<>|:'] ]]
    then
        echo -e "$PREFIX The specified repository name is invalid. Avoid the following characters:"
        echo ". ; ! @ # $ % ^ & * ( ) \ / < > | :"
        return 0;
    fi
    # Check if a repository was specified
    if [ $# -eq 0 ]
    then
        echo -e "$PREFIX No repository was specified."
        return 0;
    fi
    REPO=/cms/repositories/$1
    # Check whether specified repository exists
    if [ ! -e $REPO ]
    then
        echo -e "$PREFIX The repository \"$1\" does not exist."
        return 0;
    fi
    
    # Check if any files were specified
    if [ ! $# -gt 1 ]
    then
        echo -e "$PREFIX No file(s) were specified."
        return 0;
    fi
    FILES=${@:2}

    # Attempt to add each file to the repository separately
    for f in $FILES
    do
        # Check if the file exists
        if [ -e $f ]
        then
            # Check if the file already exists in the repository
            if [ -e $REPO/$f ]
            then
                echo -e "$PREFIX The file \"$f\" already exists in the repository. Did you mean ${CYAN}cms checkin${NOCL}?"
            else
                # Copy and create file table entry, versions folder and log file
                cp $f $REPO
                mkdir $REPO/.cms/versions/$f
                touch $REPO/.cms/logs/$f

                # Append log entry
                DATE=$(date "+[%d-%m-%Y | %T]")
                echo "$DATE $USER added the file to the repository" >> $REPO/.cms/logs/$f

                # Append file table entry
                echo "$f;in;none;none" >> $REPO/.cms/file_table

                echo -e "$PREFIX The file \"$f\" has been added to the repository."
            fi
        else
            echo -e "$PREFIX The file \"$f\" does not exist."
        fi
    done

    return 0
}