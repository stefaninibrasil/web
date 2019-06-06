require_relative 'app'
require_relative 'browser'
require_relative 'database'
require_relative 'mail'
require_relative 'report'
require_relative 'ssh'

module Modules
    include AppModule
    include BrowserModule
    include DatabaseModule
    include MailModule
    include ReportModule
    include SSHModule

    def self.checkEnvKeys(key_name, default_value, classModule)
        key = key_name.to_s.downcase.split(':').last
        if ENV.has_key?(key) && ENV[key].to_s.empty?
            ENV[key] = default_value.to_s
            classModule.env[key_name] = ENV[key]
        end
        classModule.env[key_name]
    end

    def self.checkDatabaseEnvKeys(key_name, default_value, database_name, database_key)
        configuration = self.getDatabaseConfiguration(database_name)
        key = key_name.to_s.downcase.split(':').last
        database_key = database_key.to_s.downcase

        if ENV.has_key?(key) && ENV[key].to_s.empty?
            ENV[key] = default_value.to_s
            configuration[database_key.to_sym] = ENV[key]
        end
        configuration[database_key.to_sym]
    end

    def self.getDatabaseConfiguration(database_name)
        DatabaseModule.env[:connections][database_name.to_sym]
    end

    # AppModule
    class App
        def self.env
            # AppModule.env[:app_env]
            Modules.checkEnvKeys(:app_env, 'production', AppModule)
        end

        def self.host
            Modules.checkEnvKeys(:app_host, 'http://localhost', AppModule)
        end
    end

    # BrowserModule
    class Browser
        def self.browser
            Modules.checkEnvKeys(:browser, 'firefox', BrowserModule)
        end

        def self.browserHeadless
            Modules.checkEnvKeys(:browser_headless, false, BrowserModule)
        end 

        def self.driver
            browser = self.browser
            browser += '_headless' if self.browserHeadless === "true"
            
            case browser
            when "chrome"
                driver = :selenium_chrome
            when "chrome_headless"
                driver = :selenium_chrome_headless
            when "firefox_headless"
                driver = :selenium_headless
            else
                driver = :selenium
            end
            driver
        end

        def self.driverWaiter
            Modules.checkEnvKeys(:default_max_wait_time, 2, BrowserModule)
        end
        
        def self.ignoreHiddenElements
            Modules.checkEnvKeys(:ignore_hidden_elements, false, BrowserModule)
        end

        def self.screenshot
            Modules.checkEnvKeys(:screenshot, false, BrowserModule)
        end
        
        def self.screenshotType
            Modules.checkEnvKeys(:screenshot_type, 'image/png', BrowserModule)
        end

        def self.screenshotEmbedded
            Modules.checkEnvKeys(:screenshot_embedded, false, BrowserModule)
        end

        def self.screenshotOnlyFailures
            Modules.checkEnvKeys(:screenshot_only_failures, false, BrowserModule)
        end

        def self.windowSizeWidth
            Modules.checkEnvKeys(:window_size_width, 1366, BrowserModule)
        end
        
        def self.windowSizeHeight
            Modules.checkEnvKeys(:window_size_height, 768, BrowserModule)
        end
    end

    # DatabaseModule
    class Database

        def self.database
            Modules.checkEnvKeys(:db_type, 'mysql', DatabaseModule)
        end

        def self.sshd
            Modules.checkEnvKeys(:db_sshd, false, DatabaseModule)
        end

        def self.connection
            unless self.database.nil?
                if ['mysql', 'pgsql', 'mssql', 'sqlite'].include?(self.database)
                    Modules.getDatabaseConfiguration(self.database)
                else
                    Modules.getDatabaseConfiguration('mysql')
                end
            end
        end

        def self.host
            Modules.checkDatabaseEnvKeys(:db_host, '127.0.0.1', self.connection[:driver], 'host')
        end

        def self.port
            Modules.checkDatabaseEnvKeys(:db_port, '5432', self.connection[:driver], 'port')
        end

        def self.name
            Modules.checkDatabaseEnvKeys(:db_name, 'forge', self.connection[:driver], 'database')
        end

        def self.user
            Modules.checkDatabaseEnvKeys(:db_user, 'forge', self.connection[:driver], 'username')
        end

        def self.pass
            Modules.checkDatabaseEnvKeys(:db_pass, '', self.connection[:driver], 'password')
        end     
        
        def self.localPort
            if self.connection[:driver].to_s.eql?('pgsql')
                @@port = '54320'
            elsif self.connection[:driver].to_s.eql?('mysql')
                @@port = '33060'
            elsif self.connection[:driver].to_s.eql?('mssql')
                @@port = '14330'
            else
                @@port = ''
            end
            Modules.checkDatabaseEnvKeys(:db_sshp, @@port, self.connection[:driver], 'local_port')
        end
    end

    # MailModule
    class Mail
        def self.driver
            Modules.checkEnvKeys(:mail_type, 'smtp2', MailModule)
        end

        def self.host
            Modules.checkEnvKeys(:mail_host, 'smtp.mailgun.org', MailModule)
        end

        def self.port
            Modules.checkEnvKeys(:mail_port, 587, MailModule)
        end

        def self.user
            Modules.checkEnvKeys(:mail_user, '', MailModule)
        end

        def self.pass
            Modules.checkEnvKeys(:mail_pass, '', MailModule)
        end

        def self.hash
            Modules.checkEnvKeys(:mail_hash, 'tls', MailModule)
        end

        def self.addr
            Modules.checkEnvKeys(:mail_addr, 'hello@example.com', MailModule)
        end

        def self.name
            Modules.checkEnvKeys(:mail_name, 'Example', MailModule)
        end
    end

    # ReportModule
    class Report
        def self.extension
            Modules.checkEnvKeys(:report_type, 'html', ReportModule)
        end

        def self.only_defects
            Modules.checkEnvKeys(:report_only_defects, false, ReportModule)
        end

        def self.include_evidences
            Modules.checkEnvKeys(:report_include_evidences, false, ReportModule)
        end
    end

    # SSHModule
    class SSH
        def self.host
            Modules.checkEnvKeys(:ssh_host, 'localhost', SSHModule)
        end

        def self.user
            Modules.checkEnvKeys(:ssh_user, '', SSHModule)
        end

        def self.pass
            Modules.checkEnvKeys(:ssh_pass, '', SSHModule)
        end
        
        def self.port
            Modules.checkEnvKeys(:ssh_port, 22, SSHModule)
        end
    end
end