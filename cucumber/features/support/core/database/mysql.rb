require 'mysql2'
require_relative 'gateway'

module MySQLModule
    include GatewayModule

    def self.conn
        port = Modules::Database.sshd === 'true' ? GatewayModule.tunnel : Modules::Database.port
        @@client = Mysql2::Client.new(
            host: Modules::Database.host,
            username: Modules::Database.user,
            password: Modules::Database.pass,
            database: Modules::Database.name,
            port: port
        )
    end

    def self.exec(script)
        self.conn
        @@hash = @@client.query(script.to_s)
        self.close
        @@hash
    end

    def self.close
        @@client.close
    end
end