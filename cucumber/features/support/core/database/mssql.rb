require 'tiny_tds'
require_relative 'gateway'

module MSSQLModule
    include GatewayModule

    @@driver = Modules::Database.connection[:driver]

    def self.conn
        if @@driver.eql?('sqlsrv')
            port = Modules::Database.sshd === 'true' ? GatewayModule.tunnel : Modules::Database.port
            @@client = TinyTds::Client.new(
                host: Modules::Database.host,
                username: Modules::Database.user,
                password: Modules::Database.pass,
                database: Modules::Database.name,
                port: port,
                login_timeout: 2
            )
        end
    end

    def self.exec(script)
        unless self.conn.nil?
            self.conn
            @@hash = @@client.execute(script.to_s).each
            self.close
            @@hash
        else
            'O driver de Banco de Dados informado não corresponde com os já suportados.'
        end
    end

    def self.close
        @@client.close
    end
end

p MSSQLModule.exec("select @@version")