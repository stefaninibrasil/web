require_relative File.join(Dir.pwd, 'config/app')
require_relative File.join(Dir.pwd, 'config/browser')
require_relative File.join(Dir.pwd, 'config/database')

module Modules
    include AppModule
    include BrowserModule
    include DatabaseModule

    def self.checkEnvKeys(key_name, default_value, classModule)
        key = key_name.to_s.downcase
        if ENV.has_key?(key) && ENV[key].to_s.empty?
            ENV[key] = default_value.to_s
            classModule.env[key] = ENV[key]
        end
        classModule.env[key]
    end

    def self.getDatabaseConfiguration(database_name)
        connections = DatabaseModule.env['connections']
        connections.each do |connection|
            connection[database_name.to_s]
        end 
    end

    # AppModule
    class App
        def self.env
            Modules.checkEnvKeys('APP_ENV', 'production', AppModule)
        end

        def self.host
            Modules.checkEnvKeys('APP_HOST', 'http://localhost', AppModule)
        end
    end

    # BrowserModule
    class Browser
        def self.browser
            Modules.checkEnvKeys('BROWSER', 'firefox', BrowserModule)
        end

        def self.browserHeadless
            Modules.checkEnvKeys('BROWSER_HEADLESS', false, BrowserModule)
        end 

        def self.driver
            browser = self.browser
            browser += '_headless' if self.browserHeadless === "true"
            
            case browser
            when "chrome"
                driver = ':selenium_chrome'
            when "chrome_headless"
                driver = ':selenium_chrome_headless'
            when "firefox_headless"
                driver = ':selenium_headless'
            else
                driver = ':selenium'
            end
            driver
        end

        def self.driverWaiter
            Modules.checkEnvKeys('DEFAULT_MAX_WAIT_TIME', 2, BrowserModule)
        end

        def self.screenshot
            Modules.checkEnvKeys('SCREENSHOT', false, BrowserModule)
        end
        
        def self.screenshotType
            Modules.checkEnvKeys('SCREENSHOT_TYPE', 'image/png', BrowserModule)
        end

        def self.screenshotEmbedded
            Modules.checkEnvKeys('SCREENSHOT_EMBEDDED', false, BrowserModule)
        end

        def self.screenshotOnlyFailures
            Modules.checkEnvKeys('SCREENSHOT_ONLY_FAILURES', false, BrowserModule)
        end

        def self.windowSizeWidth
            Modules.checkEnvKeys('WINDOW_SIZE_WIDTH', 1366, BrowserModule)
        end
        
        def self.windowSizeHeight
            Modules.checkEnvKeys('WINDOW_SIZE_HEIGHT', 768, BrowserModule)
        end
    end

    # DatabaseModule
    class Database

        def self.database
            Modules.checkEnvKeys('DB_TYPE', 'mysql', DatabaseModule)
        end

        def self.connection
            unless self.database.to_s.empty?
                if ['mysql', 'pgsql', 'sqlsrv'].include?(self.database.to_s)
                    if self.database === 'mysql'
                        Modules.getDatabaseConfiguration(self.database)
                    elsif self.database === 'pgsql'
                        'é postresql'
                    elsif self.database === 'sqlsrv'
                        'é sql server'
                    end
                else
                    'virou mysql'
                end
            end
        end

        # def self.host
        #     Modules.checkEnvKeys('DB_HOST', '127.0.0.1', DatabaseModule)
        # end

        # def self.port
        #     Modules.checkEnvKeys('DB_PORT', '5432', DatabaseModule)
        # end

        # def self.name
        #     Modules.checkEnvKeys('DB_NAME', 'forge', DatabaseModule)
        # end

        # def self.user
        #     Modules.checkEnvKeys('DB_USER', 'forge', DatabaseModule)
        # end

        # def self.pass
        #     Modules.checkEnvKeys('DB_PASS', '', DatabaseModule)
        # end

        # def self.connection
            
        # end
        
    end
end


# puts Modules::Database.connection

connections = DatabaseModule.env['connections']
connections.each do |connection|
    connection["mysql"]
end 