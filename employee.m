classdef employee
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       name;
       phone;
       role;
    end
    
    methods
        function obj = employee(name, phone, role)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.name = name;
            obj.phone = phone;
            obj.role = role;
        end
        
       
    end
end

