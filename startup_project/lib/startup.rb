require "employee"

class Startup
    
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @employees = []
        @salaries = salaries

    end

    def valid_title?(title)
        if @salaries.has_key?(title)
            return true
        else  
            return false 
        end 
    end 

    def >(startup_name)
        if self.funding > startup_name.funding 
            return true
        else  
            return false 
        end 
    end 

    def hire(employee_name, title)
        if @salaries.has_key?(title)
           @employees << Employee.new(employee_name, title)
        else  
            raise error
        end
    end

    def size
        @employees.length
    end 

    def pay_employee(employee)
        if @funding > @salaries[employee.title]
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else  
            raise error 
        end 
    end 

    def payday
        @employees.each do |employee|
            pay_employee(employee)
        end 
    end 

    def average_salary
        total_salary = 0
        employee_count = 0
        @employees.each do |employee|
            employee_count += 1
            total_salary += @salaries[employee.title]
        end 
         

        average_salary = 0
        average_salary = total_salary / employee_count 
        return average_salary 
    end  

    def close
        @employees = []
        @funding = 0
    end 

    def acquire(startup)
            combined_employees = @employees + startup.employees
            @funding += startup.funding
            @employees = combined_employees
            startup.salaries.each do |title, salary|
                if !@salaries.has_key?(title)
                    @salaries[title] = salary 
                end 
            end 
            startup.close
    end
    
    









end
