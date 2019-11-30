cardDeck = deck;
cardDeck.shuffleDeck;
AI = player(cardDeck);
player1 = player(cardDeck);
ingame = 1;
while ingame
    AI.calcHandValue
    player1.calcHandValue
    play = 1;
    % Player's turn
    while play
        disp("Your hand value")
        disp(player1.handValue)
        if player1.handValue == 21
            ingame = 0;  
            disp("You win")
            break
        end
        playerinput = input("Hit or pass?",'s');
        if lower(playerinput) == "hit"
            player1.hit(cardDeck)
        else
            play = 0;
            break
        end
        player1.calcHandValue
        disp("Your hand value")
        disp(player1.handValue)
        % Determine if you busted
        if player1.handValue > 21
            ingame = 0;  
            disp("You lose")
            break
        end
        if player1.handValue == 21
            ingame = 0;  
            disp("You win")
            break
        end
    end
    if ~ingame
        break
    end
    % Dealer's turn
    disp("Dealer hand value")
    disp(AI.handValue)
    while AI.handValue < 17
        AI.hit(cardDeck)
        AI.calcHandValue
        disp("Dealer hit")
        disp(AI.handValue)
        pause(1)
    end
    % Determine winner
    disp("Dealer hand value")
    disp(AI.handValue)
    if AI.handValue > 21
        ingame = 0;  
        disp("You win")
        break
    end
    if player1.handValue > AI.handValue
        disp("You win")
        ingame = 0;
    else
        disp("You lose")
        ingame = 0;
    end
end