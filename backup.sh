#!/bin/bash
#=============================================================================| 
# Copyright (C) 2014 Dr.-Ing. Arun Raina (E-Mail: arunraina@icloud.com)
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
# Backup plan from Notebook -> Ext Back Up
# 
#-------------------------------------------
# sync of Notebook to external back up drive 
#-------------------------------------------

# Provide path of data to be backed up, e.g.
nb="/mnt/disk/data-to-be-backed-up"
# Provide path of external storage, e.g.
hdd="/run/media/research/location-where-back-up-is-saved"

#***********************************
rsync -atuvz --stats $nb $hdd

# use exclude command to ignore certain files and directories
# --exclude={'*.cc','*.zip','*.gz','tecp/','*~'}

#***********************************
echo
echo "Notebook fully backed up to external disk"
date
echo

#---------------------------------------
# record time of sync
#---------------------------------------
date >> /run/media/research/location-where-back-up-is-saved


