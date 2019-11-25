classdef deck < handle
    properties
        decks;
        cards = [];
        discardPile =[];
        table = [];
    end
    methods
        % Constructor function
        function obj = deck(decks)
            if nargin == 0
                obj.decks = 1;
                for j = 1:52
                    if ~isempty(obj.cards)
                        obj.cards(end+1) = card(j);
                    else
                        obj.cards = card(j);
                    end
                end
            else
                obj.decks = decks;
                for i = 1:decks
                    for j = 1:52
                        if ~isempty(obj.cards)
                            obj.cards(end+1) = card(j);
                        else
                            obj.cards = card(j);
                        end
                    end
                end
            end
        end
                
        % Shuffle deck
        function shuffleDeck(obj)
            obj.cards = obj.cards(randperm(length(obj.cards)));
        end
        
        % Draw top card
        function carddrawn = drawCard(obj)
            obj.cards(1).cardPlayed;
            if ~isempty(obj.table)
                obj.table(end+1) = obj.cards(1);
            else
                obj.table = obj.cards(1);
            end
            carddrawn = obj.cards(1);
            obj.cards = obj.cards(2:end);
        end
        
        % Clear away cards in play
        function clearTable(obj)
            obj.discardPile = obj.table;
            for i = 1:length(obj.discardPile)
                obj.discardPile(i).discard;
            end
            obj.table = [];
        end
        
        % Reshuffle discard pile into deck
        function reshuffleDiscard(obj)
            obj.cards = [obj.cards,obj.discardPile];
            for i = 1:length(obj.discardPile)
                obj.discardPile(i).reshuffle;
            end
            obj.discardPile = [];
            obj.shuffleDeck;
        end
        
        % Reset deck, reshuffle cards on table and in discard pile
        function resetDeck(obj)
            obj.clearTable;
            obj.reshuffleDiscard;
        end
    end
end

