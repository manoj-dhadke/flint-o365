=begin
##########################################################################
#
#  INFIVERVE TECHNOLOGIES PTE LIMITED CONFIDENTIAL
#  __________________
# 
#  (C) INFIVERVE TECHNOLOGIES PTE LIMITED, SINGAPORE
#  All Rights Reserved.
#  Product / Project: Flint IT Automation Platform
#  NOTICE:  All information contained herein is, and remains
#  the property of INFIVERVE TECHNOLOGIES PTE LIMITED.
#  The intellectual and technical concepts contained
#  herein are proprietary to INFIVERVE TECHNOLOGIES PTE LIMITED.
#  Dissemination of this information or any form of reproduction of this material
#  is strictly forbidden unless prior written permission is obtained
#  from INFIVERVE TECHNOLOGIES PTE LIMITED, SINGAPORE.
=end

require 'json'

@log.trace("Started execution'flint-o365:customer:coustomer:user-accounts:sync.rb' flintbit...") 
begin
     # Mandatory
     @connector_name = @input.get("connector-name") # Name of the office365 Connector
     @action = 'get-all-customer-user-accounts'
     @id = @input.get('customer-id') # id of the Microsoft Account
     @microsoftCloudActionUrl = '/MSCustomerSubscription/performOperations' #microsoft Action URl
     @log.info("Flintbit input parameters are, connector name :: #{@connector_name} | Customer ID::#{@id}")

     response = @call.connector(@connector_name)
                     .set('action', @action)
                     .set('microsoft-id', @id)
                     .sync

     response_exitcode = response.exitcode # Exit status code
     response_message =  response.message # Execution status message

     if response_exitcode.zero?

       # if exitcode is Zero then do following operations
       response_body_string = JSON.parse(response.get('body')) # parsing json string to JSON Object
       @output.set("result::","#{response_body_string}")
       all_subscription = response_body_string['items'] # fetching item array from body

       # iterating  item array and inserting customer id in each json object of item array
       all_subscription.each do |items|
           request_body = {}

           # request_body['customerId'] = @id # inserting customerId in the item array
           request_body['action'] = 'sync-users' # inserting action in the array
           request_body['customer-id'] = @id
           items["userAccountId"] = items["id"]
           request_body["user-account-details"] = items
     
           @call.bit('flint-o365:http:http_request.rb').set('method', 'POST').set('url', @microsoftCloudActionUrl).timeout(120000).set('body', request_body.to_json).sync
      end
     else
         @log.error("ERROR in executing #{@connector_name} where, exitcode :: #{response_exitcode} | message :: #{response_message}")
         @output.exit(1, response_message)
end
 rescue Exception => e
     @log.error(e.message)
     @output.set('exit-code', 1).set('message', e.message)
 end
@log.trace("Finished execution 'flint-o365:customer:coustomer:user-accounts:sync.rb' flintbit...") 
