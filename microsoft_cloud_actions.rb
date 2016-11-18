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

when 'delete-user' # case of action for getting user licenses
    @log.info("flint-o365:customer:user-accounts:delete_user.rb")
    @call.bit('flint-o365:customer:user-accounts:delete_user.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync


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
    @log.info("flint-o365:customer:user-accounts:licenses:add_licenses.rb")
    @call.bit('flint-o365:customer:user-accounts:licenses:add_licenses.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'remove-licenses' # case of action for getting remove licenses
    @log.info("flint-o365:customer:user-accounts:licenses:remove_licenses.rb")
    @call.bit('flint-o365:customer:user-accounts:licenses:remove_licenses.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'activate-subscription-add-on' # case of action for getting activate
    @log.info("flint-o365:customer:subscription-add-ons:activate.rb")
    @call.bit('flint-o365:customer:subscription-add-ons:activate.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'change-subscription-add-on-quantity' # case of action for getting change_quantity
    @log.info("flint-o365:customer:subscription-add-ons:change_quantity.rb")
    @call.bit('flint-o365:customer:subscription-add-ons:change_quantity.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'suspend-subscription-add-on' # case of action for getting 
    @log.info("flint-o365:customer:subscription-add-ons:suspend.rb")
    @call.bit('flint-o365:customer:subscription-add-ons:suspend.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'update-user' # case of action for getting 
    @log.info("flint-o365:customer:user-accounts:update_user.rb")
    @call.bit('flint-o365:customer:user-accounts:update_user.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'reset-user-account-password' # case of action for getting 
    @log.info("flint-o365:customer:user-accounts:reset_password.rb")
    @call.bit('flint-o365:customer:user-accounts:reset_password.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'get-customer-roles' # case of action for getting 
    @log.info("flint-o365:customer:user-accounts:get_customer_roles.rb")
    @call.bit('flint-o365:customer:user-accounts:get_customer_roles.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'get-all-user-roles' # case of action for getting 
    @log.info("flint-o365:customer:user-accounts:get_all_user_roles.rb")
    @call.bit('flint-o365:customer:user-accounts:get_all_user_roles.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'get-available-licenses' # case of action for getting 
    @log.info("flint-o365:customer:user-accounts:get_available_licenses.rb")
    @call.bit('flint-o365:customer:user-accounts:get_available_licenses.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'create-customer' # case of action to create customer 
    @log.info("flint-o365:customer:create_customer.rb")
    @call.bit('flint-o365:customer:create_customer.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'create-order' # case of action to create order 
    @log.info("flint-o365:customer:create_order.rb")
    @call.bit('flint-o365:customer:create_order.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'list-subscription-add-ons' # case of action to list subscription add-ons  
    @log.info("flint-o365:customer:subscription-add-ons:list_subscription_add_ons.rb")
    @call.bit('flint-o365:customer:subscription-add-ons:list_subscription_add_ons.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync

when 'list-offer-id-add-ons' # case of action to list offer-id add-ons 
    @log.info("flint-o365:customer:list_offer_id_add_ons.rb")
    @call.bit('flint-o365:customer:list_offer_id_add_ons.rb').set('connector-name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000).sync


else
  @log.error('Invalid action provided, Please provide valid action')
  @output.exit(4, 'Invalid action provided, Please provide valid action')
end

@log.trace("Finished execution of 'flint-o365:microsoft_cloud_actions.rb' flintbit..") 
