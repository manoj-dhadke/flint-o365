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

@log.trace("Started execution of 'flint-snow:microsoft-cloud:microsoft_cloud_actions.rb' flintbit..") 
@log.trace('Reading office365 connector name from Global Config')

@ofiice365_connector_name = @input.get('connector-name')
if @ofiice365_connector_name.nil? 
    @ofiice365_connector_name = @config.global('flintserve-integrations.microsoft-cloud.connector-name')
end
action = @input.get('action')
@log.info("ConnectorName:: #{@ofiice365_connector_name} | action :: #{action}")

case action

when 'sync-subscriptions' # case of action sync-subscriptions

    @log.info("Calling 'flint-o365:microsoft-cloud:customer:subscription:sync.rb' flintbit to get subscriptions list")
    @call.bit('flint-o365:microsoft-cloud:customer:subscriptions:sync.rb').set('connector_name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000)
         .sync

when 'sync-users' # case of action get-all-customer of user

    @log.info("Calling 'flint-ofc365:microsoft-cloud:customer:subscription:sync_users.rb' flintbit to start assets")
    @call.bit('flint-o365:microsoft-cloud:customer:subscriptions:get_all_customer_user_accounts.rb').set('connector_name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'get-user-licenses' # case of action for getting user licenses
    @log.info("flint-o365:customer:user_account:licences:sync.rb")
    @call.bit('flint-o365:customer:user_account:licences:sync.rb').set('connector_name', @connector_name).setraw(@input.raw.to_s).timeout(120000).sync


else
  @log.error('Invalid action provided, Please provide valid action')
  @output.exit(4, 'Invalid action provided, Please provide valid action')
end

@log.trace("Finished execution of 'flint-snow:microsoft-cloud:microsoft_cloud_actions.rb' flintbit..") 
