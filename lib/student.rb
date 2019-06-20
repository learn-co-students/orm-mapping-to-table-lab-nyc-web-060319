class Student

    # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn] 
  attr_reader :id 
  attr_accessor :name, :grade 

  def initialize(name, grade, id = nil)
    @name = name 
    @grade = grade  
    @id = id
  end 
 
 def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql) 
  end
  
  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end 

  def save 
        sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?);
    SQL
    DB[:conn].execute(sql, @name, @grade)
    @id = DB[:conn].execute("SELECT MAX(id) FROM students")[0][0]
  end 

  def self.create(name:, grade:) 
    pupil = Student.new(name, grade)
    pupil.save 
    return pupil
  end 



end 