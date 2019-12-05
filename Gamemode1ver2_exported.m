classdef Gamemode1ver2_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
        Image                 matlab.ui.control.Image
        cardDeck1Image        matlab.ui.control.Image
        HandImage1            matlab.ui.control.Image
        HandImage2            matlab.ui.control.Image
        HandImage3            matlab.ui.control.Image
        HandImage4            matlab.ui.control.Image
        HandImage5            matlab.ui.control.Image
        StartButton           matlab.ui.control.Button
        Hit1Button            matlab.ui.control.Button
        StandButton           matlab.ui.control.Button
        CompHandImage1        matlab.ui.control.Image
        CompHandImage2        matlab.ui.control.Image
        CompHandImage3        matlab.ui.control.Image
        CompHandImage4        matlab.ui.control.Image
        CompHandImage5        matlab.ui.control.Image
        HandDisplayLabel      matlab.ui.control.Label
        CompHandDisplayLabel  matlab.ui.control.Label
        BalanceLabel          matlab.ui.control.Label
        BetEditFieldLabel     matlab.ui.control.Label
        BetEditField          matlab.ui.control.NumericEditField
    end

    
    properties (Access = private)
        % properties used to store values and objects within app
        
        % cardDeck1Memory = object with class deck
        % Human = object with class player
        % Dealer = object with class player
        % Balance = stored double value
        % Wager = stored double value
        cardDeck1Memory
        Human
        Dealer
        Balance
        TempBalance
        Bet
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % startup is when player clicks play             
            
            % setting akk DeckImages to cardback.jpg
            %% this should be a function which assigns all .jpg
            app.cardDeck1Image.ImageSource = imread('cardback.jpg');
            % set other Images
            app.HandImage1.Visible = 'off';
            app.HandImage2.Visible = 'off';
            app.HandImage3.Visible = 'off';
            app.HandImage4.Visible = 'off';
            app.HandImage5.Visible = 'off';
            app.CompHandImage1.Visible = 'off';
            app.CompHandImage2.Visible = 'off';
            app.CompHandImage3.Visible = 'off';
            app.CompHandImage4.Visible = 'off';
            app.CompHandImage5.Visible = 'off';
            % setting decks as global variables
            global decks  
                                             
            % assigning object cardDeck1 with class deck and amount of decks
            cardDeck1 = deck(decks);
            
            % shuffling the amount of decks we put in
            cardDeck1.shuffleDeck;
                                    
            % setting displays as string(sum of hands)
            app.HandDisplayLabel.Text = "Your Hand: " + "0";
            app.CompHandDisplayLabel.Text = "Dealer's Hand";
            
            % assigning app.Balance to 5000 
            % assigning app.Bet to 0
            % setting displays with respected values
            % hide BetEditField until you click start
            app.Balance = 5000
            app.BalanceLabel.Text = "Balance: " + string(app.Balance)
            app.Bet = 0
            app.BetEditField.Value = app.Bet
            app.BetEditField.Visible = 'on'
            
            % hide all buttons besides start 
            app.StandButton.Visible = 'off'
            app.Hit1Button.Visible = 'off'
            
            % storing object cardDeck1 within the app
            app.cardDeck1Memory = cardDeck1;
            
        end

        % Button pushed function: StartButton
        function StartButtonPushed(app, event)
            % assigning the Dealer and Human their hands to start the round
            if app.BetEditField.Value==0
                msgbox('please enter a valid bet','you cheapskate!')
                app.UIFigure.Visible = 'off';
                Gamemode1();
                close(app.UIFigure)
            end
            % assigning local object cardDeck1 with the stored app value
            % clearing table of cards from prebious round
            cardDeck1 = app.cardDeck1Memory;
            cardDeck1.clearTable;
            app.HandImage1.Visible = 'off';
            app.HandImage2.Visible = 'off';
            app.HandImage3.Visible = 'off';
            app.HandImage4.Visible = 'off';
            app.HandImage5.Visible = 'off';
            app.CompHandImage1.Visible = 'off';
            app.CompHandImage2.Visible = 'off';
            app.CompHandImage3.Visible = 'off';
            app.CompHandImage4.Visible = 'off';
            app.CompHandImage5.Visible = 'off';
            
            % if respected deck is less then 4
            % reshuffle discard pile into deck
            % logical will equal an array of zeros unless < 4 cards left
            % if .cards < 4 then an element would = 1
            % if an element equals 1 then reshuffleDiscard will run
            %% this should be changed to be better
            logical =  ( size(cardDeck1.cards) < 4 );
            if sum(logical) == 2
                cardDeck1.reshuffleDiscard
            end
            
            % dealing two cards to the player1(Human) and AI(Dealer)
            player1 = player(cardDeck1);
            AI = player(cardDeck1);
            
            app.HandImage1.ImageSource = player1.hand(1).image;
            app.HandImage2.ImageSource = player1.hand(2).image;
            app.HandImage1.Visible = 1;
            app.HandImage2.Visible = 1;
                        
            [y, Fs] = audioread('flip.mp3');
            sound(y,Fs)
            % calculate hand values for player1
            % calculate hand values for AI
            player1.calcHandValue;
            AI.calcHandValue;
            
            app.CompHandImage1.ImageSource = AI.hand(1).image;
            app.CompHandImage2.ImageSource = imread('cardback.jpg');
            app.CompHandImage1.Visible = 1;
            app.CompHandImage2.Visible = 1;
                                                           
            % display sum of players' hand values
            app.HandDisplayLabel.Text = string(player1.handValue)
            
            
            % after you click start you can now bet 
            % set app.TempBalance = app.Balance
            app.BetEditField.Visible = 'on';
            app.TempBalance = app.Balance
            
            % if deck is empty then reshuffle 
            % logical will equal an array of zeros unless .cards = 0
            % if .cards = 0 then an element will equal 1
            % if an element equals 1 then reshuffleDiscard will run
            logical =  ( size(cardDeck1.cards) == 0 );
            if sum(logical) == 1
                cardDeck1.reshuffleDiscard
            end
            
            % display objects in Command Window
            cardDeck1
            player1
            AI
                                              
            % make buttons visible if being used
            %%% app.StartButton.Visible = 'off'
            app.StandButton.Visible = 'on'
            app.Hit1Button.Visible = 'on'
            
            % storing objects within the app
            app.cardDeck1Memory = cardDeck1
            app.Human = player1;
            app.Dealer = AI;
            
        end

        % Button pushed function: Hit1Button
        function Hit1ButtonPushed(app, event)
            % drawing a card from respected deck
            % cardDeck1
            [y, Fs] = audioread('flip.mp3');
            sound(y,Fs)
            % assigning local objects with stored app values
            cardDeck1 = app.cardDeck1Memory;
            player1 = app.Human;
            
            % lower tempBalance by the input of BetEditField
            % display TempBalance
            % after everything is done, set BetEditField to 0
            app.Bet = app.BetEditField.Value
            app.TempBalance = app.TempBalance - app.Bet
            app.BalanceLabel.Text = "Balance: " + string(app.TempBalance)
            app.BetEditField.Value = 0
                     
            % using function hit to draw a card from the respected deck
            % calculating player1's hand value
            player1.hit(cardDeck1);
            player1.calcHandValue;
            switch length(player1.hand)
                case 3
                    app.HandImage3.ImageSource = player1.hand(3).image;
                    app.HandImage3.Visible = 1;
                case 4
                    app.HandImage4.ImageSource = player1.hand(4).image;
                    app.HandImage4.Visible = 1;
                case 5
                    app.HandImage5.ImageSource = player1.hand(5).image;
                    app.HandImage5.Visible = 1;
                    app.Hit1Button.Visible = 'off';
            end
            
            % if deck is empty then reshuffle 
            % logical will equal an array of zeros unless .cards = 0
            % if .cards = 0 then an element will equal 1
            % if an element equals 1 then reshuffleDiscard will run
            logical =  ( size(cardDeck1.cards) == 0 );
            if sum(logical) == 1
                cardDeck1.reshuffleDiscard
            end
                        
            % display sum of Human's hand values
            app.HandDisplayLabel.Text = string(player1.handValue);
            
            % display objects in the Command Window
            cardDeck1
            player1
                        
            % condition statement to determine if handValue is too high
            % if too high, you lose
            % Balance is lost
            % if handValues are too high, hide all buttons besides start
            %% this should be a function called from script 
            if player1.handValue > 21
                
                msgbox('Tough Luck, You Lose')
                [y, Fs] = audioread('defeat.mp3');
                sound(y, Fs)
                app.Balance = app.TempBalance
                app.BalanceLabel.Text = "Balance: " + string(app.Balance)
                
                app.StandButton.Visible = 'off'
                app.Hit1Button.Visible = 'off'
                app.StartButton.Visible = 'on'
                
            end
            
            % storing local objects within the app
            app.cardDeck1Memory = cardDeck1;
            app.Human = player1;
            
        end

        % Button pushed function: StandButton
        function StandButtonPushed(app, event)
            % keep current value of hand 
            % AI starts trying to beat you
            
            % hide all buttons during AI's turn
            app.StandButton.Visible = 'off'
            app.StandButton.Visible = 'off'
            app.Hit1Button.Visible = 'off'
            
            % assigning local objects with stored app values
            cardDeck1 = app.cardDeck1Memory;
            AI = app.Dealer;
            player1 = app.Human;
            
            app.CompHandImage2.ImageSource = AI.hand(2).image;
            pause(1);
                        
            % loop that makes the Dealer play the game til it gets >= 17
            while AI.handValue < 17
                
                % using function hit to draw a card from the respected deck
                % calculating AI's hand value
                AI.hit(cardDeck1);
                AI.calcHandValue;
                
                switch length(AI.hand)
                case 3
                    app.CompHandImage3.ImageSource = AI.hand(3).image;
                    app.CompHandImage3.Visible = 1;
                case 4
                    app.CompHandImage4.ImageSource = AI.hand(4).image;
                    app.CompHandImage4.Visible = 1;
                case 5
                    app.CompHandImage5.ImageSource = AI.hand(5).image;
                    app.CompHandImage5.Visible = 1;
            end
                
                % if deck is empty then reshuffle
                % logical will equal an array of zeros unless .cards = 0
                % if .cards = 0 then an element will equal 1
                % if an element equals 1 then reshuffleDiscard will run
                logical =  ( size(cardDeck1.cards) == 0 );
                if sum(logical) == 1
                    cardDeck1.reshuffleDiscard
                end
                
                % display sum of Dealer's hand values
                % pause the loop for 1 second
                app.CompHandDisplayLabel.Text = string(AI.handValue);
                pause(1);
                
            end
            
            % Display objects in the Command Window 
            cardDeck1
            player1
            AI
            
            % when AI is done, make start button visible
            app.StartButton.Visible = 'on'
                        
            % determine a winner of the round using conditional statement
            if AI.handValue > 21
                msgbox('Winner Winner Chicken Dinner')
                app.Balance = app.Balance + (app.Balance - app.TempBalance)
                app.BalanceLabel.Text = "Balance: " + string(app.Balance)
                app.Hit1Button.Visible = 'off';
                [y, Fs] = audioread('victory.wav');
                sound(y, Fs)
            elseif player1.handValue > AI.handValue
                msgbox('Winner Winner Chicken Dinner')
                app.Balance = app.Balance + (app.Balance - app.TempBalance)
                app.BalanceLabel.Text = "Balance: " + string(app.Balance)
                app.Hit1Button.Visible = 'off';
                [y, Fs] = audioread('victory.wav');
                sound(y, Fs)
            elseif player1.handValue < AI.handValue
                msgbox('Tough Luck, You Lose')
                app.Balance = app.TempBalance
                app.BalanceLabel.Text = "Balance: " + string(app.Balance)
                app.Hit1Button.Visible = 'off';
                [y, Fs] = audioread('defeat.mp3');
                sound(y, Fs)
            elseif player1.handValue == AI.handValue
                msgbox('Draw')
                app.BalanceLabel.Text = "Balance: " + string(app.Balance)
                app.Hit1Button.Visible = 'off';
                [y, Fs] = audioread('defeat.mp3');
                sound(y, Fs)
            end
            
            % storing local objects within the app
            % hide BetEditField until StartButton is pushed
            app.cardDeck1Memory = cardDeck1;
            app.Dealer = AI;
        
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'UI Figure';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [-82 -52 783 576];
            app.Image.ImageSource = 'background.jpg';

            % Create cardDeck1Image
            app.cardDeck1Image = uiimage(app.UIFigure);
            app.cardDeck1Image.Position = [80 349 100 100];

            % Create HandImage1
            app.HandImage1 = uiimage(app.UIFigure);
            app.HandImage1.Position = [24 174 71 76];

            % Create HandImage2
            app.HandImage2 = uiimage(app.UIFigure);
            app.HandImage2.Position = [107 174 73 76];

            % Create HandImage3
            app.HandImage3 = uiimage(app.UIFigure);
            app.HandImage3.Position = [193 174 79 76];

            % Create HandImage4
            app.HandImage4 = uiimage(app.UIFigure);
            app.HandImage4.Position = [59 99 83 76];

            % Create HandImage5
            app.HandImage5 = uiimage(app.UIFigure);
            app.HandImage5.Position = [152 99 85 76];

            % Create StartButton
            app.StartButton = uibutton(app.UIFigure, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartButtonPushed, true);
            app.StartButton.Position = [465 33 100 22];
            app.StartButton.Text = 'Start';

            % Create Hit1Button
            app.Hit1Button = uibutton(app.UIFigure, 'push');
            app.Hit1Button.ButtonPushedFcn = createCallbackFcn(app, @Hit1ButtonPushed, true);
            app.Hit1Button.Position = [79 315 100 22];
            app.Hit1Button.Text = 'Hit1';

            % Create StandButton
            app.StandButton = uibutton(app.UIFigure, 'push');
            app.StandButton.ButtonPushedFcn = createCallbackFcn(app, @StandButtonPushed, true);
            app.StandButton.Position = [79 33 100 22];
            app.StandButton.Text = 'Stand';

            % Create CompHandImage1
            app.CompHandImage1 = uiimage(app.UIFigure);
            app.CompHandImage1.Position = [348 174 76 76];

            % Create CompHandImage2
            app.CompHandImage2 = uiimage(app.UIFigure);
            app.CompHandImage2.Position = [431 174 78 76];

            % Create CompHandImage3
            app.CompHandImage3 = uiimage(app.UIFigure);
            app.CompHandImage3.Position = [508 174 88 76];

            % Create CompHandImage4
            app.CompHandImage4 = uiimage(app.UIFigure);
            app.CompHandImage4.Position = [381 99 85 76];

            % Create CompHandImage5
            app.CompHandImage5 = uiimage(app.UIFigure);
            app.CompHandImage5.Position = [473 99 92 76];

            % Create HandDisplayLabel
            app.HandDisplayLabel = uilabel(app.UIFigure);
            app.HandDisplayLabel.Position = [107 258 74 22];
            app.HandDisplayLabel.Text = 'HandDisplay';

            % Create CompHandDisplayLabel
            app.CompHandDisplayLabel = uilabel(app.UIFigure);
            app.CompHandDisplayLabel.Position = [417 258 106 22];
            app.CompHandDisplayLabel.Text = 'CompHandDisplay';

            % Create BalanceLabel
            app.BalanceLabel = uilabel(app.UIFigure);
            app.BalanceLabel.Position = [258 63 125 22];
            app.BalanceLabel.Text = 'Balance';

            % Create BetEditFieldLabel
            app.BetEditFieldLabel = uilabel(app.UIFigure);
            app.BetEditFieldLabel.HorizontalAlignment = 'right';
            app.BetEditFieldLabel.Position = [272 33 25 22];
            app.BetEditFieldLabel.Text = 'Bet';

            % Create BetEditField
            app.BetEditField = uieditfield(app.UIFigure, 'numeric');
            app.BetEditField.Position = [312 33 68 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Gamemode1ver2_exported

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