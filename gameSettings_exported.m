classdef gameSettings_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
        DecksEditFieldLabel   matlab.ui.control.Label
        DecksEditField        matlab.ui.control.NumericEditField
        JokersEditFieldLabel  matlab.ui.control.Label
        JokersEditField       matlab.ui.control.NumericEditField
        PlayButton            matlab.ui.control.Button
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % default is 1 Deck
            app.DecksEditField.Value = 1
        end

        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
            % setting global variables decks and jokers
            % assigning their values from input argument
            % running the game
            
            global decks
                decks = app.DecksEditField.Value
            global jokers
                jokers = app.JokersEditField.Value
            run("Gamemode1_exported.m")
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 250 192];
            app.UIFigure.Name = 'UI Figure';

            % Create DecksEditFieldLabel
            app.DecksEditFieldLabel = uilabel(app.UIFigure);
            app.DecksEditFieldLabel.HorizontalAlignment = 'right';
            app.DecksEditFieldLabel.Position = [48 126 39 22];
            app.DecksEditFieldLabel.Text = 'Decks';

            % Create DecksEditField
            app.DecksEditField = uieditfield(app.UIFigure, 'numeric');
            app.DecksEditField.Position = [102 126 100 22];

            % Create JokersEditFieldLabel
            app.JokersEditFieldLabel = uilabel(app.UIFigure);
            app.JokersEditFieldLabel.HorizontalAlignment = 'right';
            app.JokersEditFieldLabel.Position = [46 86 41 22];
            app.JokersEditFieldLabel.Text = 'Jokers';

            % Create JokersEditField
            app.JokersEditField = uieditfield(app.UIFigure, 'numeric');
            app.JokersEditField.Position = [102 86 100 22];

            % Create PlayButton
            app.PlayButton = uibutton(app.UIFigure, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.Position = [74 36 100 22];
            app.PlayButton.Text = 'Play';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = gameSettings_exported

            % Create UIFigure and components
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
