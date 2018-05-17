classdef updateManager < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        TabGroup                     matlab.ui.container.TabGroup
        profileTab                   matlab.ui.container.Tab
        nameEditFieldLabel           matlab.ui.control.Label
        nameEditField                matlab.ui.control.EditField
        phonenumberEditFieldLabel    matlab.ui.control.Label
        phonenumberEditField         matlab.ui.control.EditField
        RoleDropDownLabel            matlab.ui.control.Label
        RoleDropDown                 matlab.ui.control.DropDown
        updateButton                 matlab.ui.control.Button
        cancelButton                 matlab.ui.control.Button
        directreportTab              matlab.ui.container.Tab
        employeelistListBoxLabel     matlab.ui.control.Label
        employeelistListBox          matlab.ui.control.ListBox
        employeeidEditFieldLabel     matlab.ui.control.Label
        employeeidEditField          matlab.ui.control.EditField
    end

    
    properties (Access = public)
        controlObj
        modelObj
        id
        em
    end
    
    methods (Access = private)
     
        function attatchToController(app,controller)
            funcH = @controller.callback_updateButton;
	        addlistener(app.updateButton,'ButtonPushed',funcH)

        end
    
        
        function  populateList(app,em)
            ss = size(em);
            rows = ss(1);
            d = cell(rows,1) ;
            did = zeros(rows,1);
            for inx=1:rows
                d{inx,1} = em{inx,1}.name;
               did(inx,1) = em{inx,1}.id;
            end 
          
            app.employeelistListBox.Items = d;
            app.employeelistListBox.ItemsData = did;
            
        end
        

    end

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, id, modelObj)
            
            app.id = id;
            app.modelObj =  modelObj;
            app.controlObj = controller(app,app.modelObj);
            app.attatchToController(app.controlObj);
            app.em = app.modelObj.searchEmployeeById(app.id);
            app.nameEditField.Value = app.em.name;
            app.phonenumberEditField.Value = app.em.phone;
            app.RoleDropDown.Value = app.em.role; 
            populateList(app,app.em.employees);
%             app.employeelistListBox.ValueChangedFcn= @selectionChanged;
        end

        % Button pushed function: cancelButton
        function cancelButtonPushed(app, event)
            delete(app);
        end

        % Value changed function: employeelistListBox
        function employeelistListBoxValueChanged(app, event)
            value = app.employeelistListBox.Value;
            
            app.employeeidEditField.Value = string(value);
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

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 640 480];

            % Create profileTab
            app.profileTab = uitab(app.TabGroup);
            app.profileTab.Title = 'profile';

            % Create nameEditFieldLabel
            app.nameEditFieldLabel = uilabel(app.profileTab);
            app.nameEditFieldLabel.HorizontalAlignment = 'right';
            app.nameEditFieldLabel.Position = [201 341 36 22];
            app.nameEditFieldLabel.Text = 'name';

            % Create nameEditField
            app.nameEditField = uieditfield(app.profileTab, 'text');
            app.nameEditField.Position = [252 341 100 22];

            % Create phonenumberEditFieldLabel
            app.phonenumberEditFieldLabel = uilabel(app.profileTab);
            app.phonenumberEditFieldLabel.HorizontalAlignment = 'right';
            app.phonenumberEditFieldLabel.Position = [157 287 83 22];
            app.phonenumberEditFieldLabel.Text = 'phone number';

            % Create phonenumberEditField
            app.phonenumberEditField = uieditfield(app.profileTab, 'text');
            app.phonenumberEditField.Position = [255 287 100 22];

            % Create RoleDropDownLabel
            app.RoleDropDownLabel = uilabel(app.profileTab);
            app.RoleDropDownLabel.HorizontalAlignment = 'right';
            app.RoleDropDownLabel.Position = [212 229 30 22];
            app.RoleDropDownLabel.Text = 'Role';

            % Create RoleDropDown
            app.RoleDropDown = uidropdown(app.profileTab);
            app.RoleDropDown.Items = {'Manager', ''};
            app.RoleDropDown.Enable = 'off';
            app.RoleDropDown.Position = [257 229 100 22];
            app.RoleDropDown.Value = 'Manager';

            % Create updateButton
            app.updateButton = uibutton(app.profileTab, 'push');
            app.updateButton.Position = [391 84 100 22];
            app.updateButton.Text = 'update';

            % Create cancelButton
            app.cancelButton = uibutton(app.profileTab, 'push');
            app.cancelButton.ButtonPushedFcn = createCallbackFcn(app, @cancelButtonPushed, true);
            app.cancelButton.Position = [113 84 100 22];
            app.cancelButton.Text = 'cancel';

            % Create directreportTab
            app.directreportTab = uitab(app.TabGroup);
            app.directreportTab.Title = 'direct report';

            % Create employeelistListBoxLabel
            app.employeelistListBoxLabel = uilabel(app.directreportTab);
            app.employeelistListBoxLabel.HorizontalAlignment = 'right';
            app.employeelistListBoxLabel.Position = [216 325 76 22];
            app.employeelistListBoxLabel.Text = 'employee list';

            % Create employeelistListBox
            app.employeelistListBox = uilistbox(app.directreportTab);
            app.employeelistListBox.Items = {};
            app.employeelistListBox.ValueChangedFcn = createCallbackFcn(app, @employeelistListBoxValueChanged, true);
            app.employeelistListBox.Position = [307 244 100 105];
            app.employeelistListBox.Value = {};

            % Create employeeidEditFieldLabel
            app.employeeidEditFieldLabel = uilabel(app.directreportTab);
            app.employeeidEditFieldLabel.HorizontalAlignment = 'right';
            app.employeeidEditFieldLabel.Position = [227 160 70 22];
            app.employeeidEditFieldLabel.Text = 'employee id';

            % Create employeeidEditField
            app.employeeidEditField = uieditfield(app.directreportTab, 'text');
            app.employeeidEditField.Editable = 'off';
            app.employeeidEditField.Enable = 'off';
            app.employeeidEditField.Position = [312 160 100 22];
        end
    end

    methods (Access = public)

        % Construct app
        function app = updateManager(varargin)

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

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