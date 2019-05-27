require 'pg'

class Database
    # Database Constructor Method
    def initialize(host, dbname, user, password)
        @connection = PG.connect(host: host, dbname: dbname, user: user, password: password)
    end
end