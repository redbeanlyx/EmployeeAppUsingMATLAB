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
        
        function em = searchEmployeeById(obj, id)
            
            ss = size(obj.employees);
            rows = ss(1);
            for index = 1:rows
                if isequal(obj.employees{index,1}.id,id)
                    disp('test');
                    em = obj.employees{index,1};
                    return 
                end
                
            end
            
            %???
             
        end
    end
end
