# install_software

# This recipe is can be used to install 7-zip, JDK & Maven on windows servers.

#To Install 7-Zip 

knife node run_list set windows-servername recipe[install_software::7zip]

#To Install jdk

knife node run_list set windows-servername recipe[install_software::java]


#To Install Maven

knife node run_list set windows-servername recipe[install_software::maven]
