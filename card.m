classdef card
    properties
        value;
        played = 0;
        position = 0;
    end
    methods
        function obj = card(value)
            obj.value = value
        end
    end   
end