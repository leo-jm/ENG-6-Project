classdef RulesFinal_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        RulesforBlackjackTextArea  matlab.ui.control.TextArea
        RulesforBlackjackLabel     matlab.ui.control.Label
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'UI Figure';

            % Create RulesforBlackjackTextArea
            app.RulesforBlackjackTextArea = uitextarea(app.UIFigure);
            app.RulesforBlackjackTextArea.Position = [1 1 650 454];
            app.RulesforBlackjackTextArea.Value = {'"Basic Rules";'; '"Every player and the dealer starts with two cards, you can see the other player''s cards as well as one of the dealer''s.";'; '"The goal is to get the highest valued hand without going over a value of 21.";'; '"Each player has the option to hit or stand, hitting means you want to draw a card from the deck to add to your hand.";'; '"You can continue hitting as long as your hand value doesn''t go over 21, if it does you lose.";'; '"Stand means you are done adding to your hand, once every player stands the dealer reveals its hidden card.";'; '"The dealer will hit until its hand reaches a value of 17 or greater.";'; '"If any player or dealer''s hand value goes over 21 they automatically lose.";'; ';'; '"Multiple card decks";'; '"When starting the game you can choose to play from multiple decks, this allows you to hit from any one of up to three decks.";'; '"Each deck has an amount of playing deck''s worth of cards (52 cards per playing deck) selected for when starting the game.";'; ';'; '"Jokers";'; '"Each deck you can hit from also contains a number of jokers also chosen when starting the game.";'; '"If you draw a joker the top card of each of the decks will be revealed from the remainder of the round for you to see.";'; '"Use this advantage wisely to inform your decision on what deck to hit from or if you should stand.";'; ';'; '"Multiple players";'; '"This blackjack game supports a second player controlled by the computer.";'; '"Unlike in traditional blackjack, you are playing against both the dealer and this second player.";'; '"Even if you beat the dealer, if this second player beats you, you lose the game.";'; ';'; '"Playing the game";'; '"1) Before clicking start, set your bet in the number box labeled bet, you have a balance of $5000, don''t lose all your money!";'; '"2) After clicking start your hand will be dealt to you, based off your hand choose whether to hit or not.";'; '"3) When you decide click either hit or stand, if you hit another card will be dealt to you.";'; '"4) As long as your hand doesn''t surpass a value of 21 you can continue hitting, reevaluate your hand and decide your next move.";'; '"   If your hand exceeds a value of 21 the game is over for you, you''ve lost."; '; '"   Set a new bet and click start to start another round.";'; '"5) Hit until you are satisfied with your hand, then choose to stand. The dealer will now hit"'; '"6) The game is over now, you''ve either won, lost or there''s been a draw."; '; '"   Reset your bet and click start to start another round.";'; '}'; ''};

            % Create RulesforBlackjackLabel
            app.RulesforBlackjackLabel = uilabel(app.UIFigure);
            app.RulesforBlackjackLabel.Position = [289 454 108 22];
            app.RulesforBlackjackLabel.Text = 'Rules for Blackjack';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = RulesFinal_exported

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