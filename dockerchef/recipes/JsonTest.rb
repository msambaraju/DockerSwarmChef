require 'json'
file = File.read('/Users/malliksambaraju/workspaces/gitprojects/DockerChef/dockerchef/recipes/item.json')
data_hash = JSON.parse(file)
table = data_hash['Item']
val = data_hash['Item']['TokenCode']['S']
#print val
table['TokenCode']['S'] = '1234566666666'
tokenCode = table['TokenCode']
#print tokenCode["S"]
  
#print table['TokenCode']['S']

#print data_hash
  

item = "{\"TokenKey\": {\"S\": \"MyKey\"},\"TokenCode\":{\"S\": \"MyToken\"}}"
item_hash = JSON.parse(item)
print item_hash
print "\n"
item_hash['TokenKey']['S'] = 'MynewKey'
item_hash['TokenCode']['S'] = 'MynewTokenCode'
print item_hash
print "\n"
print item_hash.to_json
 

