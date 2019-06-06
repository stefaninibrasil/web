# frozen_string_literal: true

require 'pg'
require_relative 'gateway'

##
# This module is designed to connect and execute a PostgreSQL script
#
module PostgreSQLModule
  include GatewayModule

  @driver = Modules::Database.connection[:driver]
  @sshd = Modules::Database.sshd.to_s.eql?('true')

  def self.conn
    return unless @driver.eql?('pgsql')

    @client = PG::Connection.new(
      host: Modules::Database.host,
      dbname: Modules::Database.name,
      user: Modules::Database.user,
      password: Modules::Database.pass,
      port: @sshd ? GatewayModule.tunnel : Modules::Database.port
    )
  end

  def self.exec(script)
    if conn.nil?
      'O driver de Banco de Dados informado não é suportado.'
    else
      conn
      @hash = @client.query(script.to_s)
      close
      @hash
    end
  end

  def self.close
    @client.close
  end
end
