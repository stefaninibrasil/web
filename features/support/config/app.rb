require_relative 'dotenv'

module AppModule
    
    include EnvironmentModule
    
    Dotenv.require_keys("APP_ENV", "APP_HOST")

    def self.env
        {
            'app_env' => ENV.fetch('APP_ENV', 'production'),
            'app_host' => ENV.fetch('APP_HOST', 'http://localhost')
        }
    end
end