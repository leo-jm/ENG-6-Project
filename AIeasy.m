classdef AIeasy
    methods(Static)
        function move = AImove(~,player)
            if player.handValue < 17
                move = 1;
            else
                move = 0;
            end
        end
    end
    
end