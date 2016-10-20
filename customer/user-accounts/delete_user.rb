require 'json'
@log.trace("Started execution'flint-o365:microsoft-cloud:user_account:delete_user.rb' flintbit...") 
begin
     # Flintbit Input Parameters
     @connector_name = @input.get('connector_name')        # Name of the Connector
     @action = @input.get("action")                        #delete-user                             
     @microsoft_id = @input.get("customer-id")             # id of the Microsoft Account
     @user_id = @input.get("user-id")

     @microsoftCloudActionUrl = '/MSCustomerSubscription/performOperations'    

     @log.info("Flintbit input parameters are, connector name :: #{@connector_name} | MICROSOFT ID :: #{@microsoft_id} | User ID :: #{@user_id}")

     response = @call.connector(@connector_name)
                     .set('action', @action)
                     .set('microsoft-id', @microsoft_id)
                     .set('user-id', @user_id)      
                     .sync

     response_exitcode = response.exitcode # Exit status code
     response_message =  response.message # Execution status message
     response_body = response.get("body")
     @log.info("#{response_body}")
     
     if response_exitcode==0
        response = true
        @log.info("Success in executing #{@connector_name} Connector, where exitcode :: #{response_exitcode} | message :: #{response_message}")
        @output.set("result::", true)

       # @call.bit('flint-o365:http:http_request.rb').set('method', 'POST').set('url', @microsoftCloudActionUrl).timeout(120000).set('body', response).sync   
     else
         @log.error("ERROR in executing #{@connector_name} where, exitcode :: #{response_exitcode} | message :: #{response_message}")
         @output.exit(1, response_message)
      end
rescue Exception => e
    @log.error(e.message)
    @output.set('exit-code', 1).set('message', e.message)
end

@log.trace("Finished execution 'flint-o365:microsoft-cloud:user_account:delete_user.rb' flintbit...") 
