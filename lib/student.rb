class Student
    attr_accessor :name, :age, :id

    def initialize(name:, age:, id: nil)
        @id=id
        @name=name
        @age = age
    end

    # TODO: CREATE TABLE
    def self.create_table
        sql = <<-SQL
            CREATE TABLE IF NOT EXISTS students(
                id INTEGER PRIMARY KEY,
                name TEXT,
                age INTEGER
            );
        SQL
        DB[:conn].execute(sql)
    end

    # TODO: INSERT RECORD
    def add_to_db
        sql = <<-SQL
            INSERT INTO students(name, age)
            VALUES(?, ?);
        SQL
        DB[:conn].execute(sql, self.name, self.age)
        set_id
    end

    # TODO: SHOW ALL RECORDS
    def self.show_all
        sql = <<-SQL
            SELECT * FROM students
        SQL
        DB[:conn].execute(sql).map do |row|
            object_from_db(row)
        end
    end

    #SHOW PREVIOUSLY ADDED RECORD
    # def show_most_recent
    #     sql = <<-SQL
    #         SELECT * FROM students ORDER BY id DESC LIMIT 1
    #     SQL
    #     DB[:conn].execute(sql).map do |row|
    #         Student.object_from_db(row)
    #     end.first
    # end

    # TODO: UPDATE RECORD
    def update_student_record
        sql = <<-SQL
            UPDATE students
            SET name = ?, age = ?
            Where id = ?
        SQL
        DB[:conn].execute(sql, self.name, self.age, self.id)
    end

    # TODO: DELETE RECORD
    def delete_student
        sql = <<-SQL
            DELETE
            FROM students
            WHERE id = ?
        SQL
        DB[:conn].execute(sql, self.id)
    end

    # TODO: CONVERT TABLE RECORD TO RUBY OBJECT
    def self.object_from_db(row)
        self.new(           #same as Student.new()
            name: row[1],
            age: row[2],
            id: row[0]
        )
    end

    #TODO: FIND THE OLDEST STUDENT
    def oldest_student
        sql = <<-SQL
            SELECT name, age
            FROM students
            ORDER BY age
            DESC
            LIMIT 1
        SQL
        DB[:conn].execute(sql)
    end

    # TODO: SEARCH FOR RECORD THAT MEETS CERTAIN CONDITIONS


    private

    def set_id
        sql = <<-SQL
            SELECT last_insert_rowid() FROM students
        SQL
   
        retrieved_id = DB[:conn].execute(sql)
        self.id = retrieved_id[0][0]
    end

end
