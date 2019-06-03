require 'net/ssh'
require_relative '../../config/modules'

module SSHConnect
    include Modules

    def self.connect(command)
        host = Modules::SSH.host
        user = Modules::SSH.user
        pass = Modules::SSH.pass
        port = Modules::SSH.port
        
        Net::SSH.start(host, user, password: pass, port: port) do |ssh|
            ssh.exec!(command.to_s)
        end
    end
end