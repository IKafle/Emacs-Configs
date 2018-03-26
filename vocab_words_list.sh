#!/bin/bash

filename1="/tmp/tmp.txt";

base_url="https://www.vocabulary.com";

word_list="$base_url/lists"

ruben_list_id="2036704";

COLOR_BEGIN='\e[94m';

COLOR_END='\e[0m';

function write_to_file(){
    
    `lynx -dump echo "$word_list/$ruben_list_id" | awk '/show/{flag=1;next}/Sign/{flag=0}flag' | tr --delete . | sed 's/\[[^]]*\]//g' > $filename1` 
    
}

function generate_word(){

    IFS=

    file=$(cat $filename1);
    
    count=`echo $file | awk '$1~/^[0-9]+$/' | wc -l`;

    randomnumber=`shuf -i 1-$count -n 1`;

    randomword=`echo $file | awk -v id="$randomnumber" '/[[:digit:]]/{p++}p==id'`;
    
    word=`echo $randomword | tr --delete [[:digit:]]`

    echo "$word";
}


function dictionary(){

    desc=`html2text "$base_url/dictionary/$1" | awk -v word="# $1" '$0 ~ word,/\[/' | sed -e '1d' -e '$d'`;
    
    echo "$desc";
}


function check_connection(){

    wget -q --spider http://google.com;

    echo $? ;
    
}


function write_to_console(){

    info=`generate_word`;

    connection=`check_connection`;

    echo -e "$info";
    
    if [[ $connection -eq 0 ]];then
	
	root=`echo "$info" | head -n1 | awk '{print $1;}'`;
	
	description=`dictionary $root`;
	
	echo -e " -----\n$COLOR_BEGIN Vocabulary.com $COLOR_END-----\n";
	
        echo "$description" ;

    fi;
    
}



function init(){

    connection=`check_connection`;
    
    if [[ -f `echo $filename1` ]];then
	
	if [[ ! -s `echo $filename1` ]]; then

	    if [[ $connection -eq 0 ]];then
		write_to_file;
		write_to_console;

	    else
		`echo fortune`;
	    fi 
	    
	else
	    write_to_console;
	    
	fi
	
    else

	if [[ $connection -eq 0 ]];then
	    write_to_file;
	    write_to_console;

	else
	    `echo fortune`;
	fi 
	
    fi
}

init;
