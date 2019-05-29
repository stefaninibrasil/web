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
        classModule.env[key].to_s
    end

    def self.checkDatabaseEnvKeys(key_name, default_value, database_name, database_key)
        configuration = self.getDatabaseConfiguration(database_name.to_s)
        key = key_name.to_s.downcase
        database_key = database_key.to_s.downcase
        if ENV.has_key?(key) && ENV[key].to_s.empty?
            ENV[key] = default_value.to_s
            configuration[database_key] = ENV[key]
        end
        configuration[database_key]
    end

    def self.getDatabaseConfiguration(database_name)
        DatabaseModule.env['connections'].first[database_name.to_s].first
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
            unless self.database.empty?
                if ['mysql', 'pgsql', 'sqlsrv', 'sqlite'].include?(self.database)
                    if self.database === 'mysql'
                        Modules.getDatabaseConfiguration(self.database)
                    elsif self.database === 'pgsql'
                        Modules.getDatabaseConfiguration(self.database)
                    elsif self.database === 'sqlsrv'
                        Modules.getDatabaseConfiguration(self.database)
                    elsif self.database === 'sqlite'
                        Modules.getDatabaseConfiguration(self.database)
                    end
                else
                    Modules.getDatabaseConfiguration('mysql')
                end
            end
        end

        def self.host
            Modules.checkDatabaseEnvKeys('DB_HOST', '127.0.0.1', self.connection['driver'], 'host')
        end

        def self.port
            Modules.checkDatabaseEnvKeys('DB_PORT', '5432', self.connection['driver'], 'port')
        end

        def self.name
            Modules.checkDatabaseEnvKeys('DB_NAME', 'forge', self.connection['driver'], 'database')
        end

        def self.user
            Modules.checkDatabaseEnvKeys('DB_USER', 'forge', self.connection['driver'], 'username')
        end

        def self.pass
            Modules.checkDatabaseEnvKeys('DB_PASS', '', self.connection['driver'], 'password')
        end        
    end
end