def api_from_settings
  begin
    settings = YAML::load_file(File.join(File.dirname(__FILE__), "settings.yml"))
    api = RememberTheRuby::API.new(settings)
  rescue Errno::ENOENT
    unless $errored_about_api_settings
      puts "################################################################################"
      puts "# NOTICE: spec/settings.yml.dist to spec/settings.yml and set up appropriately #"
      puts "################################################################################"
      api = nil
    end
    $errored_about_api_settings = true
  end
  api
end  