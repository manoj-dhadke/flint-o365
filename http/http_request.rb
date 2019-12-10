=begin
#
#  INFIVERVE TECHNOLOGIES PTE LIMITED CONFIDENTIAL
#  _______________________________________________
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

@log.trace("Started execution 'flint-o365:http:http_reqeust.rb' flintbit...") # execution Started
begin

    # getting input information from sync.rb
    @body = @input.get('body')
    @microsoftCloudActionUrl = @input.get('url')
    @method = @input.get('method')

    # fetching flintserve global configuration information for url creation
    @hostName = @config.global('flintserve.hostname') # fetching hostname from flintserve global configuration
    @connectorName = @config.global('flintserve-integrations.http.connector-name') # fetching the connector name from  flintserve global configuration
    @log.info(@connectorName.to_s)
    @port = @config.global('flintserve.port').to_s # fetching the communication port from  flintserve global configuration
    @protocol = @config.global('flintserve.protocol') # fetching the communication protocol from  flintserve global configuration
    flint_key = @config.global('flintserve.key') # fetching the flint key from  flintserve global configuration

    @log.info("body:#{@body}| url:#{@urlPart}|method:#{@method}") # printing all input parameters on flint logs

    # destination URL creation
    @url = @protocol + '://' + @hostName + ':' + @port + @microsoftCloudActionUrl # Url to post data on destination using Protocol ,Port and  Hostname

    # calling HTTP connector
    response = @call.connector(@connectorName)
                    .set('method', 'POST')
                    .set('url', @url)
                    .set('body', @body.to_s)
                    .set('headers', ['content-type:application/json', 'flint-key:' + flint_key])
                    .set('is-proxy', false)
                    .set('timeout', 10000)
                    .sync

    @log.info("response:#{response}") # printing full response

    response_body = response.get('body')           # Response Body
    response_headers = response.get('headers')     # Response Headers

    @log.info("response:#{response.message}") # printing response message
    @log.info("response:#{response.exitcode}") # printing response exit code
    @log.info("response:#{response_body}") # printing response Body
end

@log.trace("Finished execution 'flint-o365:http:http_reqeust.rb' flintbit...") # Execution Finished
