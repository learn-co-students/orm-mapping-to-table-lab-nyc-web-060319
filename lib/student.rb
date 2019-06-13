class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  attr_reader :name, :grade
  attr_reader :id

  def initialize(id= nil, name, grade)
    @id = id 
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<- SQL
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
      SQL
    
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    
    DB[:conn].excute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO student (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].excute(sql, self.nae, self.grade)
    @id = DB[:conn].excute("SELECT 
      last_insert_rowid() FROM students")[0][0]
    end
  end

  def self.create(name:, grade:)
    student =  Student.new(name, grade)
    student.save 
    student 
  end

  
end
