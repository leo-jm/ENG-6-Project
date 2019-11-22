classdef card < handle
    properties
        value;
        played = 0;
        inPlay = 0;
        position = 0;
    end
    methods
        % Constructor function
        function obj = card(value)
            obj.value = value;
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
        
        function reshuffle(obj)
            obj.played = 0;
        end
    end   
end