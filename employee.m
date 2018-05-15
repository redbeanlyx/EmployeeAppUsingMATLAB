classdef employee < handle
    
    
    properties       
       name;
       phone;
       role;
      
    end
    properties(SetAccess=private)
       id; 
    end
    properties(Constant,Hidden)
       count = thiscount();
    end
    
    methods
        function obj = employee(name, phone, role)
          
            obj.count.add;
            obj.id=obj.count.number;
            obj.name = name;
            obj.phone = phone;
            obj.role = role;
        end
        
       
    end
end

