classdef mainEmployee < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure          matlab.ui.Figure
        Panel             matlab.ui.container.Panel
        employeeTbl       matlab.ui.control.Table
        createButton      matlab.ui.control.Button
        updateButton      matlab.ui.control.Button
        deleteButton      matlab.ui.control.Button
        allemployeeLabel  matlab.ui.control.Label
        Label             matlab.ui.control.Label
        searchEditField   matlab.ui.control.EditField
        searchButton      matlab.ui.control.Button
        sortbynameButton  matlab.ui.control.Button
    end

    
    properties (Access = public)
        controlObj
        modelObj
        createEmployeeApp
        updateEmployeeApp
        selectedCell
        
    end

    
    methods (Access = public)
        
        function func(app)
            
        end
        function updateEmployees(app,src,data)
            em = app.modelObj.employees;
            populateTbl(app,em);
       	end
%         function updateSearchEmployees(app,src,data)
%             em = app.modelObj.employees;
%             populateTbl(app,em);
%        	end

    end
    
    methods (Access = private)
        
        function attatchToController(app,controller)
            funcH = @controller.callback_deleteButton;
        	   addlistener(app.deleteButton,'ButtonPushed',funcH)
            
%             funcH = @controller.callback_sortButton;
%         	   addlistener(app.sortbynameButton,'ButtonPushed',funcH)

        end
        
        function populateTbl(app,em)
            ss = size(em);
            rows = ss(1);
            d = cell(rows,3) ;
            for inx=1:rows
                d{inx,1} = em{inx,1}.name;
                d{inx,2} = em{inx,1}.phone;
                d{inx,3} = em{inx,1}.role;
                d{inx,4} = em{inx,1}.id;
            end 
            app.employeeTbl.Data = d;
        end
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
           
            app.modelObj = allEmployee();
            em = app.modelObj.employees;
            
            populateTbl(app,em);
            app.controlObj = controller(app,app.modelObj);
       	    app.attatchToController(app.controlObj);
            
       	    app.modelObj.addlistener('employeesChanged',@app.updateEmployees);
            
        end

        % Button pushed function: createButton
        function createButtonPushed(app, event)
          app.createEmployeeApp = createEmployee(app.modelObj);
         
        end

        % Cell selection callback: employeeTbl
        function employeeTblCellSelection(app, event)
          
            app.selectedCell = event.Indices;
            
        end

        % Button pushed function: updateButton
        function updateButtonPushed(app, event)
            if isempty(app.selectedCell)
                warndlg('should select a row!');
                return
            end
            row = app.selectedCell(1);
            id = app.employeeTbl.Data{row,4};
            if isequal(app.employeeTbl.Data{row,3},'Manager')
               updateManager(id,app.modelObj) ;
               return 
            end
            updateEmployee(id,app.modelObj);
        end

        % Button pushed function: searchButton
        function searchButtonPushed(app, event)
            name = app.searchEditField.Value;
            ems = app.modelObj.searchEmployeeByName(name);
            populateTbl(app,ems);
        end

        % Button pushed function: deleteButton
        function deleteButtonPushed(app, event)
            
        end

        % Button pushed function: sortbynameButton
        function sortbynameButtonPushed(app, event)
            [~, ix] = sort(app.employeeTbl.Data(1:end,1)) ; 
            app.employeeTbl.Data(1:end,:) = app.employeeTbl.Data(ix,:) ;          
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

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.Title = 'Panel';
            app.Panel.Position = [1 1 640 480];

            % Create employeeTbl
            app.employeeTbl = uitable(app.Panel);
            app.employeeTbl.ColumnName = {'name'; 'phone number'; 'role'; 'id'};
            app.employeeTbl.RowName = {};
            app.employeeTbl.CellSelectionCallback = createCallbackFcn(app, @employeeTblCellSelection, true);
            app.employeeTbl.Position = [80 126 463 226];

            % Create createButton
            app.createButton = uibutton(app.Panel, 'push');
            app.createButton.ButtonPushedFcn = createCallbackFcn(app, @createButtonPushed, true);
            app.createButton.Position = [74 83 100 22];
            app.createButton.Text = 'create';

            % Create updateButton
            app.updateButton = uibutton(app.Panel, 'push');
            app.updateButton.ButtonPushedFcn = createCallbackFcn(app, @updateButtonPushed, true);
            app.updateButton.Position = [314 83 100 22];
            app.updateButton.Text = 'update';

            % Create deleteButton
            app.deleteButton = uibutton(app.Panel, 'push');
            app.deleteButton.ButtonPushedFcn = createCallbackFcn(app, @deleteButtonPushed, true);
            app.deleteButton.Position = [443 83 100 22];
            app.deleteButton.Text = 'delete';

            % Create allemployeeLabel
            app.allemployeeLabel = uilabel(app.Panel);
            app.allemployeeLabel.FontSize = 20;
            app.allemployeeLabel.FontWeight = 'bold';
            app.allemployeeLabel.Position = [239 409 161 24];
            app.allemployeeLabel.Text = 'all employee';

            % Create Label
            app.Label = uilabel(app.Panel);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [346 364 25 22];
            app.Label.Text = '';

            % Create searchEditField
            app.searchEditField = uieditfield(app.Panel, 'text');
            app.searchEditField.Position = [386 364 90 22];

            % Create searchButton
            app.searchButton = uibutton(app.Panel, 'push');
            app.searchButton.ButtonPushedFcn = createCallbackFcn(app, @searchButtonPushed, true);
            app.searchButton.Position = [488 364 55 22];
            app.searchButton.Text = 'search';

            % Create sortbynameButton
            app.sortbynameButton = uibutton(app.Panel, 'push');
            app.sortbynameButton.ButtonPushedFcn = createCallbackFcn(app, @sortbynameButtonPushed, true);
            app.sortbynameButton.Position = [80 364 100 22];
            app.sortbynameButton.Text = 'sort by name';
        end
    end

    methods (Access = public)

        % Construct app
        function app = mainEmployee

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

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