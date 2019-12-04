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
            cardImages = ["joker.png";
                          'ace_of_spades.png';
                          '2_of_spades.png';
                          '3_of_spades.png';
                          '4_of_spades.png';
                          '5_of_spades.png';
                          '6_of_spades.png';
                          '7_of_spades.png';
                          '8_of_spades.png';
                          '9_of_spades.png';
                          '10_of_spades.png';
                          'jack_of_spades2.png';
                          'queen_of_spades2.png';
                          'king_of_spades2.png';
                          'ace_of_hearts.png';
                          '2_of_hearts.png';
                          '3_of_hearts.png';
                          '4_of_hearts.png';
                          '5_of_hearts.png';
                          '6_of_hearts.png';
                          '7_of_hearts.png';
                          '8_of_hearts.png';
                          '9_of_hearts.png';
                          '10_of_hearts.png';
                          'jack_of_hearts2.png';
                          'queen_of_hearts2.png';
                          'king_of_hearts2.png';
                          'ace_of_diamonds.png';
                          '2_of_diamonds.png';
                          '3_of_diamonds.png';
                          '4_of_diamonds.png';
                          '5_of_diamonds.png';
                          '6_of_diamonds.png';
                          '7_of_diamonds.png';
                          '8_of_diamonds.png';
                          '9_of_diamonds.png';
                          '10_of_diamonds.png';
                          'jack_of_diamonds2.png';
                          'queen_of_diamonds2.png';
                          'king_of_diamonds2.png';
                          'ace_of_clubs.png';
                          '2_of_clubs.png';
                          '3_of_clubs.png';
                          '4_of_clubs.png';
                          '5_of_clubs.png';
                          '6_of_clubs.png';
                          '7_of_clubs.png';
                          '8_of_clubs.png';
                          '9_of_clubs.png';
                          '10_of_clubs.png';
                          'jack_of_clubs2.png';
                          'queen_of_clubs2.png';
                          'king_of_clubs2.png';];
            obj.image = imread(strcat(".\card_images\",cardImages(cardNumber + 1)));       
                    
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