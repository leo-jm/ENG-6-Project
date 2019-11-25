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
            cardValues =[10;1;2;3;4;5;6;7;8;9;10;10];
            remainder = mod(cardNumber,12);
            obj.value = cardValues(remainder+1);
            %{
            if obj.value == 1
                obj.value = [1,11];
            end  
            %}
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