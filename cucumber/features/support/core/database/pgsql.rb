require 'pg'
require_relative 'gateway'

module PostgreSQLModule
    include GatewayModule

    def self.conn
        port = Modules::Database.sshd === 'true' ? GatewayModule.tunnel : Modules::Database.port
        @@client = PG::Connection.new(
            host: Modules::Database.host,
            dbname: Modules::Database.name,
            user: Modules::Database.user,
            password: Modules::Database.pass,
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