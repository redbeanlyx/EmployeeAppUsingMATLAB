classdef allEmployee < handle
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        employees
    end
    
    events
        employeesChanged
    end
    
    methods
        function obj = allEmployee()
            %UNTITLED4 Construct an instance of this class
            %   Detailed explanation goes here
            e1 = employee('Yixuan',1234,'Intern');
            e2 = employee('Sean',2233,'Intern');
            e3 = employee('Lily',0000,'Manager');
            
            obj.employees = {e1;e2;e3};
        end
        
        function  addEmployee(obj,e)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
           obj.employees(end+1,1) = e;
           obj.notify('employeesChanged');
        end
    end
end

