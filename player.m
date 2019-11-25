classdef player < handle
    properties
        hand = [];
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
    end
end