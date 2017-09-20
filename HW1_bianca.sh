#!/bin/bash
##########################################################################
# Usage: bash HW1_bianca.sh <file>
# NOTE: the files will be conveniently generated in the folder where the initial table is found, not where the script is found :)

#Shell script to split the table from HW1 into up and down regulated genes
# $1 - path to file to be split, which is the first argument of this script

echo "Analyzing table...this took 50 minutes on my laptop"

sed -i -e "1d" $1  #this is to remove the header of the table but be careful - whenever you rerun this script, the table shortens by one line
loops=`cat $1 | wc -l`  #the number of loops will be equal to the number of lines in the given file

#repeat the following task as many times as there are lines in the given file

x=1
while [ $x -le $loops ]
	do
		line=`head -$x ${1} | tail -1` #this takes the line number x from the given file
		y=`echo $line | cut -d " " -f 2 | rev | cut -d "." -f 2` #this takes the line (now somehow space delimited instead of tab - splits it by spaces and takes the second entry only. Then it reverses it, separates the number into before and after the dot and takes only what's after the dot (which is the integer part only) - so that you get an integer which is the only concept bash seems to have when it comes to numbers

		if [ $y -ge 1 ] #if this retrieved integer is larger or equal to 1
			then
		 	echo $line >> ${1}_upregulatedgenes.txt  #then append it to the upregulated genes
			else
		 	echo $line >> ${1}_downregulatedgenes.txt #otherwise append it to downregulated genes
		fi
		x=$[$x+1] #forward 1 into the while loop
#		echo $x # - not needed but I wanted to see the progress of this script that took ages to run
	done


echo "Downregulated genes table generated!"
echo "Upregulated genes table generated!"



##########################################################################
# Much faster, awk solution

#	cat "$1" | awk '{if($2<"1") print $0}' >> ${1}_downregulated.txt

# echo "Downregulated genes table generated!"

#	cat "$1" | awk '{if($2>=1) print $0}' >> ${1}_upregulated.txt

# echo "Upregulated genes table generated!"
