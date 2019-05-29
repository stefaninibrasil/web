require 'pg'
require_relative '../../config/modules'

module Model
    include Modules

    def self.conn
        if Modules::Database.database === 'pgsql'
            host = Modules::Database.host
            dbname = Modules::Database.name
            user = Modules::Database.user
            password = Modules::Database.pass
            port = Modules::Database.port
            @connection = PG.connect(host: host, dbname: dbname, user: user, password: password)
        end
        @connection
    end

    def self.insert(script)
        @connection.exec(script)
    end
    def self.update(script)
        @connection.exec(script)
    end
    def self.delete(script)
        @connection.exec(script)
    end
end