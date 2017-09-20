#!/bin/bash
##########################################################################
# Usage: bash HW1_bianca.sh <file1> <file2>
# NOTE: the files will be conveniently generated in the folder where the initial files are found, not where the script is found :)

#Shell script to retrieve the additional information for the genes present in UP and DOWN only files and to generate a list of redundant gene names from the said file
# $1 - path to file with genes UP / DOWN only
# $2 - path to the file with all genes

echo "Analyzing table..."

loops=`cat $1 | wc -l`  #the number of loops will be equal to the number of lines in the given file

#repeat the following task as many times as there are lines in the given file

x=1
while [ $x -le $loops ]
	do
		line=`head -$x ${1} | tail -1` #this takes the line number x from the given file
		cat $2 | awk -v extrainfo="$line" '{if($1 == extrainfo) print $0}' >> ${1}_additionalinfo.txt
		x=$[$x+1] #forward 1 into the while loop
	done

echo "Gene information table generated!"

cat $1 | sort -k 1 | uniq -cd > ${1}_redundancies.txt

echo "List of redundancies generated!"
