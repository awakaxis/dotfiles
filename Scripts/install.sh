#!/usr/bin/zsh

ONLYNEW=0

if [[ $1 == "-n" ]]; then
    ONLYNEW=1
fi

echo "Looking for dotfiles to link out from the CWD ($(pwd))\nBackups will be created in $(pwd)/backups/"
read -k1 "?press any key to continue..."

for file in $(find .); do

    if [[ $file == "./.git/"* || $file == "./backups"* || $file == "./Scripts/install.sh" ]]; then
        echo "skipping: $file"
        continue
    fi

    BACKUPS="$(pwd)/backups/"

    if [[ ! -d $BACKUPS ]]; then
        mkdir $BACKUPS
    fi

    realfile="$(pwd)${file:1}"
    dest="${HOME}${file:1}"

    if [[ -d $realfile ]]; then
        if [[ ! -d $dest ]]; then
            echo "Creating  ${dest}  because it does not exist"
            mkdir $dest
        fi
    else
       if [[ -f $dest ]]; then
           if [[ $ONLYNEW == 1 ]]; then
               continue
           fi
           echo "File exists: $dest"
           read "VAL?Do you want to replace this file? [Y/n]: "
           if [[ -z $VAL || $VAL == [Yy] ]]; then
               echo "Replacing..."
               bakfile="$BACKUPS${dest/${HOME}\//}.bak"
               mkdir -p $(dirname $bakfile)
               cp $dest $bakfile

               rm $dest
               ln -s $realfile $dest
               echo "Replaced $dest."
           fi
       else
           echo "Creating link for: $dest"
           ln -s $realfile $dest
       fi
    fi
done

