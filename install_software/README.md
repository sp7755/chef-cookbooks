# install_software

TODO: Enter the cookbook description here.

#To Install 7-Zip 

knife node run_list set windows-servername recipe[install_software::7zip]

#To Install jdk

knife node run_list set windows-servername recipe[install_software::java]


#To Install Maven

knife node run_list set windows-servername recipe[install_software::maven]
