require 'bundler'
Bundler.require

require_relative '../lib/student'

DB = { conn: SQLite3::Database.new("db/school.db") }


# RUN CODE FROM HERE

#CREATE TABLE
Student.create_table

#create new student row
brian = Student.new(name: "Brian Wanjala", age: 26)

#add student to db
brian.add_to_db
pp Student.show_all

brian.name = "Stacy"
brian.age = 30
brian.update_student_record

pp Student.show_all

pp brian.oldest_student