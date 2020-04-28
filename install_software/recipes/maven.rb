####################################################
# Variable declaration  for Maven  installation    #
####################################################

software_name           = node['install_software']['maven_zip']
software_location       = node['install_software']['artifactory'] + File::Separator + software_name
loc_7z                  = node['install_software']['7zip_home']
maven_extract_loc	= "C:\\Program Files"


#############################################################
# Download  Maven software.                                  #
# Extract Maven software.                                    #
#############################################################

remote_file "#{maven_extract_loc}\\#{software_name}" do
        source "#{software_location}"
        action :create
        show_progress true
        not_if { File.exists?("#{maven_extract_loc}\\#{software_name}") }
end


extraction 'software extraction' do
                source_name software_name
                sw_install_loc maven_extract_loc
                loc_7z loc_7z
                only_if { File.extname(software_name.to_s) == '.zip' }
end


############################################################
#  Set Maven Home and  PATH varibales                      #
############################################################

env 'Set Maven Home PATH' do
        key_name 'PATH'
        action :modify
        value "C:\\Program Files\\apache-maven-3.6.3\\bin"
end

env 'Set Maven Home' do
        key_name 'MAVEN_HOME'
        action :create
        value "C:\\Program Files\\apache-maven-3.6.3"
end

env 'Set Maven Home' do
        key_name 'M2_HOME'
        action :create
        value "C:\\Program Files\\apache-maven-3.6.3\\bin"
end

# End of Recipe

