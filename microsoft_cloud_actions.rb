@log.trace("Started execution of 'flint-o365:microsoft_cloud_actions.rb' flintbit..") 
@log.trace('Reading office365 connector name from Global Config')

@ofiice365_connector_name = @input.get('connector-name')
if @ofiice365_connector_name.nil? 
    @ofiice365_connector_name = @config.global('flintserve-integrations.microsoft-cloud.connector-name')
end
action = @input.get('action')
@log.info("ConnectorName:: #{@ofiice365_connector_name} | action :: #{action}")

case action

when 'sync-subscriptions' # case of action sync-subscriptions

    @log.info("Calling 'flint-o365:customer:subscription:sync.rb' flintbit to get subscriptions list")
    @call.bit('flint-o365:customer:subscriptions:sync.rb').set('connector-name', @ofiice365_connector_name).set('action',action).setraw(@input.raw.to_s).timeout(120000)
         .sync

when 'sync-users' # case of action get-all-customer of user

    @log.info("Calling 'flint-o365:customer:user-accounts:sync.rb' flintbit to start assets")
    @call.bit('flint-o365:customer:user-accounts:sync.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'sync-licenses' # case of action for getting user licenses
    @log.info("flint-o365:customer:user-accounts:licences:sync.rb")
    @call.bit('flint-o365:customer:user-accounts:licences:sync.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'add-user' # case of action for getting user licenses
    @log.info("flint-o365:customer:user-accounts:add_user.rb")
    @call.bit('flint-o365:customer:user-accounts:add_user.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'change-subscription-quantity' # case of action for getting user licenses
    @log.info("flint-o365:customer:subscriptions:change_subscription_quantity.rb")
    @call.bit('flint-o365:customer:subscriptions:change_subscription_quantity.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'activate-subscription' # case of action for getting user licenses
    @log.info("flint-o365:customer:subscriptions:activate_subscription.rb")
    @call.bit('flint-o365:customer:subscriptions:activate_subscription.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'suspend-subscription' # case of action for getting user licenses
    @log.info("flint-o365:customer:subscriptions:suspend_subscription.rb")
    @call.bit('flint-o365:customer:subscriptions:suspend_subscription.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'add-licenses' # case of action for getting add licenses
    @log.info("flint-o365:customer:subscriptions:add_licenses.rb")
    @call.bit('flint-o365:customer:subscriptions:add_licenses.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'remove-licenses' # case of action for getting remove licenses
    @log.info("flint-o365:customer:subscriptions:remove_licenses.rb")
    @call.bit('flint-o365:customer:subscriptions:remove_licenses.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync


else
  @log.error('Invalid action provided, Please provide valid action')
  @output.exit(4, 'Invalid action provided, Please provide valid action')
end

@log.trace("Finished execution of 'flint-o365:microsoft_cloud_actions.rb' flintbit..") 
