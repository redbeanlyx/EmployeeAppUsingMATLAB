classdef createEmployee < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        submitButton               matlab.ui.control.Button
        nameLabel                  matlab.ui.control.Label
        nameEditField              matlab.ui.control.EditField
        phonenumberEditFieldLabel  matlab.ui.control.Label
        phonenumberEditField       matlab.ui.control.NumericEditField
        RoleDropDownLabel          matlab.ui.control.Label
        RoleDropDown               matlab.ui.control.DropDown
        CreateanewEmployeeLabel    matlab.ui.control.Label
    end

    
    properties (Access = public)
        controlObj
        modelObj
    end
    
    methods (Access = private)
     
        function attatchToController(app,controller)
            funcH = @controller.callback_submitButton;
	   addlistener(app.submitButton,'ButtonPushed',funcH)

        end
    
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, modelObj)
           
            app.attatchToController(app.controlObj);
        end

        % Button pushed function: submitButton
        function submitButtonPushed(app, event)
          
            delete(app);       
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            
%             func(app.mainEmployee);
            delete(app);
            
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'UI Figure';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create submitButton
            app.submitButton = uibutton(app.UIFigure, 'push');
            app.submitButton.ButtonPushedFcn = createCallbackFcn(app, @submitButtonPushed, true);
            app.submitButton.Position = [420 79 100 22];
            app.submitButton.Text = 'submit';

            % Create nameLabel
            app.nameLabel = uilabel(app.UIFigure);
            app.nameLabel.HorizontalAlignment = 'right';
            app.nameLabel.Position = [215 292 39 22];
            app.nameLabel.Text = 'name:';

            % Create nameEditField
            app.nameEditField = uieditfield(app.UIFigure, 'text');
            app.nameEditField.Position = [269 292 100 22];

            % Create phonenumberEditFieldLabel
            app.phonenumberEditFieldLabel = uilabel(app.UIFigure);
            app.phonenumberEditFieldLabel.HorizontalAlignment = 'right';
            app.phonenumberEditFieldLabel.Position = [168 243 86 22];
            app.phonenumberEditFieldLabel.Text = 'phone number:';

            % Create phonenumberEditField
            app.phonenumberEditField = uieditfield(app.UIFigure, 'numeric');
            app.phonenumberEditField.Position = [269 243 100 22];

            % Create RoleDropDownLabel
            app.RoleDropDownLabel = uilabel(app.UIFigure);
            app.RoleDropDownLabel.HorizontalAlignment = 'right';
            app.RoleDropDownLabel.Position = [220 178 34 22];
            app.RoleDropDownLabel.Text = 'Role:';

            % Create RoleDropDown
            app.RoleDropDown = uidropdown(app.UIFigure);
            app.RoleDropDown.Items = {'Manager', 'Individual Contributor', 'Intern'};
            app.RoleDropDown.Position = [269 178 100 22];
            app.RoleDropDown.Value = 'Manager';

            % Create CreateanewEmployeeLabel
            app.CreateanewEmployeeLabel = uilabel(app.UIFigure);
            app.CreateanewEmployeeLabel.FontSize = 20;
            app.CreateanewEmployeeLabel.FontWeight = 'bold';
            app.CreateanewEmployeeLabel.Position = [190 400 231 24];
            app.CreateanewEmployeeLabel.Text = 'Create A Employee';
        end
    end

    methods (Access = public)

        % Construct app
        function app = createEmployee(modelObj)

            app.modelObj =  modelObj;
            app.controlObj = controller(app,app.modelObj);
            % Create and configure components
            createComponents(app)
            
            % Register the app with App Designer
            registerApp(app, app.UIFigure)
            
            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app,modelObj))
            
            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end