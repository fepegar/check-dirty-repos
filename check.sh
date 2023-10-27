for repo in `ls`
do
    # Check that $repo is a dir
    if [ ! -d "$repo" ]
    then
        continue
    fi

    cd $repo
    if [ -d ".git" ]
    then
        if [ -z "$(git status --porcelain)" ]
        then
            :  # tput setaf 2; echo "No changes in $repo"
        else
            tput setaf 3; echo "Uncommited changes found in $repo"
        fi

        STASH_LINES=`git stash list | wc -l`
        if [ $STASH_LINES -gt 0 ]
        then
            tput setaf 4; echo "Stash found in $repo"
        fi
    else
        tput setaf 1; echo "Error: no .git found in $repo"
    fi
    cd ..
done
tput sgr0
