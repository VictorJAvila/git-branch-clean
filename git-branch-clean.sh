#!/bin/bash
function exit_message() {
    echo -e "\e[1;31m$1\e[0m"
    exit 1
}

CURRENT_BRANCH=$(git branch --show-current 2> /dev/zero)

if [ "$?" != 0 ]
then
    exit_message "El directorio actual no es un repositorio GIT"
fi

# Check is there is changes on current branch
if [ -n "$(git status --porcelain)" ]
then
    exit_message "La rama actual tiene cambios pendientes. Operación cancelada"
fi

echo -e "Te encuentras en la rama \e[1;32m$CURRENT_BRANCH\e[0m. ¿Continuar? (y/n) "
read -n1

if [ "$REPLY" != "y" ]
then
    exit_message "\nOperación cancelada"
fi

# Get merged local branches on master
MERGED_BRANCHES=$(git branch --merged $CURRENT_BRANCH | grep -v "$CURRENT_BRANCH$" | grep -v "master$" | grep -v "develop$" | grep -v "main$")

if [ -z "$MERGED_BRANCHES" ]
then
    exit_message "\nNo se han encontrado ramas locales para eliminar."
fi

echo -e "\nSe han encontrado las siguientes ramas mergeadas localmente: \n"
echo "$MERGED_BRANCHES"

echo -e "\n¿Estás seguro de querer \e[1;31meliminar\e[0m las ramas? (y/n) "
read -n1

if [ "$REPLY" == "y" ]
then
    echo "\n"
    git branch -d $MERGED_BRANCHES
    echo -e "\e[1;32mOperación realizada correctamente.\e[0m"
    exit 0
else
    exit_message "\nOperación cancelada"
fi