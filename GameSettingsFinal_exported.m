classdef GameSettingsFinal_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        Image                         matlab.ui.control.Image
        PlayButton                    matlab.ui.control.Button
        vsAIHardCheckBox              matlab.ui.control.CheckBox
        vsAInormalCheckBox            matlab.ui.control.CheckBox
        HittingDeckEditFieldLabel     matlab.ui.control.Label
        HittingDeckEditField          matlab.ui.control.NumericEditField
        JokersEditFieldLabel          matlab.ui.control.Label
        JokersEditField               matlab.ui.control.NumericEditField
        DecksperHittingDeckEditFieldLabel  matlab.ui.control.Label
        DecksperHittingDeckEditField  matlab.ui.control.NumericEditField
        RulesButton                   matlab.ui.control.Button
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
            % start the game
            
            % setting global variables decks and jokers
            % assigning their values from input argument
            % you can have only up to 3 cardDecks
            % you can have infinate jokers and decks
            global cardDecks;
                cardDecks = app.HittingDeckEditField.Value;
            global decks;
                decks = app.DecksperHittingDeckEditField.Value;
            global jokers;
                jokers = app.JokersEditField.Value;
                
                % make sure cardDecks and decks are not zero
                if (cardDecks == 0) || (decks == 0)
                    msgbox('You must input a value for Hitting Decks and Decks per Hitting Deck')
                    return;
                end
                
                % limit cardDecks to max of 3
                if cardDecks > 3
                    msgbox('You can only have up to 3 Hitting Decks');
                    return;
                end
                
            % setting global variable AIdifficulty
            global AIdifficulty;
            
            % statement to determine the AI difficulty setting
            % if nothing is checked, AIdifficulty is not checked
            if (app.vsAIHardCheckBox.Value == 1) && (app.vsAInormalCheckBox.Value == 1)
                msgbox('You can only pick one AI difficulty');
                return;
            elseif app.vsAInormalCheckBox.Value == 1
                AIdifficulty = 0;
            elseif app.vsAIHardCheckBox.Value == 1
                AIdifficulty = 1;
            end
            
            % statement that determines which GUI to activate
            % if one of the check boxes are checked former runs
            if (AIdifficulty == 0) | (AIdifficulty == 1)
                run("ThreePlayerGamemode_exported.m");
            else % if neither are checked, latter runs
                run("TwoPlayerGamemode_exported.m");
            end
            
        end

        % Button pushed function: RulesButton
        function RulesButtonPushed(app, event)
            run("RulesFinal_exported.m")
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 359 285];
            app.UIFigure.Name = 'UI Figure';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [-88 -9 574 309];
            app.Image.ImageSource = 'background.jpg';

            % Create PlayButton
            app.PlayButton = uibutton(app.UIFigure, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.Position = [186 36 100 22];
            app.PlayButton.Text = 'Play';

            % Create vsAIHardCheckBox
            app.vsAIHardCheckBox = uicheckbox(app.UIFigure);
            app.vsAIHardCheckBox.Text = 'vs. AI Hard';
            app.vsAIHardCheckBox.Position = [210 132 82 22];

            % Create vsAInormalCheckBox
            app.vsAInormalCheckBox = uicheckbox(app.UIFigure);
            app.vsAInormalCheckBox.Text = 'vs. AI normal';
            app.vsAInormalCheckBox.Position = [101 132 92 22];

            % Create HittingDeckEditFieldLabel
            app.HittingDeckEditFieldLabel = uilabel(app.UIFigure);
            app.HittingDeckEditFieldLabel.HorizontalAlignment = 'right';
            app.HittingDeckEditFieldLabel.Position = [102 215 70 22];
            app.HittingDeckEditFieldLabel.Text = 'Hitting Deck';

            % Create HittingDeckEditField
            app.HittingDeckEditField = uieditfield(app.UIFigure, 'numeric');
            app.HittingDeckEditField.Position = [187 215 100 22];

            % Create JokersEditFieldLabel
            app.JokersEditFieldLabel = uilabel(app.UIFigure);
            app.JokersEditFieldLabel.HorizontalAlignment = 'right';
            app.JokersEditFieldLabel.Position = [130 92 41 22];
            app.JokersEditFieldLabel.Text = 'Jokers';

            % Create JokersEditField
            app.JokersEditField = uieditfield(app.UIFigure, 'numeric');
            app.JokersEditField.Position = [186 92 100 22];

            % Create DecksperHittingDeckEditFieldLabel
            app.DecksperHittingDeckEditFieldLabel = uilabel(app.UIFigure);
            app.DecksperHittingDeckEditFieldLabel.HorizontalAlignment = 'right';
            app.DecksperHittingDeckEditFieldLabel.Position = [44 175 128 22];
            app.DecksperHittingDeckEditFieldLabel.Text = 'Decks per Hitting Deck';

            % Create DecksperHittingDeckEditField
            app.DecksperHittingDeckEditField = uieditfield(app.UIFigure, 'numeric');
            app.DecksperHittingDeckEditField.Position = [187 175 100 22];

            % Create RulesButton
            app.RulesButton = uibutton(app.UIFigure, 'push');
            app.RulesButton.ButtonPushedFcn = createCallbackFcn(app, @RulesButtonPushed, true);
            app.RulesButton.Position = [73 36 100 22];
            app.RulesButton.Text = 'Rules';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = GameSettingsFinal_exported

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