classdef FinalGui_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure         matlab.ui.Figure
        StandButton      matlab.ui.control.Button
        Hit1Button       matlab.ui.control.Button
        Hit2Button       matlab.ui.control.Button
        Hit3Button       matlab.ui.control.Button
        StartButton      matlab.ui.control.Button
        Deck1Image       matlab.ui.control.Image
        Deck2Image       matlab.ui.control.Image
        Deck3Image       matlab.ui.control.Image
        HandImage1       matlab.ui.control.Image
        HandImage2       matlab.ui.control.Image
        HandImage3       matlab.ui.control.Image
        HandImage4       matlab.ui.control.Image
        HandImage5       matlab.ui.control.Image
        CompHandImage1   matlab.ui.control.Image
        CompHandImage2   matlab.ui.control.Image
        CompHandImage3   matlab.ui.control.Image
        CompHandImage4   matlab.ui.control.Image
        CompHandImage5   matlab.ui.control.Image
        HandDisplay      matlab.ui.control.Label
        CompHandDisplay  matlab.ui.control.Label
    end

    
    properties (Access = private)
        % properties used to store values and objects within app
        
        % DeckMemory = object with class deck
        % Human = object with class player
        % Computer = object with class player
        DeckMemory
        Human
        Computer
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % startup is when player clicks play             
            
            % setting akk DeckImages to cardback.jpg
            %% this should be a function which assigns all .jpg
            app.Deck1Image.ImageSource = imread('cardback.jpg');
            app.Deck2Image.ImageSource = imread('cardback.jpg');
            app.Deck3Image.ImageSource = imread('cardback.jpg');
            
            % set other Images
            
            % setting decks and jokers as global variables
            global decks
            global jokers
                        
            % hide all DeckImages not being used
            switch decks
                case 1 % decks = 1
                    app.Deck2Image.Visible = 'off';
                    app.Deck3Image.Visible = 'off';
                case 2 % decks = 2
                    app.Deck3Image.Visible = 'off';   
            end
                                   
            % hide all buttons besides start 
            app.StandButton.Visible = 'off'
            app.Hit1Button.Visible = 'off'
            app.Hit2Button.Visible = 'off'
            app.Hit3Button.Visible = 'off'
            
            % assigning object cardDeck with class deck and amount of decks
            cardDeck = deck(decks);
                                                
            % shuffling the amount of decks we put in
            % shuffleDeck(cardDeck);
            
            % storing object cardDeck within the app
            app.DeckMemory = cardDeck;
            
            % add joker function here
            %
            
            % setting displays as string(sum of hands)
            app.HandDisplay.Text = "0";
            app.CompHandDisplay.Text = "0";
            
        end

        % Button pushed function: StartButton
        function StartButtonPushed(app, event)
            % assigning the Computer and Human their hands to start the round
            
            % assigning local object cardDeck with the stored app value
            % clearing table of cards from prebious round
            cardDeck = app.DeckMemory
            clearTable(cardDeck)
            
            % dealing two cards to the player1(Human) and AI(Computer)
            player1 = player(cardDeck)
            AI = player(cardDeck)
                        
            % calculate hand values for player1
            % calculate hand values for AI
            player1.calcHandValue;
            AI.calcHandValue;
                        
            % display sum of players' hand values
            app.HandDisplay.Text = string(player1.handValue)
            app.CompHandDisplay.Text = string(AI.handValue)
            
            % storing objects within the app
            app.DeckMemory = cardDeck;
            app.Human = player1;
            app.Computer = AI;
            
            % setting decks as a global variabe
            global decks
            
            % make buttons visible if being used
            app.StandButton.Visible = 'on'
            switch decks
                case 1 % decks = 1 
                    app.Hit1Button.Visible = 'on'
                case 2 % decks = 2
                    app.Hit1Button.Visible = 'on'
                    app.Hit2Button.Visible = 'on'
                case 3 % decks = 3
                    app.Hit1Button.Visible = 'on'
                    app.Hit2Button.Visible = 'on'
                    app.Hit3Button.Visible = 'on'
            end
 
        end

        % Button pushed function: Hit1Button
        function Hit1ButtonPushed(app, event)
            % drawing a card from respected deck
            
            % assigning local objects with stored app values
            cardDeck = app.DeckMemory;
            player1 = app.Human;
            
            % using function hit to draw a card from the respected deck
            % calculating player1's hand value
            player1.hit(cardDeck);
            player1.calcHandValue;
                        
            % display sum of Human's hand values
            app.HandDisplay.Text = string(player1.handValue);
            
            % storing local objects within the app
            app.DeckMemory = cardDeck;
            app.Human = player1;
            
            % condition statement to determine if handValue is too high
            % if handValues are too high, hide all buttons besides start
            %% this should be a function called from script 
            if player1.handValue > 21
                msgbox('Tough Luck, You Loose')
                app.StandButton.Visible = 'off'
                app.Hit1Button.Visible = 'off'
                app.Hit2Button.Visible = 'off'
                app.Hit3Button.Visible = 'off'
            end
        end

        % Button pushed function: StandButton
        function StandButtonPushed(app, event)
            % keep current value of hand 
            % AI starts trying to beat you
            
            % hide all buttons during AI's turn
            app.StandButton.Visible = 'off'
            app.StandButton.Visible = 'off'
            app.Hit1Button.Visible = 'off'
            app.Hit2Button.Visible = 'off'
            app.Hit3Button.Visible = 'off'
            
            % assigning local objects with stored app values
            cardDeck = app.DeckMemory;
            AI = app.Computer;
            player1 = app.Human;
            
            % loop that makes the Computer play the game til it gets >= 17
            while AI.handValue < 17
                
                % using function hit to draw a card from the respected deck
                % calculating AI's hand value
                AI.hit(cardDeck);
                AI.calcHandValue;
                
                % display sum of Computer's hand values
                % pause the loop for 1 second
                app.CompHandDisplay.Text = string(AI.handValue);
                pause(1);
                
            end
            
            % when AI is done, make start button visible
            app.StartButton.Visible = 'on'
                        
            % storing local objects within the app
            app.DeckMemory = cardDeck;
            app.Computer = AI;
            
            % determine a winner of the round using conditional statement
            if AI.handValue > 21
                msgbox('Winner Winner Chicken Dinner')
            elseif player1.handValue > AI.handValue
                msgbox('Winner Winner Chicken Dinner')
            elseif player1.handValue < AI.handValue
                msgbox('Tough Luck, You Lose')
            else % player1.handValue = AI.handValue
                msgbox('Draw')
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 514 394];
            app.UIFigure.Name = 'UI Figure';

            % Create StandButton
            app.StandButton = uibutton(app.UIFigure, 'push');
            app.StandButton.ButtonPushedFcn = createCallbackFcn(app, @StandButtonPushed, true);
            app.StandButton.Position = [50 22 100 22];
            app.StandButton.Text = 'Stand';

            % Create Hit1Button
            app.Hit1Button = uibutton(app.UIFigure, 'push');
            app.Hit1Button.ButtonPushedFcn = createCallbackFcn(app, @Hit1ButtonPushed, true);
            app.Hit1Button.Position = [50 251 100 22];
            app.Hit1Button.Text = 'Hit 1';

            % Create Hit2Button
            app.Hit2Button = uibutton(app.UIFigure, 'push');
            app.Hit2Button.Position = [207 251 100 22];
            app.Hit2Button.Text = 'Hit 2';

            % Create Hit3Button
            app.Hit3Button = uibutton(app.UIFigure, 'push');
            app.Hit3Button.Position = [366 251 100 22];
            app.Hit3Button.Text = 'Hit 3';

            % Create StartButton
            app.StartButton = uibutton(app.UIFigure, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartButtonPushed, true);
            app.StartButton.Position = [366 22 100 22];
            app.StartButton.Text = 'Start';

            % Create Deck1Image
            app.Deck1Image = uiimage(app.UIFigure);
            app.Deck1Image.Position = [50 282 100 100];

            % Create Deck2Image
            app.Deck2Image = uiimage(app.UIFigure);
            app.Deck2Image.Position = [207 282 100 100];

            % Create Deck3Image
            app.Deck3Image = uiimage(app.UIFigure);
            app.Deck3Image.Position = [366 282 100 100];

            % Create HandImage1
            app.HandImage1 = uiimage(app.UIFigure);
            app.HandImage1.Position = [23 115 53 51];

            % Create HandImage2
            app.HandImage2 = uiimage(app.UIFigure);
            app.HandImage2.Position = [75 115 63 51];

            % Create HandImage3
            app.HandImage3 = uiimage(app.UIFigure);
            app.HandImage3.Position = [129 115 65 51];

            % Create HandImage4
            app.HandImage4 = uiimage(app.UIFigure);
            app.HandImage4.Position = [50 62 67 51];

            % Create HandImage5
            app.HandImage5 = uiimage(app.UIFigure);
            app.HandImage5.Position = [101 63 74 51];

            % Create CompHandImage1
            app.CompHandImage1 = uiimage(app.UIFigure);
            app.CompHandImage1.Position = [330 115 59 51];

            % Create CompHandImage2
            app.CompHandImage2 = uiimage(app.UIFigure);
            app.CompHandImage2.Position = [388 114 56 52];

            % Create CompHandImage3
            app.CompHandImage3 = uiimage(app.UIFigure);
            app.CompHandImage3.Position = [443 114 64 52];

            % Create CompHandImage4
            app.CompHandImage4 = uiimage(app.UIFigure);
            app.CompHandImage4.Position = [358 63 58 52];

            % Create CompHandImage5
            app.CompHandImage5 = uiimage(app.UIFigure);
            app.CompHandImage5.Position = [415 63 53 53];

            % Create HandDisplay
            app.HandDisplay = uilabel(app.UIFigure);
            app.HandDisplay.Position = [89 176 35 22];

            % Create CompHandDisplay
            app.CompHandDisplay = uilabel(app.UIFigure);
            app.CompHandDisplay.Position = [395 176 42 22];
            app.CompHandDisplay.Text = 'Label2';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = FinalGui_exported

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
