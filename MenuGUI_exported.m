classdef MenuGUI_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure       matlab.ui.Figure
        PlayButton     matlab.ui.control.Button
        ExitButton     matlab.ui.control.Button
        OptionsButton  matlab.ui.control.Button
        Image          matlab.ui.control.Image
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
            run("gameSettings_exported.m")
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 396 217];
            app.UIFigure.Name = 'UI Figure';

            % Create PlayButton
            app.PlayButton = uibutton(app.UIFigure, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.Position = [25 34 100 22];
            app.PlayButton.Text = 'Play';

            % Create ExitButton
            app.ExitButton = uibutton(app.UIFigure, 'push');
            app.ExitButton.Position = [272 34 100 22];
            app.ExitButton.Text = 'Exit';

            % Create OptionsButton
            app.OptionsButton = uibutton(app.UIFigure, 'push');
            app.OptionsButton.Position = [151 34 100 22];
            app.OptionsButton.Text = 'Options';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [149 93 100 100];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = MenuGUI_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

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