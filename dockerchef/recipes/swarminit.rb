swarmInitCommand = ""
swarmInitCommand << "docker swarm init"
Chef::Log.info("Initializing Swarm")
shell = Mixlib::ShellOut.new("#{swarmInitCommand} 2>&1")
shell.run_command
Chef::Log.info("Swarm Initialized "+ shell.stdout)

swarmWorkerToken = ""
swarmWorkerToken << "docker swarm join-token -q worker"
Chef::Log.info("Obtaining Swarm Worker Token")
shell = Mixlib::ShellOut.new("#{swarmWorkerToken} 2>&1")
shell.run_command
token = shell.stdout
node.set['swarm']['workertoken'] = token
Chef::Log.info("Obtained Swarm Worker Token : #{token}")



swarmManagerToken = ""
swarmManagerToken << "docker swarm join-token -q manager"

Chef::Log.info("Obtaining Swarm Manager Token")
shell = Mixlib::ShellOut.new("#{swarmManagerToken} 2>&1")
shell.run_command
token = shell.stdout
node.set['swarm']['managertoken'] = token
Chef::Log.info("Obtained Swarm Manager Token : #{token}")
  
  
node.set['swarm']['manageraddr'] = "tcp://#{node['ipaddress']}:2377"