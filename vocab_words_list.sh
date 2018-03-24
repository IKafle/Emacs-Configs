#!/bin/bash

filename1="/tmp/tmp.txt";

base_url="https://www.vocabulary.com";

word_list="$base_url/lists"

ruben_list_id="2036704";

COLOR_BEGIN='\e[94m';

COLOR_END='\e[0m';

function write_to_file(){

    if [ ! -f `echo $filename1` ]; then
	
	`lynx -dump echo "$base_url/$word_list/$ruben_list_id" | awk '/show/{flag=1;next}/Sign/{flag=0}flag' | tr --delete . | sed 's/\[[^]]*\]//g' > $filename1` 
	
    fi
    
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


function write_to_console(){

    info=`generate_word`;
    
    root=`echo "$info" | head -n1 | awk '{print $1;}'`;
    
    description=`dictionary $root`;
    
    echo -e "$info";
    
    echo -e " -----\n$COLOR_BEGIN Vocabulary.com $COLOR_END-----\n";
    
    echo "$description" ;
}


function init(){

    if [ -f `echo $filename1` ]; then

	write_to_console;
    else
	wget -q --spider http://google.com;

	if [ $? -eq 0 ]; then
	    write_to_file;
	    write_to_console;
	else
	    `echo fortune | lolcat`;
	fi

    fi
    

}


init;





