classdef controller < handle

    
    properties
        viewObj;
        modelObj;
    end

   
    methods
        function obj = controller(viewObj,modelObj)
            obj.viewObj = viewObj;
            obj.modelObj = modelObj;
        end
%         input validation
        function result = isValidate(obj,name,phone)
            if isempty(name)
                warndlg('name can not be empty!','Warning');
                result = 0;
                return
            end
            expression = '([^a-z])+';
            if isempty(regexpi(name,expression)) == 0
                warndlg('name should be characters!','Warning');
                result = 0;
                return
            end
            if length(name) < 3
                warndlg('length of name should be at least 3!','Warning');
                result = 0;
                return
            end
            expression = '\d{4}';
            startIndex = regexp(phone,expression);
           
            if length(phone)~=4 || isempty(startIndex)==1
               
                warndlg('phone should be 4 digits!','Warning');
                result = 0;
                return
            end
            result = 1;
        end
        
        function callback_submitButton(obj,src,event)
            
            capp = obj.viewObj;
            name = capp.nameEditField.Value;
            phone = capp.phonenumberEditField.Value;
            role = capp.RoleDropDown.Value;
            if isValidate(obj,name,phone) == 0
                return
            end
            em = employee(name,phone,role);
            obj.modelObj.addEmployee(em);
        end
        
        function callback_updateButton(obj,src,event)
            
            name = obj.viewObj.nameEditField.Value;
            phone= obj.viewObj.phonenumberEditField.Value;
            role= obj.viewObj.RoleDropDown.Value;
           if isValidate(obj,name,phone) == 0
                return
            end 
            obj.modelObj.updateEmployeeById(obj.viewObj.em,name,phone,role);
        end
        
        function callback_deleteButton(obj,src,event)
             if isempty(obj.viewObj.selectedCell)
                warndlg('should select a row!');
                return
            end
            row = obj.viewObj.selectedCell(1);
            id = obj.viewObj.employeeTbl.Data{row,4};
            obj.modelObj.deleteEmployee(id);
        end
        
%         function callback_sortButton(obj,src,event)
%             obj.modelObj.sortEmployees();
%         end
        
%          function callback_searchButton(obj,src,event)
%             row = obj.viewObj.selectedCell(1);
%             id = obj.viewObj.employeeTbl.Data{row,4};
%             obj.modelObj.searchEmployeeByName(name);
%          end
    end
end

