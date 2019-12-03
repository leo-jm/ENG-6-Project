classdef card < handle
    properties
        cardNumber = 0;
        value = 0;
        altValue = 0;
        played = 0;
        inPlay = 0;
        position = 0;
        faceup = 0;
        image;
    end
    methods
        % Constructor function
        % Joker card has cardNumber and value = 0
        function obj = card(cardNumber)
            obj.cardNumber = cardNumber;
            if cardNumber == 0
                obj.value = 0;
            else
            cardValues =[10;1;2;3;4;5;6;7;8;9;10;10;10];
            altCardValues = [2;11;10;9;8;7;6;5;4;3;2;2;2];
            remainder = mod(cardNumber,13);
            obj.value = cardValues(remainder+1);
            obj.altValue = altCardValues(remainder+1);
            end
        end
        
        % Call if card is drawn from deck
        function cardPlayed(obj)
            obj.played = 1;
            cardInPlay(obj)
        end
        
        % Call if card is on the table
        function cardInPlay(obj)
            obj.inPlay = 1;
        end
        
        % Call when card is discarded
        function discard(obj)
            obj.inPlay = 0;
            obj.faceup = 0;
        end
        
        % Call when card is face up
        function cardFaceUp(obj)
            obj.faceup = 1;
        end
        
        % Call when card is face down
        function cardFaceDown(obj)
            obj.faceup = 0;
        end
        
        % Call when deck is reshuffled
        function reshuffle(obj)
            obj.played = 0;
            obj.inPlay = 0;
            obj.faceup = 0;
        end
    end   
end