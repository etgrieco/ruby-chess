class Employee


  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss = name, title, salary, boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

  def inspect
    "#{salary}: #{@employees}"
  end

  protected

  attr_reader :salary

end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss)
    super
    @employees = []
  end

  def bonus(multiplier)
    @employees.inject(0){|sum, employee| sum += employee.salary} * multiplier
  end

  def assign_employees(*employees)
    employees.each do |employee|
      if employee.is_a?(Manager)
        @employees += employee.employees
        @employees << employee
      else
        @employees << employee
      end
    end
  end

end

ned = Manager.new("ned", "Founder", 1000000, nil)
darren = Manager.new("darren", "TA Manager", 78000, ned)
shawna = Employee.new("shawna", "TA", 12000, darren)
david = Employee.new("david", "TA", 10000, darren)

darren.assign_employees(shawna, david)
ned.assign_employees(darren)
