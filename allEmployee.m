classdef allEmployee < handle
    
    properties
        employees
    end
    
    events
        employeesChanged
    end
    
    methods
        function obj = allEmployee()
   
            employee.count.clear();
            
            e1 = employee('Yixuan','1234','Intern');
            e2 = employee('Sean','2233','Intern');
            e3 = employee('Lily','0000','Manager');
            
            obj.employees = {e1;e2;e3};
        end
        
        function  addEmployee(obj,e)
          
           obj.employees{end+1,1} = e;
           obj.notify('employeesChanged');
        end
    end
end

