#!/bin/bash

connect() {
echo "Hello With My Database :)"

  echo -e "\---Main Menu---"
  echo " 1. Creat Database               "
  echo " 2. List Database                "
  echo " 3. Connect Database             "
  echo " 4. Drop Database                "
  echo "-------------------"
  echo -e "Enter Choice: \c"
read ch
case $ch in

    1) createdb ;;
    2)  listdb ;;
    3)  connectdb ;;
    4)  dropdb ;;
    *) echo " Wrong Choice " ;;
esac
connect
}


createdb() {
	echo -n "Please enter your database name: "
	read name
	exitflag=0
	while [ $exitflag -eq 0 ];do

	if [[ $name == *['!''?'@\#\%^\&*()-+\.\/';']* ]]
	then
	echo "! @ # $ % ^ () ? + ; . -  are not allowed!"
	echo -n "Please enter a valid name: "
	read name
	continue
	fi

	if [[ $name = *" "* ]]; then
	echo "----spaces are not allowed!"
	echo -n "Please enter a valid name: "
	read name
	continue
	fi

	if [ -z $name ];then
	echo -n "Please enter a name: "
	read name
	continue
	fi

	if [ -d dbs/$name ];then
	echo "Database already exists"
	echo -n "Please enter another name: "
	read name
	else
	mkdir dbs/$name/
	echo "Database successfully created :)"
        exitflag=1
	fi
	done

}

listdb () {
	index=1
	echo "---------------------------------"
	for db in `ls dbs/`
	do
	echo $index - $db
	index=$[$index + 1]
	done
	echo "---------------------------------"

}


connectdb () {
	echo "Please enter the name of the database you want to connect to: "
	echo -n "Name: "
	read name

	exitflag=0
	while [ $exitflag -eq 0 ];do

	if [ -z $name ];then
	echo -n "Please enter the name: "
	read name
	continue
	fi
	if [ -d dbs/$name ];then
	connectdbName=$name
        ./tablemenu.sh
	exitflag=1
	else
	echo "No such Database found"
	echo -n "Enter another name: "
	read name
	fi
	done

}


dropdb () {
	echo "Enter Database Name to drop: "
	read name 
	if [ -d  "dbs/$name" ]; then 
    	rm -r dbs/$name
    	echo "$name database  deleted Successfully"
  	else 
    	echo "No such Database"
	fi
}

connect
