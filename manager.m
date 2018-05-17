classdef manager < employee
   
    
    properties
        employees
    end
    
    methods
        function obj = manager(name,phone,role)
            obj=obj@employee(name,phone,role);
        end
        function  addEmployee(obj,e)
            
            obj.employees{end+1,1} = e;
           
        end
        
    end
end

