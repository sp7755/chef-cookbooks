####################################################	
# Variable declaration  for JDK  installation      #
####################################################

software_name 		= node['install_software']['java_software_name']
software_location 	= node['install_software']['artifactory'] + File::Separator + software_name
temp_location 		= "C:\\software"
loc_7z			= node['install_software']['7zip_home']


#############################################################
# Download  JDK software.                                   #
# Extract JDK software.                                     #
#############################################################

directory temp_location do
  action :create
  recursive true
end

remote_file "#{temp_location}\\#{software_name}" do
	source "#{software_location}"
	action :create
	show_progress true
	not_if { File.exists?("#{temp_location}\\#{software_name}") }
end


if File.extname("#{software_name}") == ".zip"
	executable = File.basename("#{software_name}",".zip") + ".exe"
	extraction 'software extraction' do
  		source_name software_name
  		sw_install_loc temp_location
  		loc_7z loc_7z
  		only_if { File.extname(software_name.to_s) == '.zip' }
	end
else
	executable = software_name
end

#############################################################
# Install JDK with pulic JRE option                         #
#############################################################

install_dir = "INSTALLDIR=\"C:\\Program Files\\Java\\jdk\""
jre_install_dir = "/INSTALLDIRPUBJRE=\"C:\\Program Files\\Java\\jre\""
execute 'Install JDK' do
	command "\"#{temp_location}\\#{executable}\" /s ADDLOCAL=\"ToolsFeature,PublicjreFeature\" #{install_dir} #{jre_install_dir}"
end

############################################################
#  Set JAVA Home and  PATH varibales                       #
############################################################

env 'Set JDK Home PATH' do
	key_name 'PATH'
	action :modify
	value "C:\\Program Files\\Java\\jdk\\bin"
end

env 'Set JAVA Home' do
	key_name 'JAVA_HOME'
	action :create
	value "C:\\Program Files\\Java\\jdk"
end

# End of Recipe
