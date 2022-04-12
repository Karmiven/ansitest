#!/bin/bash

# Display groups from id
if [ "$2" = "1" ]; then
  id $1 |tr ',' '\n' |sort -t\( -k 2 |paste - - |column -t
elif [ "$2" = "2" ]; then
# nice print user’s allowed login groups without numbers or parens
# translate comma to newline, sort on field after paren, print without paren and strip trailing paren
 id $1 |tr ',' '\n' |sort -t\( -k 2 |awk -F\( '{print $2}' |tr -d ')'
else
# Default
  id $1 |tr ',' '\n' |tr '(' ' ' |tr ')' ' '|sort -t\( -n -k 2  |column -t
fi

exit;


Example default output:

103       netdev                                  
108       bluetooth                               
109       lpadmin                                 
114       scanner                                 
24        cdrom                                   
25        floppy                                  
29        audio                                   
30        dip                                     
44        video                                   
46        plugdev                                 
uid=1000  user       gid=1000  user  groups=1000  user


Arg $2 = 1 output == compact and fairly easy to read, useful if a lot of groups are attached:

100(_lpoperator)                     12(everyone)                                      
204(_developer)                      250(_analyticsusers)                              
33(_appstore)                        395(com.apple.access_ftp)                         
398(com.apple.access_screensharing)  399(com.apple.access_ssh)                         
504(boinc_master)                    505(boinc_project)                                
61(localaccounts)                    701(com.apple.sharepoint.group.1)                 
702(com.apple.sharepoint.group.2)    704(com.apple.sharepoint.group.3)                 
705(com.apple.sharepoint.group.4)    79(_appserverusr)                                 
80(admin)                            81(_appserveradm)                                 
98(_lpadmin)                         uid=501(user)                      gid=20(staff)  groups=20(staff)


Arg $2 = 2 output == groups-only:

all_admins_grp
apache_admin_dev_grp
apache_admin_eite_grp
apache_admin_pete_grp

audio
bluetooth
cdrom
user gid=1000 # NOTE it's not perfect, but useful for grepping
dip
floppy
lpadmin
netdev
plugdev
scanner
video

