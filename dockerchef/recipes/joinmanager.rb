require 'json'

token = ""
mangerAddr = ""
managerKey =  node['swarm']['managerkey']
managerAddrKey =  node['swarm']['manageraddrkey']
  
managercommand = ""
managercommand << "aws dynamodb get-item --table-name MySwarmTable  --key '{\"TokenKey\": {\"S\": \"#{managerKey}\"}}'"

Chef::Log.info("Getting managerkey item for #{managerKey}")

shell = Mixlib::ShellOut.new("#{managercommand} 2>&1")
shell.run_command

if shell.error!
    Chef::Log.info("Got Error")
 else
    Chef::Log.debug("Parsing the json output")
    jsonDoc = JSON.parse(shell.stdout)
    Chef::Log.debug("Parsed the json")
    token = jsonDoc["Item"]["TokenCode"]["S"].strip
end

Chef::Log.info("Got manager token #{token} for item " + managerKey)

manageraddrcommand = ""
manageraddrcommand << "aws dynamodb get-item --table-name MySwarmTable  --key '{\"TokenKey\": {\"S\": \"#{managerAddrKey}\"}}'"

Chef::Log.info("Getting manager address for #{managerAddrKey}")

shell = Mixlib::ShellOut.new("#{manageraddrcommand} 2>&1")
shell.run_command

if shell.error!
    Chef::Log.info("Got Error")
else
    Chef::Log.debug("Parsing the json output")
    jsonDoc = JSON.parse(shell.stdout)
    Chef::Log.debug("Parsed the json")
    managerAddr = jsonDoc["Item"]["TokenCode"]["S"]
end

Chef::Log.info("Got manager address #{managerAddr} for item " + managerAddrKey)

swarmJoinCommand = ""
swarmJoinCommand << "docker swarm join --token #{token} #{managerAddr}"
Chef::Log.info("Manager Joining Swarm with command #{swarmJoinCommand}")
shell = Mixlib::ShellOut.new("#{swarmJoinCommand} 2>&1")
shell.run_command
Chef::Log.info("Manager Joined Swarm")
