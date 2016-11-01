require 'json'
@log.trace("Started execution 'flint-o365:customer:subscription:change_subscription_quantity.rb' flintbit...") 
begin

     # Mandatory
     @connector_name = @input.get('connector-name') 			# Name of the office365 Connector
     @action = 'change-subscription-add-on-quantity'				#@input.get('action')			                
     @microsoft_id = @input.get('customer-id') 			        # id of the Microsoft Account
     @subscriptionId=@input.get('subscription-add-on-id')
     @quantity=@input.get('quantity')
     @microsoftCloudActionUrl = '/MSCustomerSubscriptionAddOn/performOperations'  

     @log.info("Flintbit input parameters are, connector name :: #{@connector_name} | Customer ID::#{@microsoft_id} | Subscription-add-on Id :: #{@subscriptionId} | Quantity :: #{@quantity}")

     response = @call.connector(@connector_name)
                     .set('action', 'change-subscription-quantity')
                     .set('microsoft-id', @microsoft_id)
                     .set('subscription-id',@subscriptionId)
                     .set('quantity',@quantity.to_i)
                     .sync

     response_exitcode = response.exitcode # Exit status code
     response_message =  response.message # Execution status message

     response_body = JSON.parse(response.get('body')) # parsing json string to JSON Object
     response_body['action'] = @action 
     response_body['customer-id'] = @microsoft_id
     response_body['subscription-add-on-id'] = response_body['id']   

     @log.info("#{response_body}")

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
@log.trace("Finished execution 'flint-o365:customer:subscription:change_subscription_quantity.rb' flintbit...") 
