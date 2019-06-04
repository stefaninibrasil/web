require 'net/ssh/gateway'

require_relative '../../config/modules'

module GatewayModule
    include Modules

    def self.tunnel
        gateway = Net::SSH::Gateway.new(
            Modules::SSH.host,
            Modules::SSH.user,
            password: Modules::SSH.pass
        )
        port = gateway.open(Modules::Database.host, Modules::Database.port, Modules::Database.localPort)
    end
end