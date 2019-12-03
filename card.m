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
            switch cardNumber
                case 1
                    obj.image = imread('ace_of_spades.png');
                case 2
                    obj.image = imread('2_of_spades.png');
                case 3
                    obj.image = imread('3_of_spades.png');
                case 4
                    obj.image = imread('4_of_spades.png');
                case 5
                    obj.image = imread('5_of_spades.png');
                case 6
                    obj.image = imread('6_of_spades.png');
                case 7 
                    obj.image = imread('7_of_spades.png');
                case 8 
                    obj.image = imread('8_of_spades.png');
                case 9 
                    obj.image = imread('9_of_spades.png');
                case 10
                    obj.image = imread('10_of_spades.png');
                case 11 
                    obj.image = imread('jack_of_spades2.png');
                case 12 
                    obj.image = imread('queen_of_spades2.png');
                case 13 
                    obj.image = imread('king_of_spades2.png');
                case 14 
                    obj.image = imread('ace_of_hearts.png');
                case 15
                    obj.image = imread('2_of_hearts.png');
                case 16
                    obj.image = imread('3_of_hearts.png');
                case 17
                    obj.image = imread('4_of_hearts.png');
                case 18
                    obj.image = imread('5_of_hearts.png');
                case 19
                    obj.image = imread('6_of_hearts.png');
                case 20
                    obj.image = imread('7_of_hearts.png');
                case 21
                    obj.image = imread('8_of_hearts.png');
                case 22
                    obj.image = imread('9_of_hearts.png');
                case 23
                    obj.image = imread('10_of_hearts.png');
                case 24
                    obj.image = imread('jack_of_hearts2.png');
                case 25
                    obj.image = imread('queen_of_hearts2.png');
                case 26
                    obj.image = imread('king_of_hearts2.png');
                case 27
                    obj.image = imread('ace_of_diamonds.png');
                case 28
                    obj.image = imread('2_of_diamonds.png');
                case 29
                    obj.image = imread('3_of_diamonds.png');
                case 30
                    obj.image = imread('4_of_diamonds.png');
                case 31
                    obj.image = imread('5_of_diamonds.png');
                case 32
                    obj.image = imread('6_of_diamonds.png');
                case 33
                    obj.image=imread('7_of_diamonds.png');
                case 34
                    obj.image=imread('8_of_diamonds.png');
                case 35
                    obj.image=imread('9_of_diamonds.png');
                case 36
                    obj.image=imread('10_of_diamonds.png');
                case 37
                    obj.image=imread('jack_of_diamonds2.png');
                case 38
                    obj.image=imread('queen_of_diamonds2.png');
                case 39
                    obj.image=imread('king_of_diamonds2.png');
                case 40
                    obj.image=imread('ace_of_clubs.png');
                case 41
                    obj.image=imread('2_of_clubs.png');
                case 42
                    obj.image=imread('3_of_clubs.png');
                case 43
                    obj.image=imread('4_of_clubs.png');
                case 44
                    obj.image=imread('5_of_clubs.png');
                case 45
                    obj.image=imread('6_of_clubs.png');
                case 46
                    obj.image=imread('7_of_clubs.png');
                case 47
                    obj.image=imread('8_of_clubs.png');
                case 48
                    obj.image=imread('9_of_clubs.png');
                case 49
                    obj.image=imread('10_of_clubs.png');
                case 50
                    obj.image=imread('jack_of_clubs2.png');
                case 51
                    obj.image=imread('queen_of_clubs2.png');
                case 52  
                    obj.image=imread('king_of_clubs2.png');
                case 0 
                    obj.image=imread('joker.png');
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