classdef controller < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        viewObj;
        modelObj;
    end

   
    methods
        function obj = controller(viewObj,modelObj)
            obj.viewObj = viewObj;
            obj.modelObj = modelObj;
        end
        function callback_submitButton(obj,src,event)
            capp = obj.viewObj;
            em = employee(capp.nameEditField.Value,capp.phonenumberEditField.Value,capp.RoleDropDown.Value);
            obj.modelObj.addEmployee(em);
        end
        
    end
end

