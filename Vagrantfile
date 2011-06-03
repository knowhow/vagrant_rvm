Vagrant::Config.run do |config|
  config.vm.box = "base"

  #config.vm.boot_mode = :gui

  config.vm.network "33.33.33.21"

  config.vm.provision :chef_solo do |chef|
     chef.cookbooks_path = "cookbooks"
     
     chef.add_recipe "java"
     chef.add_recipe "rvm"
     chef.add_recipe "rvm::install"
     #   chef.add_role "web"
     
 
	 #chef.json.merge! ( { :rvm => { :ruby => {:implementation => "ruby", :version => "1.8.7" } } })
     chef.json.merge! ( { :rvm => { :ruby => {:implementation => "ruby", :version => "1.9.2" } } })
 
     #chef.json.merge! ( { :java => { :flavour => "openjdk" } } ) 
     #chef.json.merge! ( { :java => { :flavour => "sun" } } ) 

  end

end
