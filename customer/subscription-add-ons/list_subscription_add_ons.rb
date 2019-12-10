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
@log.trace("Started execution'flint-o365:customer:list_subscription_add_ons.rb' flintbit...")
begin
    # Flintbit Input Parameters
    @connector_name = @input.get('connector-name')        # Name of the Connector
    @microsoft_id = @input.get('customer-id')             # id of the Microsoft Account
    @action = 'list-subscription-add-ons' # @input.get("action")
    @id_for_subscription = @input.get('id-for-subscription')

    @microsoftCloudActionUrl = '/MSCustomerSubscription/performOperations'

    @log.info("Flintbit input parameters are, connector name :: #{@connector_name} | MICROSOFT ID :: #{@microsoft_id} |
                                    ID FOR SUBSCRIPTION :: #{@id_for_subscription}")

    response = @call.connector(@connector_name)
                    .set('action', @action)
                    .set('microsoft-id', @microsoft_id)
                    .set('id-for-subscription', @id_for_subscription)
                    .sync

    response_exitcode = response.exitcode # Exit status code
    response_message =  response.message # Execution status message

    if response_exitcode == 0
        @log.info("Success in executing #{@connector_name} Connector, where exitcode :: #{response_exitcode} | message :: #{response_message}")

        response_body = JSON.parse(response.get('body'))
        itemsArray= response_body["items"]
        itemsArray.each do |jsonObject|    #Iterating Array of Items get in response
        jsonObject['action'] = @action
        jsonObject['customer-id'] = @microsoft_id
        @log.info("RESPONSE :: #{jsonObject}")
        @call.bit('flint-o365:http:http_request.rb').set('method', 'POST').set('url', @microsoftCloudActionUrl).timeout(120_000).set('body', jsonObject.to_json).sync
        end
        @output.set('result::', response_body)
    else
        @log.error("ERROR in executing #{@connector_name} where, exitcode :: #{response_exitcode} | message :: #{response_message}")
        @output.exit(1, response_message)
     end
rescue Exception => e
    @log.error(e.message)
    @output.set('exit-code', 1).set('message', e.message)
end

@log.trace("Finished execution 'flint-o365:microsoft-cloud:customer:list_subscription_add_ons.rb' flintbit...")
