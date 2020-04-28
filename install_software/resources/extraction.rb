#######################################################################################################
# Extraction of tar/zip file to the specified directory
#######################################################################################################

resource_name :extraction

property :user, String, default: ''
property :group, String, default: ''
property :source_name, String, default: ''
property :sw_install_loc, String, default: ''
property :loc_7z, String, default: ''

action :extract do

  extension = ::File.extname(new_resource.source_name)
  sw_install_loc = new_resource.sw_install_loc

  case node['platform_family']
  when 'windows'
    extraction_command = "\"#{new_resource.loc_7z}\\\"7z.exe x #{new_resource.source_name} -y"
    execute 'extract software' do
      cwd new_resource.sw_install_loc
      command <<-EOC
              #{extraction_command}
            EOC
      action :run
    end
  when 'rhel'
    if (extension == '.tar') || (extension == '.gz')
      extraction_command = 'tar -xvf ' + new_resource.source_name
    else
      if extension == '.zip'
        extraction_command = 'unzip -o ' + new_resource.source_name
      end
    end
    
    execute 'extract software' do
      user new_resource.user
      group new_resource.group
      cwd new_resource.sw_install_loc
      command <<-EOC
              #{extraction_command}
            EOC
      action :run
    end

    execute 'change permission' do
      user new_resource.user
      group new_resource.group
      cwd new_resource.sw_install_loc
      command <<-EOC
              chmod -R 755 #{new_resource.sw_install_loc}
            EOC
      action :run
    end

  end

end

