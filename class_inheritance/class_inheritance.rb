require 'singleton'
class Employee

    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
        update_boss
    end

    def update_boss
        boss.add_employee(self)
    end

    def bonus(multiplier)
        @bonus = salary * multiplier
    end

    def get_salary
        salary 
    end

    private
    attr_reader :salary, :boss

end

class Manager < Employee

    attr_reader :employees

    def initialize(name, title, salary, boss)
        super
        @employees = []
    end

    def add_employee(employee)
        employees << employee
    end
    
    def bonus(multiplier)
        total_salary = 0
        queue = []
        queue.push(self)
        
        until queue.empty?
            current = queue.pop
            next unless current.is_a?(Manager)
            current.employees.each do |employee|
                total_salary += employee.get_salary
                queue.push(employee)
            end
        end

        @bonus = total_salary * multiplier
    end
end

class NullEmployee < Employee
    include Singleton
    
    def initialize
    end

    def add_employee(_employee)
    end
    
    def update_boss
    end

    def bonus(_multiplier)
    end

    def get_salary
    end

end