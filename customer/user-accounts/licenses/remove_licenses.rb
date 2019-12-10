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
@log.trace("Started execution'flint-o365:microsoft-cloud:user-accounts:license:remove_licenses.rb' flintbit...") 
begin
     @connector_name = @input.get('connector-name')        # Name of the Connector
     @action = 'remove-liciense'						   #@input.get("action")                        
     @microsoft_id = @input.get("customer-id")             # id of the Microsoft Account
     @user_id = @input.get('user-id')                      #id of the user Account
     @license_id = @input.get('license-id')              
     
     @microsoftCloudActionUrl = '/MSCustomerSubscription/performOperations'    

     @log.info("Flintbit input parameters are, Connector Name:#{@connector_name} | USER ID:#{@user_id} | MICROSOFT ID:#{@microsoft_id} | License Id :#{@license_id}")

     response = @call.connector(@connector_name)
                     .set('action', @action)
                     .set('microsoft-id', @microsoft_id)
                     .set('user-id', @user_id)
                     .set('license-id', @license_id)
                     .sync

     response_exitcode = response.exitcode 	# Exit status code
     response_message =  response.message 	# Execution status message
     response_body = JSON.parse(response.get('body')) 
     response_body['action'] = @action
     response_body['customer-id'] = @microsoft_id
     response_body['user-id'] = @user_id
     response_body['license-id'] = @license_id 
     
     @log.info("RESPONSE :: #{response_body}")
     
      if response_exitcode==0

         @log.info("Success in executing #{@connector_name} Connector, where exitcode :: #{response_exitcode} | message :: #{response_message}")
         @output.set("result::",response_body)
         @call.bit('flint-o365:http:http_request.rb').set('method', 'POST').set('url', @microsoftCloudActionUrl).timeout(120000).set('body', response_body.to_json).sync
      else
         @log.error("ERROR in executing #{@connector_name} where, exitcode :: #{response_exitcode} | message :: #{response_message}")
         @output.exit(1, response_message)
      end
rescue Exception => e
    @log.error(e.message)
    @output.set('exit-code', 1).set('message', e.message)
end
@log.trace("Finished execution 'flint-o365:microsoft-cloud:user-accounts:license:remove_licenses.rb' flintbit...") 
