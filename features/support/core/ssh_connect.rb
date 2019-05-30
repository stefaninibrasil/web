require 'net/ssh'
require_relative '../config/modules'

module SSHConnect
    include Modules

    def self.connect(command)
        Net::SSH.start(Modules::SSH.host, Modules::SSH.user, password: Modules::SSH.pass, port: Modules::SSH.port) do |ssh|
            ssh.exec!(command.to_s)
        end
    end
end

# SSHConnect.connect

puts SSHConnect.connect("hostname")