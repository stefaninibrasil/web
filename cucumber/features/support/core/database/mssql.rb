require 'tiny_tds'
require_relative 'gateway'

module MSSQLModule
    include GatewayModule

    def self.conn
        port = Modules::Database.sshd === 'true' ? GatewayModule.tunnel : Modules::Database.port
        @@client = TinyTds::Client.new(
            host: Modules::Database.host,
            username: Modules::Database.user,
            password: Modules::Database.pass,
            database: Modules::Database.name,
            port: port
        )
    end
end

p MSSQLModule.conn