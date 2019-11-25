classdef card < handle
    properties
        cardNumber = 0;
        value = 0;
        played = 0;
        inPlay = 0;
        position = 0;
    end
    methods
        % Constructor function
        function obj = card(cardNumber)
            obj.cardNumber = cardNumber;
        end
        % Call if card is drawn from deck
        function cardPlayed(obj)
            obj.played = 1;
            cardInPlay(obj)
        end
        
        function cardInPlay(obj)
            obj.inPlay = 1;
        end
        
        % Call when card is discarded
        function discard(obj)
            obj.inPlay = 0;
        end
        % Call when deck is reshuffled
        function reshuffle(obj)
            obj.played = 0;
            obj.inPlay = 0;
        end
    end   
end