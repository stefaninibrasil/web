require 'mysql2'
require 'net/ssh'

require_relative '../ssh/ssh_connect'

module DatabaseConnect
    include Modules, SSHConnect

    def self.conn
        db_host = Modules::Database.host
        db_name = Modules::Database.name
        db_user = Modules::Database.user
        db_pass = Modules::Database.pass
        db_port = Modules::Database.port

        host = Modules::SSH.host
        user = Modules::SSH.user
        pass = Modules::SSH.pass
        port = Modules::SSH.port

        if Modules::Database.database === 'pgsql'
            # connection = PG.connect(host: host, dbname: name, user: user, password: pass, port: port)
        elsif Modules::Database.database === 'mysql'
            if Modules::Database.sshd === 'true'
                # connection = Mysql2::Client.new(:host => host, :database => name, :username => user, :password => pass, :port => port)
            end
        end
    end
end