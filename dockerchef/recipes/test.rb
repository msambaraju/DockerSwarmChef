require 'json'
command = ""
   command << "aws dynamodb describe-table --table-name MySwarmTable --output json"
   Chef::Log.info("Waiting for table MySwarmTable  to be available")
   done = false
   count = 0
   until done
     state=""
     begin
         shell = Mixlib::ShellOut.new("#{command} 2>&1")
         shell.run_command
         Chef::Log.info(shell.stdout)
         Chef::Log.info(shell.stderr)
         if shell.error!
            Chef::Log.info("Got Error")
            break
        #raise "#{command} failed:" + shell.stdout
         else
            Chef::Log.info("Parsing the json output")
            jdoc = JSON.parse(shell.stdout)
            Chef::Log.info("Parsed the json")
            table = jdoc["Table"]
            print table
            tableStatus = table["TableStatus"]
            print tableStatus
            Chef::Log.debug("MySwarmTable is #{tableStatus}")
            if tableStatus == "ACTIVE"
               break
            else
               Chef::Log.debug("Waiting 5 more seconds for MySwarmTable to be ready...")
               sleep 5
               count += 1
               if count == 5
                  done = true
               end
            end
         end
      rescue Mixlib::ShellOut::ShellCommandFailed, SystemCallError
         break
    end
end