classdef AImedium
    methods(Static)
        function move = AImove(deck,player)
            strategy1 = [1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,0,0,0,1,1,1,1;
                         1,0,0,0,0,0,1,1,1,1;
                         1,0,0,0,0,0,1,1,1,1;
                         1,0,0,0,0,0,1,1,1,1;
                         1,0,0,0,0,0,1,1,1,1;
                         0,0,0,0,0,0,0,0,0,0;
                         0,0,0,0,0,0,0,0,0,0;
                         0,0,0,0,0,0,0,0,0,0;
                         0,0,0,0,0,0,0,0,0,0;
                         0,0,0,0,0,0,0,0,0,0;];
            strategy2 = [1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,1,1,1,1,1,1,1,1,1;
                         1,0,0,0,0,0,0,0,1,1;
                         0,0,0,0,0,0,0,0,0,0;
                         0,0,0,0,0,0,0,0,0,0
                         0,0,0,0,0,0,0,0,0,0];
             
            dealercard = deck.table([deck.table(:).faceup] == 1);
            playerhand = [player.hand(:).value];
            logic = playerhand == 1;
            if length(player.hand(:)) == 2
                if sum(logic) == 1
                    column = dealercard.value;
                    row = playerhand(playerhand ~= 1);
                    move = strategy2(row,column);
                else
                    column = dealercard.value;
                    row = player.handValue;
                    move = strategy1(row,column);
                end
            else
                column = dealercard.value;
                row = player.handValue;
                move = strategy1(row,column);
            end
            
        end
    end
end