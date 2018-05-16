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
            e4 = employee('Sia','3445','Intern');
            e5 = employee('Tom','9865','Intern');
            
            obj.employees = {e1;e2;e3;e4;e5};
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
                   
                    em = obj.employees{index,1};
                    return 
                end
                
            end
            
            %???return null
             
        end
        
        function row = searchEmployee(obj, id)
            
            ss = size(obj.employees);
            rows = ss(1);
            for index = 1:rows
                if isequal(obj.employees{index,1}.id,id)
                   
                    row = index;
                    return 
                end
                
            end
            
            %???
             
        end
        
        function ems = searchEmployeeByName(obj,name)
            ems = {};%initialize the size of the array
            ss = size(obj.employees);
            rows = ss(1);
            expression = ['.*',name,'.*'] ;
%             count = 1;
            for index = 1:rows
                startIndex = regexpi(obj.employees{index,1}.name,expression);
                if isempty(startIndex)==0
                   
                    ems{end+1,1} = obj.employees{index,1};
%                     count = count +1;
                     
                end
                
            end
            disp(size(ems));
            
        end
        
        function updateEmployeeById(obj,em,name,phone,role)
            em.name = name;
            em.phone = phone;
            em.role = role;
            obj.notify('employeesChanged');
        end
        
        function deleteEmployee(obj,id)
            row = obj.searchEmployee(id);
            disp(obj.employees{row,1});
            obj.employees(row) = [];
            obj.notify('employeesChanged');
        end
        
    end
end
