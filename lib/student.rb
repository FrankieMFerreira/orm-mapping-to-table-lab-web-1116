class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
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
    sql =  <<-SQL
      DROP TABLE students
        SQL
    DB[:conn].execute(sql)
  end

  def save
    sql =  <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?)
        SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    newstudent = Student.new(name, grade)
    newstudent.save
    newstudent
  end




end
