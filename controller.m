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
        function callback_createButton(obj,src,event)
            obj.modelObj.withDraw(obj.viewObj.viewRMB.Value);
        end
        
    end
end

