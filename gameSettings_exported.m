classdef gameSettings_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                 matlab.ui.Figure
        DecksEditFieldLabel      matlab.ui.control.Label
        DecksEditField           matlab.ui.control.NumericEditField
        JokersEditFieldLabel     matlab.ui.control.Label
        JokersEditField          matlab.ui.control.NumericEditField
        PlayButton               matlab.ui.control.Button
        cardDecksEditFieldLabel  matlab.ui.control.Label
        cardDecksEditField       matlab.ui.control.NumericEditField
        BlackjackButton          matlab.ui.control.Button
        StratJackButton          matlab.ui.control.Button
        SmartJackButton          matlab.ui.control.Button
        JokerJackButton          matlab.ui.control.Button
        HardCheckBox             matlab.ui.control.CheckBox
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
            % default is 1 Deck
            % default is 1 cardDeck
            % default is 1 Joker
            % set AIdifficulty as a global variable
            % assign AIdifficulty to 0 (normal)
            app.DecksEditField.Value = 1
            app.cardDecksEditField.Value = 1
            app.JokersEditField.Value = 1
            global AIdifficulty
                AIdifficulty = 0
            
            % hide all buttons except gamemodes 
            app.DecksEditFieldLabel.Visible = 'off'
            app.DecksEditField.Visible = 'off'
            
            app.cardDecksEditFieldLabel.Visible = 'off'
            app.cardDecksEditField.Visible = 'off'
            
            app.HardCheckBox.Visible = 'off'
            
            app.JokersEditFieldLabel.Visible = 'off'
            app.JokersEditField.Visible = 'off'
            
            app.PlayButton.Visible = 'off'   
            
        end

        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
            % start the game
            
            % setting global variables decks and jokers
            % assigning their values from input argument
            % running the game
            global cardDecks
                cardDecks = app.cardDecksEditField.Value
            global decks
                decks = app.DecksEditField.Value
            global jokers
                jokers = app.JokersEditField.Value
            global AIdifficulty 
                if app.HardCheckBox.Value == 1
                    AIdifficulty = 1
                else 
                    AIdifficulty = 0
                end
            global gameMode          
           
            % depending on global variable gameMode
            % run respected .m file
            switch gameMode
                case 1
                    run("Gamemode1_exported.m")
                case 2 
                    run("Gamemode2_exported.m")
                case 3
                    %%% run("Gamemode3_exported.m")
                case 4 
                    %%% run("Gamemode4_exported.m")
            end
            
        end

        % Button pushed function: BlackjackButton
        function BlackjackButtonPushed(app, event)
            % Chooses Gamemode1 and allows inputs
            % uses global variable gameMode to memorize gamemode
            global gameMode
                gameMode = 1
                
            % hide all gamemode buttons
            app.BlackjackButton.Visible = 'off'
            app.StratJackButton.Visible = 'off'
            app.SmartJackButton.Visible = 'off'
            app.JokerJackButton.Visible = 'off'
            
            % make the necessary inputs visible
            app.DecksEditFieldLabel.Visible = 'on'
            app.DecksEditField.Visible = 'on'

            % make play visible
            app.PlayButton.Visible = 'on'
            
        end

        % Button pushed function: StratJackButton
        function StratJackButtonPushed(app, event)
            % Chooses Gamemode2 and allows inputs
            % uses global variable gameMode to memorize gamemode
            global gameMode
                gameMode = 2
            
            % hide all gamemode buttons
            app.BlackjackButton.Visible = 'off'
            app.StratJackButton.Visible = 'off'
            app.SmartJackButton.Visible = 'off'
            app.JokerJackButton.Visible = 'off'
            
            % make the necessary inputs visible
            app.DecksEditFieldLabel.Visible = 'on'
            app.DecksEditField.Visible = 'on'
            app.cardDecksEditFieldLabel.Visible = 'on'
            app.cardDecksEditField.Visible = 'on'
            
            % make play visible
            app.PlayButton.Visible = 'on'
        end

        % Button pushed function: SmartJackButton
        function SmartJackButtonPushed(app, event)
            % Chooses Gamemode3 and allows inputs
            % uses global variable gameMode to memorize gamemode
            global gameMode
                gameMode = 3
            
            % hide all gamemode buttons
            app.BlackjackButton.Visible = 'off'
            app.StratJackButton.Visible = 'off'
            app.SmartJackButton.Visible = 'off'
            app.JokerJackButton.Visible = 'off'
            
            % make the necessary inputs visible
            app.DecksEditFieldLabel.Visible = 'on'
            app.DecksEditField.Visible = 'on'
            app.cardDecksEditFieldLabel.Visible = 'on'
            app.cardDecksEditField.Visible = 'on'
            app.HardCheckBox.Visible = 'on'
            
            % make play visible
            app.PlayButton.Visible = 'on'
        end

        % Button pushed function: JokerJackButton
        function JokerJackButtonPushed(app, event)
            % Chooses Gamemode4 and allows inputs
            % uses global variable gameMode to memorize gamemode
            global gameMode
                gameMode = 4
            
            % hide all gamemode buttons
            app.BlackjackButton.Visible = 'off'
            app.StratJackButton.Visible = 'off'
            app.SmartJackButton.Visible = 'off'
            app.JokerJackButton.Visible = 'off'
            
            % make the necessary inputs visible
            app.DecksEditFieldLabel.Visible = 'on'
            app.DecksEditField.Visible = 'on'
            app.cardDecksEditFieldLabel.Visible = 'on'
            app.cardDecksEditField.Visible = 'on'
            app.HardCheckBox.Visible = 'on'
            app.JokersEditFieldLabel.Visible = 'on'
            app.JokersEditField.Visible = 'on'
            
            % make play visible
            app.PlayButton.Visible = 'on'
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 457 295];
            app.UIFigure.Name = 'UI Figure';

            % Create DecksEditFieldLabel
            app.DecksEditFieldLabel = uilabel(app.UIFigure);
            app.DecksEditFieldLabel.HorizontalAlignment = 'right';
            app.DecksEditFieldLabel.Position = [143 237 39 22];
            app.DecksEditFieldLabel.Text = 'Decks';

            % Create DecksEditField
            app.DecksEditField = uieditfield(app.UIFigure, 'numeric');
            app.DecksEditField.Position = [197 237 100 22];

            % Create JokersEditFieldLabel
            app.JokersEditFieldLabel = uilabel(app.UIFigure);
            app.JokersEditFieldLabel.HorizontalAlignment = 'right';
            app.JokersEditFieldLabel.Position = [131 71 41 22];
            app.JokersEditFieldLabel.Text = 'Jokers';

            % Create JokersEditField
            app.JokersEditField = uieditfield(app.UIFigure, 'numeric');
            app.JokersEditField.Position = [187 71 100 22];

            % Create PlayButton
            app.PlayButton = uibutton(app.UIFigure, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.Position = [170 25 100 22];
            app.PlayButton.Text = 'Play';

            % Create cardDecksEditFieldLabel
            app.cardDecksEditFieldLabel = uilabel(app.UIFigure);
            app.cardDecksEditFieldLabel.HorizontalAlignment = 'right';
            app.cardDecksEditFieldLabel.Position = [120 184 62 22];
            app.cardDecksEditFieldLabel.Text = 'cardDecks';

            % Create cardDecksEditField
            app.cardDecksEditField = uieditfield(app.UIFigure, 'numeric');
            app.cardDecksEditField.Position = [197 184 100 22];

            % Create BlackjackButton
            app.BlackjackButton = uibutton(app.UIFigure, 'push');
            app.BlackjackButton.ButtonPushedFcn = createCallbackFcn(app, @BlackjackButtonPushed, true);
            app.BlackjackButton.Position = [171 237 100 22];
            app.BlackjackButton.Text = 'Blackjack';

            % Create StratJackButton
            app.StratJackButton = uibutton(app.UIFigure, 'push');
            app.StratJackButton.ButtonPushedFcn = createCallbackFcn(app, @StratJackButtonPushed, true);
            app.StratJackButton.Position = [171 184 100 22];
            app.StratJackButton.Text = 'StratJack';

            % Create SmartJackButton
            app.SmartJackButton = uibutton(app.UIFigure, 'push');
            app.SmartJackButton.ButtonPushedFcn = createCallbackFcn(app, @SmartJackButtonPushed, true);
            app.SmartJackButton.Position = [171 129 100 22];
            app.SmartJackButton.Text = 'SmartJack';

            % Create JokerJackButton
            app.JokerJackButton = uibutton(app.UIFigure, 'push');
            app.JokerJackButton.ButtonPushedFcn = createCallbackFcn(app, @JokerJackButtonPushed, true);
            app.JokerJackButton.Position = [171 71 100 22];
            app.JokerJackButton.Text = 'JokerJack';

            % Create HardCheckBox
            app.HardCheckBox = uicheckbox(app.UIFigure);
            app.HardCheckBox.Text = 'Hard';
            app.HardCheckBox.Position = [197 129 48 22];

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