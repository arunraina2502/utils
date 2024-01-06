#! /bin/bash
#=============================================================================| 
# Copyright (C) 2015 Dr.-Ing. Arun Raina (E-Mail: arunraina@icloud.com)
# 
# This is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This code is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this code. If not, see <http://www.gnu.org/licenses/>.
#=============================================================================|
#
# Bash script to run the abaqus program recursively by changing 
# parameters in the input file.                          
#
#
# Give the name of abaqus input file
#
infile="inputfile.inp"
#
# Give the name of the parameter in input file to be changed 
#
param="Gc"
#
# Make an array of new parameters
#
newparam=(1.31 13.1)
#
# NO CHANGES ARE TO BE MADE IN THE FOLLOWING LINES 
#
for i in "${newparam[@]}" 
do
# 
# Modify the paramter from input file and save the modified file
#
  fname=$(echo $infile|cut -d'.' -f1)
  sed 's!\$ .*!'"$param = $i"'!' <$infile >$fname\_$param\_$i
  outfile=$fname\_$param\_$i
  printf "Creating input file: ${outfile}.inp \n\n"
done
#
# Run abaqus recursively for each new parameter
#
for j in "${newparam[@]}"
do
if [ -e $fname\_$param\_$j ]
then
  outfile=$fname\_$param\_$j 
  mv "$outfile" "${outfile}.inp"
  printf "Processing modified input file: ${outfile}.inp \n\n"
  abaqus job=$outfile double interactive
else
  echo "ERROR: Could not find the required input file."
  exit
fi
done
#
# Postprocess generated odb files for XY plots
#
[[ -d odb1 ]] || mkdir odb1
mv *.odb odb1
cd odb1
for j in "${newparam[@]}"
do
outfile=$fname\_$param\_$j
if [ -e ${outfile}.odb ]
then
  printf "Processing modified odb file: ${outfile}.odb \n\n"
  abaqus cae noGUI=script_xyplot -- ${outfile}.odb ${outfile}.dat 
else
  echo "ERROR: Could not find the required odb file."
  exit
fi
done
rm abaqus.rpy*
