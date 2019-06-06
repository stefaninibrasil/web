# frozen_string_literal: true

require 'tiny_tds'
require_relative 'gateway'

##
# This module is designed to connect and execute a SQL Server script
#
module MSSQLModule
  include GatewayModule

  @driver = Modules::Database.connection[:driver]
  @sshd = Modules::Database.sshd.to_s.eql?('true')

  def self.conn
    return unless @driver.eql?('mssql')

    @client = TinyTds::Client.new(
      host: Modules::Database.host,
      username: Modules::Database.user,
      password: Modules::Database.pass,
      database: Modules::Database.name,
      port: @sshd ? GatewayModule.tunnel : Modules::Database.port,
      login_timeout: 2
    )
  end

  def self.exec(script)
    if conn.nil?
      'O driver de Banco de Dados informado não é suportado.'
    else
      conn
      @hash = @client.execute(script.to_s).each
      close
      @hash
    end
  end

  def self.close
    @client.close
  end
end
