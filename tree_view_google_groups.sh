#!/bin/bash
 
# Author:       ssarcandy@cmlab.csie.ntu.edu.tw 
# Last updated: 2017-04-27
# 
# Usage:
#  ./tree_view_google_groups.sh <group_name@cmlab.csie.ntu.edu.tw>
#
# Example:
#  ./tree_view_google_groups.sh ggroup_m1@cmlab.csie.ntu.edu.tw
#
 
if [[ $# -eq 0 ]] ; then
        echo '
 Usage:
  ./tree_view_google_groups.sh <group_name@cmlab.csie.ntu.edu.tw>
 
 Example:
  ./tree_view_google_groups.sh ggroup_m1@cmlab.csie.ntu.edu.tw
';
        exit 0;
fi
 
 
function indent {
        sed 's/^/  /';
}
 
function list_subgroup {
        ./gam/gam info group $1 | grep member: | grep \(group\) | awk '{print $2}';
}
 
function tree_view_groups {
        for subgroup in `list_subgroup $1`;
        do
                echo $subgroup | indent;
                tree_view_groups $subgroup | indent;
        done
}
 
echo $1;
tree_view_groups $1;
