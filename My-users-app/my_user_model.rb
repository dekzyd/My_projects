require 'sqlite3'

class User
    attr_accessor :id, :firstname, :lastname, :age, :password , :email
    def initialize (id=0, firstname, lastname, age, password , email)
        @firstname=firstname
        @lastname=lastname
        @age=age 
        @password=password 
        @email=email
        @id=id
    end

    def self.connect()
        begin
            @db_connect = SQLite3::Database.open 'db.sql'
            @db_connect.results_as_hash = true
            @db_connect.execute "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, firstname STRING, lastname STRING, age INTEGER, password STRING, email STRING)"
            return @db_connect
        rescue SQLite3::Exception => error
            puts "Error Ocurred: ", error.message
        end
    end 

    def self.create(user_info)
        @firstname = user_info[:firstname]
        @lastname = user_info[:lastname]
        @age = user_info[:age] 
        @password = user_info[:password] 
        @email = user_info[:email]
        

        @db_connect = self.connect
        @db_connect.execute "INSERT INTO users(firstname, lastname, age, password, email) VALUES(?,?,?,?,?)", @firstname, @lastname, @age, @password, @email
        user=User.new(@firstname, @lastname, @age, @password, @email)
        user.id = @db_connect.last_insert_row_id
        @db_connect.close
        return user
    end 

    def self.find(user_id)
        @db_connect = self.connect
        user = @db_connect.execute "SELECT * FROM users WHERE id = ?", user_id
        user_info=User.new(user[0]["firstname"], user[0]["lastname"], user[0]["age"],user[0]["password"], user[0]["email"])
        @db_connect.close
        return user_info
    end
     
    def self.all()
        @db_connect = self.connect()
        user = @db_connect.execute "SELECT * FROM users"
        @db_connect.close
        return user
    end 

    def self.update(user_id, attribute, value)
        @db_connect = self.connect
        @db_connect.execute "UPDATE users SET #{attribute} = ? WHERE id = ? ", value, user_id
        user = @db_connect.execute "SELECT * FROM users where id = ? ", user_id
        @db_connect.close
        return user
    end

    def self.destroy(user_id)
        @db_connect=self.connect()
        deleted_user=@db_connect.execute "DELETE FROM users WHERE id=#{user_id}"
        @db_connect.close
        return deleted_user 
    end 

    def self.authenticate(password, email)
        @db_connect = self.connect
        user = @db_connect.execute "SELECT * FROM users WHERE email = ? AND password = ?", email, password
        @db_connect.close
        return user 
    end
end