require_relative 'dotenv'

module MailModule
    
    include EnvironmentModule

    def self.env
        {
            mail_type: ENV.fetch('MAIL_TYPE', 'smtp'),
            mail_host: ENV.fetch('MAIL_HOST', 'smtp.mailgun.org'),
            mail_port: ENV.fetch('MAIL_PORT', 587),
            mail_user: ENV.fetch('MAIL_USER', ''),
            mail_pass: ENV.fetch('MAIL_PASS', ''),
            mail_hash: ENV.fetch('MAIL_HASH', 'tls'),
            mail_addr: ENV.fetch('MAIL_ADDR', 'hello@example.com'),
            mail_name: ENV.fetch('MAIL_NAME', 'Example')
        }
    end
end