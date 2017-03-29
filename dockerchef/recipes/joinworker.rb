require 'json'

token = ""
mangerAddr = ""
workerKey =  node['swarm']['workerkey']
managerAddrKey =  node['swarm']['manageraddrkey']
  
workercommand = ""
workercommand << "aws dynamodb get-item --table-name MySwarmTable  --key '{\"TokenKey\": {\"S\": \"#{workerKey}\"}}'"

Chef::Log.info("Getting worker token item " + workerKey)

shell = Mixlib::ShellOut.new("#{workercommand} 2>&1")
shell.run_command

if shell.error!
    Chef::Log.info("Got Error")
 else
    Chef::Log.debug("Parsing the json output")
    jsonDoc = JSON.parse(shell.stdout)
    Chef::Log.debug("Parsed the json")
    token = jsonDoc["Item"]["TokenCode"]["S"].strip
end

Chef::Log.info("Got worker token #{token} for item " + workerKey)

manageraddrcommand = ""
manageraddrcommand << "aws dynamodb get-item --table-name MySwarmTable  --key '{\"TokenKey\": {\"S\": \"#{managerAddrKey}\"}}'"

Chef::Log.info("Getting manger address item")

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

Chef::Log.info("Got manger address #{managerAddr} item for #{managerAddrKey}")

swarmJoinCommand = ""
swarmJoinCommand << "docker swarm join --token #{token} \ #{managerAddr}"
Chef::Log.info("Worker Joining Swarm with command #{swarmJoinCommand}")
shell = Mixlib::ShellOut.new("#{swarmJoinCommand} 2>&1")
shell.run_command
Chef::Log.info("Worker Joined Swarm "+ shell.stdout)
