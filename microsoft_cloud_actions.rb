@log.trace("Started execution of 'flint-o365:microsoft-cloud:microsoft_cloud_actions.rb' flintbit..") # starting execution

@log.trace('Reading office365 connector name from Global Config')
@ofiice365_connector_name = @input.get('connector-name')

if @ofiice365_connector_name.nil? # checking connector name is null or not
    # if user inputed connector name is null then assign connector name by fetching it from global configuration
    @ofiice365_connector_name = @config.global('flintserve-integrations.microsoft-cloud.connector-name')
end

action = @input.get('action')

@log.info("ConnectorName:#{@ofiice365_connector_name}")

# Case for different operation
case action

when 'sync-subscriptions' # case of action sync-subscriptions

    @log.info("Calling 'flint-o365:customer:subscription:sync.rb' flintbit to get subscriptions list")

    # calling sync.rb flintbit
    @call.bit('flint-o365:customer:subscriptions:sync.rb').set('connector_name', @ofiice365_connector_name).setraw(@input.raw.to_s).timeout(120000)
         .sync

when 'sync-users' # case of action get-all-customer of user

    @log.info("Calling 'flint-o365:customer:user-accounts:sync.rb' flintbit to start assets")

    # calling ---.rb flintbit
    @call.bit('flint-o365:customer:user-accounts:sync.rb').setraw(@input.raw.to_s).set('connector_name', @ofiice365_connector_name).timeout(120000).sync

when 'get-user-licenses' # case of action for getting user licenses
    @log.info("Calling 'flintcloud-integrations:virtual_machine:stop_virtual_machine_router.rb' flintbit to stop assets")\

    # calling get-user-licenses flintbit
    @call.bit('ofc365:get_user_licenses.rb').set('connector_name', @ofiice365_connector_name).set('action', @action)
         .set('microsoft-id', @id).set('user-id', @uid).timeout(120000).sync
else
    # this case will executes when the user input wrong case
    @log.error('Invalid action provided, Please provide valid action')
    @output.exit(4, 'Invalid action provided, Please provide valid action')
        end

@log.trace("Finished execution of 'flint-o365:microsoft-cloud:microsoft_cloud_actions.rb' flintbit..") # Execution Finished
