# config/database.rb

require_relative 'dotenv'

class Database

    Dotenv.require_keys("DB_TYPE", "DB_HOST", "DB_USER", "DB_PASS", "DB_NAME", "DB_PORT")

    def envs
        [

            # |--------------------------------------------------------------------------
            # | Default Database Connection Name
            # |--------------------------------------------------------------------------
            # |
            # | Here you may specify which of the database connections below you wish
            # | to use as your default connection for all database work. Of course
            # | you may use many connections at once using the Database library.
            # |

            'default' => ENV.fetch('DB_TYPE', 'mysql'),


            # |--------------------------------------------------------------------------
            # | Database Connections
            # |--------------------------------------------------------------------------
            # |
            # | Here are each of the database connections setup for your application.
            # | Of course, examples of configuring each database platform that is
            # | supported by Laravel is shown below to make development simple.
            # |
            # |
            # | All database work in Laravel is done through the PHP PDO facilities
            # | so make sure you have the driver for your particular database of
            # | choice installed on your machine before you begin development.
            # |

            'connections' => [

                'sqlite' => [
                    'driver' => 'sqlite',
                    # 'database' => ENV.fetch('DB_TYPE', database_path('database.sqlite')),
                    # 'prefix' => ''
                    # 'foreign_key_constraints' => ENV.fetch('DB_FOREIGN_KEYS', true),
                ],

                'mysql' => [
                    'driver' => 'mysql',
                    'host' => ENV.fetch('DB_HOST', '127.0.0.1'),
                    'port' => ENV.fetch('DB_PORT', '3306'),
                    'database' => ENV.fetch('DB_TYPE', 'forge'),
                    'username' => ENV.fetch('DB_USER', 'forge'),
                    'password' => ENV.fetch('DB_PASS', ''),
                    # 'unix_socket' => ENV.fetch('DB_SOCKET', ''),
                    'charset' => 'utf8mb4',
                    'collation' => 'utf8mb4_unicode_ci',
                    'prefix' => '',
                    'prefix_indexes' => true,
                    'strict' => true,
                    'engine' => nil
                ],

                'pgsql' => [
                    'driver' => 'pgsql',
                    'host' => ENV.fetch('DB_HOST', '127.0.0.1'),
                    'port' => ENV.fetch('DB_PORT', '5432'),
                    'database' => ENV.fetch('DB_TYPE', 'forge'),
                    'username' => ENV.fetch('DB_USER', 'forge'),
                    'password' => ENV.fetch('DB_PASS', ''),
                    'charset' => 'utf8',
                    'prefix' => '',
                    'prefix_indexes' => true,
                    'schema' => 'public',
                    'sslmode' => 'prefer',
                ],

                'sqlsrv' => [
                    'driver' => 'sqlsrv',
                    'host' => ENV.fetch('DB_HOST', 'localhost'),
                    'port' => ENV.fetch('DB_PORT', '1433'),
                    'database' => ENV.fetch('DB_TYPE', 'forge'),
                    'username' => ENV.fetch('DB_USER', 'forge'),
                    'password' => ENV.fetch('DB_PASS', ''),
                    'charset' => 'utf8',
                    'prefix' => '',
                    'prefix_indexes' => true,
                ],

            ],
        ]
    end










    # attr_accessor :conn, :host, :user, :pass, :name, :port

    # Database Constructor Method
    # def initialize
    #     self.conn = ENV.fetch('DB_CONN', 'mysql')
    #     self.host = ENV.fetch('DB_HOST', '127.0.0.1')
    #     self.user = ENV.fetch('DB_USER', 'root')
    #     self.pass = ENV.fetch('DB_PASS', '')
    #     self.name = ENV.fetch('DB_NAME', 'stefanini')
    #     self.port = ENV.fetch('DB_PORT', '3306')
    # end
    
    def connection(database)
        if database == 'mysql'
            @connection = MYSQL.connect()
        elsif database == 'pgsql'
            @connection = PG.connect(host: self.host, dbname: self.dbname, user: self.user, password: self.password)
        end
    end
end

db = Database.new.envs
db.each do |key, value|
    puts key['connections'][0]['pgsql']
end