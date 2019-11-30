classdef player < handle
    properties
        hand = [];
        handValue = 0;
    end
    methods
        % Gives player two cards
        function obj = player(cardDeck)
            obj.hand = cardDeck.drawCard;
            obj.hand(end+1) = cardDeck.drawCard;
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
    end
end