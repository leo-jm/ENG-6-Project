classdef Gamemode2_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
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
        BetEditFieldLabel     matlab.ui.control.Label
        BetEditField          matlab.ui.control.NumericEditField
        BalanceLabel          matlab.ui.control.Label
        cardDeck2Image        matlab.ui.control.Image
        cardDeck3Image        matlab.ui.control.Image
        Hit2Button            matlab.ui.control.Button
        Hit3Button            matlab.ui.control.Button
    end

    
    properties (Access = private)
        % properties used to store values and objects within app
        
        % cardDeckMemory = object with class deck
        % Human = object with class player
        % Dealer = object with class player
        % Balance = stored double value
        % Wager = stored double value
        cardDeck1Memory
        cardDeck2Memory
        cardDeck3Memory
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
            % this should be a function which assigns all .jpg
            app.cardDeck1Image.ImageSource = imread('cardback.jpg');
            app.cardDeck2Image.ImageSource = imread('cardback.jpg');
            app.cardDeck3Image.ImageSource = imread('cardback.jpg');
            % set other Images
            
            % setting decks as a global variable
            % setting deckDraw as a global variable
            % assigning deckDraw value of 3
            global decks  
            global deckDraw 
            deckDraw = 3
                                             
            % assigning objects cardDeck with class deck and amount of decks
            cardDeck1 = deck(decks);
            cardDeck2 = deck(decks);
            cardDeck3 = deck(decks);
            
            % shuffling the amount of decks we put in
            %%% cardDeck1.shuffleDeck;
            %%% cardDeck2.shuffleDeck;
            %%% cardDeck3.shuffleDeck;
                                    
            % setting displays as string(sum of hands)
            app.HandDisplayLabel.Text = "Your Hand: " + "0";
            app.CompHandDisplayLabel.Text = "Dealer's Hand: " + "0";
            
            % assigning app.Balance to 5000 
            % assigning app.Bet to 0
            % setting displays with respected values
            % hide BetEditField until you click start
            app.Balance = 5000
            app.BalanceLabel.Text = "Balance: " + string(app.Balance)
            app.Bet = 0
            app.BetEditField.Value = app.Bet
            app.BetEditField.Visible = 'off'
            
            % hide all buttons besides start 
            app.StandButton.Visible = 'off'
            app.Hit1Button.Visible = 'off'
            app.Hit2Button.Visible = 'off'
            app.Hit3Button.Visible = 'off'
            
            % storing objects cardDeck within the app
            app.cardDeck1Memory = cardDeck1;
            app.cardDeck2Memory = cardDeck2;
            app.cardDeck3Memory = cardDeck3;
            
        end

        % Button pushed function: StartButton
        function StartButtonPushed(app, event)
            % assigning the Dealer and Human their hands to start the round
            
            % assigning local objects cardDeck with the stored app value
            % clearing table of cards from prebious round
            cardDeck1 = app.cardDeck1Memory;
            cardDeck1.clearTable;
            cardDeck2 = app.cardDeck2Memory;
            cardDeck2.clearTable;
            cardDeck3 = app.cardDeck3Memory;
            cardDeck3.clearTable;
            
            % if respected carddeck is less then 2
            % reshuffle discard pile into deck
            % logical will equal an array of zeros unless < 2 cards left
            % if .cards < 2 then an element would = 1
            % if an element equals 1 then reshuffleDiscard will run
            %% this should be changed to be better
            logical =  ( size(cardDeck1.cards) < 2 );
            if sum(logical) == 2
                cardDeck1.reshuffleDiscard
            end
            logical =  ( size(cardDeck2.cards) < 2 );
            if sum(logical) == 2
                cardDeck2.reshuffleDiscard
            end
            logical =  ( size(cardDeck3.cards) < 2 );
            if sum(logical) == 2
                cardDeck3.reshuffleDiscard
            end
            
            % dealing two cards to the player1(Human) and dealer(Dealer)
            % this is a reach feature because it deals from each ...
            % cardDeck consecutively
            % setting global variable Card as output
            % assinging needCard = 1 so player1 draws first
            global deckDraw
            needCard = 1
            
            % setting objects to class player
            player1 = player
            dealer = player
            
            for i = [1:4] % deal two cards to player1 and two to dealer
                % alternating which deck to draw from
                if deckDraw == 1
                    deckDraw = 2
                elseif deckDraw == 2
                    deckDraw = 3
                else
                    deckDraw = 1
                end
                
                switch needCard
                    case 1 % player1 draws
                        if deckDraw == 1 % draw from cardDeck1
                            player1.hit(cardDeck1)
                        elseif deckDraw == 2 % draw from cardDeck2
                            player1.hit(cardDeck2)
                        else % draw from cardDeck3
                            player1.hit(cardDeck3)
                        end
                        needCard = 2
                        
                    case 2 % dealer draws
                        if deckDraw == 1 % draw from cardDeck1
                            dealer.hit(cardDeck1)
                        elseif deckDraw == 2 % draw from cardDeck2
                            dealer.hit(cardDeck2)
                        else % draw from cardDeck3
                            dealer.hit(cardDeck3)
                        end
                        needCard = 1
                        
                end
            end
                                    
            % calculate hand values for player1
            % calculate hand values for dealer
            player1.calcHandValue;
            dealer.calcHandValue;
                                                           
            % display sum of players' hand values
            app.HandDisplayLabel.Text = string(player1.handValue)
            app.CompHandDisplayLabel.Text = string(dealer.handValue)
            
            % after you click start you can now bet 
            % set app.TempBalance = app.Balance
            app.BetEditField.Visible = 'on'
            app.TempBalance = app.Balance
            
            % if cardDeck is empty then reshuffle 
            % logical will equal an array of zeros unless .cards = 0
            % if .cards = 0 then an element will equal 1
            % if an element equals 1 then reshuffleDiscard will run
            logical =  ( size(cardDeck1.cards) == 0 );
            if sum(logical) == 1
                cardDeck1.reshuffleDiscard
            end
            logical =  ( size(cardDeck2.cards) == 0 );
            if sum(logical) == 1
                cardDeck2.reshuffleDiscard
            end
            logical =  ( size(cardDeck3.cards) == 0 );
            if sum(logical) == 1
                cardDeck3.reshuffleDiscard
            end
            
            % display objects in Command Window
            cardDeck1
            cardDeck2
            cardDeck3
            player1
            dealer
                                              
            % make buttons visible if being used
            %%% app.StartButton.Visible = 'off'
            app.StandButton.Visible = 'on'
            app.Hit1Button.Visible = 'on'
            app.Hit2Button.Visible = 'on'
            app.Hit3Button.Visible = 'on'
            
            % storing objects within the app
            app.cardDeck1Memory = cardDeck1
            app.cardDeck2Memory = cardDeck2
            app.cardDeck3Memory = cardDeck3
            app.Human = player1;
            app.Dealer = dealer;
            
        end

        % Button pushed function: Hit1Button
        function Hit1ButtonPushed(app, event)
            % drawing a card from respected deck
            % cardDeck1
            
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
                app.Balance = app.TempBalance
                app.BalanceLabel.Text = "Balance: " + string(app.Balance)
                
                app.StandButton.Visible = 'off'
                app.Hit1Button.Visible = 'off'
                app.Hit2Button.Visible = 'off'
                app.Hit3Button.Visible = 'off'
                app.StartButton.Visible = 'on'
                
            end
            
            % storing local objects within the app
            app.cardDeck1Memory = cardDeck1;
            app.Human = player1;
            
        end

        % Button pushed function: StandButton
        function StandButtonPushed(app, event)
            % keep current value of hand
            % dealer starts trying to beat you
            
            % hide all buttons during dealer's turn
            app.StandButton.Visible = 'off'
            app.Hit1Button.Visible = 'off'
            app.Hit2Button.Visible = 'off'
            app.Hit3Button.Visible = 'off'
            
            % assigning local objects with stored app values
            % setting deckDraw as a global variable
            cardDeck1 = app.cardDeck1Memory;
            cardDeck2 = app.cardDeck2Memory;
            cardDeck3 = app.cardDeck3Memory;
            dealer = app.Dealer;
            player1 = app.Human;
            global deckDraw
            
            % loop that makes the Dealer play the game til it gets >= 17
            while dealer.handValue < 17
                
                % using function hit to draw a card from cardDecks
                % consecutively
                if deckDraw == 1
                    deckDraw = 2
                elseif deckDraw == 2
                    deckDraw = 3
                else
                    deckDraw = 1
                end
                
                if deckDraw == 1 % draw from cardDeck1
                    dealer.hit(cardDeck1)
                elseif deckDraw == 2 % draw from cardDeck2
                    dealer.hit(cardDeck2)
                else % draw from cardDeck3
                    dealer.hit(cardDeck3)
                end
                
                % calculating dealer's hand value
                dealer.calcHandValue;
                
                % if cardDeck is empty then reshuffle
                % logical will equal an array of zeros unless .cards = 0
                % if .cards = 0 then an element will equal 1
                % if an element equals 1 then reshuffleDiscard will run
                logical =  ( size(cardDeck1.cards) == 0 );
                if sum(logical) == 1
                    cardDeck1.reshuffleDiscard
                end
                logical =  ( size(cardDeck2.cards) == 0 );
                if sum(logical) == 1
                    cardDeck2.reshuffleDiscard
                end
                logical =  ( size(cardDeck3.cards) == 0 );
                if sum(logical) == 1
                    cardDeck3.reshuffleDiscard
                end
                
                % display sum of Dealer's hand values
                % pause the loop for 1 second
                app.CompHandDisplayLabel.Text = string(dealer.handValue);
                pause(1);
                
            end
        
        % Display objects in the Command Window
        cardDeck1
        player1
        dealer
        
        % when dealer is done, make start button visible
        app.StartButton.Visible = 'on'
        
        % determine a winner of the round using conditional statement
        if dealer.handValue > 21
            msgbox('Winner Winner Chicken Dinner')
            app.Balance = app.Balance + (app.Balance - app.TempBalance)
            app.BalanceLabel.Text = "Balance: " + string(app.Balance)
        elseif player1.handValue > dealer.handValue
            msgbox('Winner Winner Chicken Dinner')
            app.Balance = app.Balance + (app.Balance - app.TempBalance)
            app.BalanceLabel.Text = "Balance: " + string(app.Balance)
        elseif player1.handValue < dealer.handValue
            msgbox('Tough Luck, You Lose')
            app.Balance = app.TempBalance
            app.BalanceLabel.Text = "Balance: " + string(app.Balance)
        else % player1.handValue = dealer.handValue
            msgbox('Draw')
            app.BalanceLabel.Text = "Balance: " + string(app.Balance)
            
        end
        
        % storing local objects within the app
        % hide BetEditField until StartButton is pushed
        app.cardDeck1Memory = cardDeck1;
        app.cardDeck2Memory = cardDeck2;
        app.cardDeck3Memory = cardDeck3;
        app.Dealer = dealer;
        app.BetEditField.Visible = 'off'
        end

        % Button pushed function: Hit2Button
        function Hit2ButtonPushed(app, event)
            % drawing a card from respected deck
            % cardDeck2
            
            % assigning local objects with stored app values
            cardDeck2 = app.cardDeck2Memory;
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
            player1.hit(cardDeck2);
            player1.calcHandValue;
            
            % if deck is empty then reshuffle 
            % logical will equal an array of zeros unless .cards = 0
            % if .cards = 0 then an element will equal 1
            % if an element equals 1 then reshuffleDiscard will run
            logical =  ( size(cardDeck2.cards) == 0 );
            if sum(logical) == 1
                cardDeck2.reshuffleDiscard
            end
                        
            % display sum of Human's hand values
            app.HandDisplayLabel.Text = string(player1.handValue);
            
            % display objects in the Command Window
            cardDeck2
            player1
                        
            % condition statement to determine if handValue is too high
            % if too high, you lose
            % Balance is lost
            % if handValues are too high, hide all buttons besides start
            %% this should be a function called from script 
            if player1.handValue > 21
                
                msgbox('Tough Luck, You Lose')
                app.Balance = app.TempBalance
                app.BalanceLabel.Text = "Balance: " + string(app.Balance)
                
                app.StandButton.Visible = 'off'
                app.Hit1Button.Visible = 'off'
                app.Hit2Button.Visible = 'off'
                app.Hit3Button.Visible = 'off'
                app.StartButton.Visible = 'on'
                
            end
            
            % storing local objects within the app
            app.cardDeck2Memory = cardDeck2;
            app.Human = player1;
            
        end

        % Button pushed function: Hit3Button
        function Hit3ButtonPushed(app, event)
            % drawing a card from respected deck
            % cardDeck3
            
            % assigning local objects with stored app values
            cardDeck3 = app.cardDeck3Memory;
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
            player1.hit(cardDeck3);
            player1.calcHandValue;
            
            % if deck is empty then reshuffle 
            % logical will equal an array of zeros unless .cards = 0
            % if .cards = 0 then an element will equal 1
            % if an element equals 1 then reshuffleDiscard will run
            logical =  ( size(cardDeck3.cards) == 0 );
            if sum(logical) == 1
                cardDeck3.reshuffleDiscard
            end
                        
            % display sum of Human's hand values
            app.HandDisplayLabel.Text = string(player1.handValue);
            
            % display objects in the Command Window
            cardDeck3
            player1
                        
            % condition statement to determine if handValue is too high
            % if too high, you lose
            % Balance is lost
            % if handValues are too high, hide all buttons besides start
            %% this should be a function called from script 
            if player1.handValue > 21
                
                msgbox('Tough Luck, You Lose')
                app.Balance = app.TempBalance
                app.BalanceLabel.Text = "Balance: " + string(app.Balance)
                
                app.StandButton.Visible = 'off'
                app.Hit1Button.Visible = 'off'
                app.Hit2Button.Visible = 'off'
                app.Hit3Button.Visible = 'off'
                app.StartButton.Visible = 'on'
                
            end
            
            % storing local objects within the app
            app.cardDeck3Memory = cardDeck3;
            app.Human = player1;
            
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

            % Create BetEditFieldLabel
            app.BetEditFieldLabel = uilabel(app.UIFigure);
            app.BetEditFieldLabel.HorizontalAlignment = 'right';
            app.BetEditFieldLabel.Position = [272 33 25 22];
            app.BetEditFieldLabel.Text = 'Bet';

            % Create BetEditField
            app.BetEditField = uieditfield(app.UIFigure, 'numeric');
            app.BetEditField.Position = [312 33 68 22];

            % Create BalanceLabel
            app.BalanceLabel = uilabel(app.UIFigure);
            app.BalanceLabel.Position = [258 63 125 22];
            app.BalanceLabel.Text = 'Balance';

            % Create cardDeck2Image
            app.cardDeck2Image = uiimage(app.UIFigure);
            app.cardDeck2Image.Position = [271 349 100 100];

            % Create cardDeck3Image
            app.cardDeck3Image = uiimage(app.UIFigure);
            app.cardDeck3Image.Position = [465 349 100 100];

            % Create Hit2Button
            app.Hit2Button = uibutton(app.UIFigure, 'push');
            app.Hit2Button.ButtonPushedFcn = createCallbackFcn(app, @Hit2ButtonPushed, true);
            app.Hit2Button.Position = [271 315 100 22];
            app.Hit2Button.Text = 'Hit 2';

            % Create Hit3Button
            app.Hit3Button = uibutton(app.UIFigure, 'push');
            app.Hit3Button.ButtonPushedFcn = createCallbackFcn(app, @Hit3ButtonPushed, true);
            app.Hit3Button.Position = [465 315 100 22];
            app.Hit3Button.Text = 'Hit 3';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Gamemode2_exported

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