Chef::Log.info("Setting the Environment Keys")
  
node.set['swarm']['workerkey'] = node['swarmname'] +"_Worker"
node.set['swarm']['managerkey'] = node['swarmname'] + "_Manager"
node.set['swarm']['manageraddrkey'] = node['swarmname'] + "_ManagerAddr"

Chef::Log.info("Done Setting the Environment Keys")
