require_relative 'dotenv'

module DatabaseModule

    include EnvironmentModule

    Dotenv.require_keys("DB_TYPE", "DB_HOST", "DB_USER", "DB_PASS", "DB_NAME", "DB_PORT")

    def self.env
        {
            db_type: ENV.fetch('DB_TYPE', 'mysql'),
            db_sshd: ENV.fetch('DB_SSHD', false),
            connections: {
                sqlite: {
                    driver: 'sqlite'
                    # database: ENV.fetch('DB_TYPE', database_path('database.sqlite')),
                    # prefix: ''
                    # foreign_key_constraints: ENV.fetch('DB_FOREIGN_KEYS', true),
                    # local_port: ENV.fetch('DB_SSHP', '')
                },

                mysql: {
                    driver: 'mysql',
                    host: ENV.fetch('DB_HOST', '127.0.0.1'),
                    port: ENV.fetch('DB_PORT', '3306'),
                    database: ENV.fetch('DB_NAME', 'forge'),
                    username: ENV.fetch('DB_USER', 'forge'),
                    password: ENV.fetch('DB_PASS', ''),
                    unix_socket: ENV.fetch('DB_SOCKET', ''),
                    charset: 'utf8mb4',
                    collation: 'utf8mb4_unicode_ci',
                    prefix: '',
                    prefix_indexes: true,
                    strict: true,
                    engine: nil,
                    local_port: ENV.fetch('DB_SSHP', '33060')
                },

                pgsql: {
                    driver: 'pgsql',
                    host: ENV.fetch('DB_HOST', '127.0.0.1'),
                    port: ENV.fetch('DB_PORT', '5432'),
                    database: ENV.fetch('DB_NAME', 'forge'),
                    username: ENV.fetch('DB_USER', 'forge'),
                    password: ENV.fetch('DB_PASS', ''),
                    charset: 'utf8',
                    prefix: '',
                    prefix_indexes: true,
                    schema: 'public',
                    sslmode: 'prefer',
                    local_port: ENV.fetch('DB_SSHP', '54320')
                },

                mssql: {
                    driver: 'mssql',
                    host: ENV.fetch('DB_HOST', 'localhost'),
                    port: ENV.fetch('DB_PORT', '1433'),
                    database: ENV.fetch('DB_NAME', 'forge'),
                    username: ENV.fetch('DB_USER', 'forge'),
                    password: ENV.fetch('DB_PASS', ''),
                    charset: 'utf8',
                    prefix: '',
                    prefix_indexes: true,
                    local_port: ENV.fetch('DB_SSHP', '14330')
                },

            },
        }
    end
end