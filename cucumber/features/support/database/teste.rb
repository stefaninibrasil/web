require 'mysql2'

require_relative '../core/ssh/gateway'

module MysqlConnection
    include Gateway

    def self.conn
        port = Modules::Database.sshd === 'true' ? Gateway.tunnel : Modules::Database.port

        client = Mysql2::Client.new(
            host: Modules::Database.host,
            username: Modules::Database.user,
            password: Modules::Database.pass,
            database: Modules::Database.name,
            port: port
        )

        results = client.query("SHOW DATABASES")

        results.each do |row|
            p row["Database"]
        end

        client.close
    end
end

MysqlConnection.conn