require 'json'
@log.trace("Started execution'flint-o365:microsoft-cloud:user_account:reset_password.rb' flintbit...")

begin
    # Flintbit Input Parameters
    @connector_name = @input.get('connector-name')        # Name of the Connector
    @microsoft_id = @input.get('customer-id')             # id of the Microsoft Account
    @user_id = @input.get('user-id')                      # id of User Account
    @action = 'reset-user-account-password'               # @input.get("action")
    @user_password = @input.get('user-password')          # new password to reset
    @forceChangePassword = @input.get('force-change-password') # set it to 'true' to reset password
    @microsoftCloudActionUrl = '/MSCustomerSubscription/performOperations'

    @log.info("Flintbit input parameters are, connector name :: #{@connector_name} | MICROSOFT ID :: #{@microsoft_id} | User Id :: #{@user_id}")

    response = @call.connector(@connector_name)
                    .set('action', @action)
                    .set('microsoft-id', @microsoft_id)
                    .set('user-id', @user_id)
                    .set('user-password', @user_password)
                    .set('force-change-password', @forceChangePassword)
                    .sync

    response_exitcode = response.exitcode # Exit status code
    response_message =  response.message # Execution status message

    if response_exitcode == 0
        @log.info("Success in executing #{@connector_name} Connector, where exitcode :: #{response_exitcode} | message :: #{response_message}")

        response_body = JSON.parse(response.get('body'))
        response_body['action'] = @action
        response_body['customer-id'] = @microsoft_id
        @log.info("RESPONSE :: #{response_body}")
        @call.bit('flint-o365:http:http_request.rb').set('method', 'POST').set('url', @microsoftCloudActionUrl).timeout(120_000).set('body', response_body.to_json).sync
        @output.set('result', response_body)
    else
        @log.error("ERROR in executing #{@connector_name} where, exitcode :: #{response_exitcode} | message :: #{response_message}")
        @output.exit(1, response_message)
     end
rescue Exception => e
    @log.error(e.message)
    @output.set('exit-code', 1).set('message', e.message)
end

@log.trace("Finished execution 'flint-o365:microsoft-cloud:user_account:reset_password.rb' flintbit...")
