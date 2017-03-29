require 'json'
   
workerKey =  node['swarm']['workerkey']
managerKey =  node['swarm']['managerkey']
managerAddrKey =  node['swarm']['manageraddrkey']
workerToken = node['swarm']['workertoken']
managerToken = node['swarm']['managertoken']
managerAddr = node['swarm']['manageraddr']

Chef::Log.info("Done setting  dummy data")

putItemTemplate =   "{\"TokenKey\": {\"S\": \"dummykey\"},\"TokenCode\":{\"S\": \"dummytoken\"}}"
item_hash = JSON.parse(putItemTemplate)
item_hash['TokenKey']['S'] = workerKey
item_hash['TokenCode']['S'] = workerToken
item = item_hash.to_json

item_hash['TokenKey']['S'] = managerKey
item_hash['TokenCode']['S'] = managerToken
manageritem = item_hash.to_json

item_hash['TokenKey']['S'] = managerAddrKey
item_hash['TokenCode']['S'] = managerAddr
manageraddritem = item_hash.to_json


workercommand = ""
workercommand << "aws dynamodb put-item --table-name MySwarmTable  --item '#{item}'"
Chef::Log.info("Putting item")

shell = Mixlib::ShellOut.new("#{workercommand}")
shell.run_command

if shell.error!
   Chef::Log.info("Unable to put the worker key")
else
   Chef::Log.info("SuccessFully added the worker key")
end


managercommand = ""
managercommand << "aws dynamodb put-item --table-name MySwarmTable  --item '#{manageritem}'"
Chef::Log.info("Putting item")

shell = Mixlib::ShellOut.new("#{managercommand}")
shell.run_command

if shell.error!
   Chef::Log.info("Unable to put the manager key")
else
   Chef::Log.info("SuccessFully added the manger key")
end

managerAddrcommand = ""
managerAddrcommand << "aws dynamodb put-item --table-name MySwarmTable  --item '#{manageraddritem}'"
Chef::Log.info("Putting item")

shell = Mixlib::ShellOut.new("#{managerAddrcommand}")
shell.run_command

if shell.error!
   Chef::Log.info("Unable to put the manager addr key")
else
   Chef::Log.info("SuccessFully added the manager addr key")
end