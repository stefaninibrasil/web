# config/app.rb

require_relative 'dotenv'

class Application
    
    Dotenv.require_keys("APP_ENV", "APP_URL")

    def envs
        {

            # |--------------------------------------------------------------------------
            # | Application Environment
            # |--------------------------------------------------------------------------
            # |
            # | This value determines the "environment" your application is currently
            # | running in. This may determine how you prefer to configure various
            # | services the application utilizes. Set this in your ".env" file.
            # |

            'env' => ENV.fetch('APP_ENV', 'production'),


            # |--------------------------------------------------------------------------
            # | Application URL
            # |--------------------------------------------------------------------------
            # |
            # | This URL is used by the console to properly generate URLs when using
            # | the Artisan command line tool. You should set this to the root of
            # | your application so that it is used when running Artisan tasks.
            # |

            'url' => ENV.fetch('APP_URL', 'http://localhost')
        }
    end
end