classdef deck
    properties
        decks;
        cards = [];
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
        % Draw top card
        function drawCard(obj)
            obj.cards(1).cardPlayed;
        end
    end
end

