classdef player < handle
    properties
        hand = [];
        handValue = 0;
        bet = double(0);
        balance = double(5000);
    end
    methods
        % Gives player two cards
        function obj = player(cardDeck,dealer)
            obj.hand = cardDeck.drawCard;
            obj.hand(end+1) = cardDeck.drawCard;
            if nargin == 2
                if dealer == 1
                    obj.hand(1).cardFaceUp                   
                end
            end
            obj.calcHandValue
        end
        % New hand at the start of a new round
        function newHand(obj,cardDeck,dealer)
            obj.hand = cardDeck.drawCard;
            obj.hand(end+1) = cardDeck.drawCard;
            if nargin == 3
                disp("test1")
                if dealer == 1
                    disp("test2")
                    obj.hand(1).cardFaceUp                   
                end
            end
            obj.calcHandValue
        end
        % Adds one card to player's hand
        function hit(obj,cardDeck)
            card = cardDeck.drawCard;
            if ~isempty(obj.hand)
                obj.hand(end+1) = card;
            else
                obj.hand = card;
            end
        end
        % Calculates the value of the player's hand
        % Will count an Ace as 11 if the hand value doesn't pass 21
        function calcHandValue (obj)
            cardValues = [obj.hand.value];
            logic = cardValues == 1;
            if sum(logic) > 0
                value1 = sum(cardValues)+10;
                if value1 > 21
                    obj.handValue = sum(cardValues);
                else
                    obj.handValue = value1;
                end
            else
               obj.handValue = sum(cardValues);
            end
        end
        % Call to set bet amount
        function changeBet(obj,amount)
            obj.bet = amount;
        end
        
        % Change balance after win/loss
        function changeBalance(obj,win)
            if win
                obj.balance = obj.balance + obj.bet;
            else
                obj.balance = obj.balance - obj.bet;
            end
        end
    end
end