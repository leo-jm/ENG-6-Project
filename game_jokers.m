cardDeck = deck(1,5);
cardDeck.shuffleDeck;
dealer = player(cardDeck,1);
player1 = player(cardDeck,0);
aiplayer1 = player(cardDeck,0);
aicontrol = AImedium;
game = 1;
while game
    ingame = 1;
    play = 1;
   % bet = double(input("What is your bet? "));
   % player1.changeBet(bet)
   % disp("Balance")
   % disp(player1.balance)
    % Player's turn
    while play
        disp("Your hand value")
        disp(player1.handValue)
        if player1.handValue == 21  
            disp("Blackjack!")
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
          %  player1.changeBalance(0)
          %  disp("Balance")
          %  disp(player1.balance)
            break
        end
        if player1.handValue == 21 
            disp("Blackjack!")
            break
        end
    end
    if ingame
    % AI player's turn
    play = 1;
    while play
        disp("AI hand value")
        disp(aiplayer1.handValue)
        if aiplayer1.handValue == 21  
            disp("Blackjack!")
            break
        end
        if aicontrol.AImove(cardDeck,aiplayer1)
            disp("AI hit")
            aiplayer1.hit(cardDeck)
        else
            disp("AI stand")
            play = 0;
            break
        end
        aiplayer1.calcHandValue
        disp("AI hand value")
        disp(aiplayer1.handValue)
        % Determine if you busted
        if aiplayer1.handValue > 21 
            disp("AI Bust")
            aiplayer1.handValue = 0;
            break
        end
        if aiplayer1.handValue == 21 
            disp("Blackjack!")
            break
        end
        pause(3)
    end
    % Dealer's turn
    disp("Dealer hand value")
    disp(dealer.handValue)
    while dealer.handValue < 17
        dealer.hit(cardDeck)
        dealer.calcHandValue
        disp("Dealer hit")
        disp(dealer.handValue)
        pause(3)
    end
    % Determine winner
    %% Jokers
    player1jokers = sum([player1.hand(:).value] == 0);
    aiplayer1jokers = sum([aiplayer1.hand(:).value] == 0);
    dealerjokers = sum([dealer.hand(:).value] == 0);
    
    if player1jokers > 0
        disp("Jokers!")
        aiplayer1.calcHandValue(1)
        dealer.calcHandValue(1)
    end
    if aiplayer1jokers > 0
        disp("Jokers!")
        player1.calcHandValue(1)
        dealer.calcHandValue(1)
    end
    if dealerjokers > 0
        disp("Jokers!")
        player1.calcHandValue(1)
        aiplayer1.calcHandValue(1)
    end
    
    %%
    disp("Dealer hand value")
    disp(dealer.handValue)
    disp("AI hand value")
    disp(aiplayer1.handValue)
    disp("Your hand value")
    disp(player1.handValue)
    
    if dealer.handValue > 21
        disp("Dealer bust")
        if player1.handValue > aiplayer1.handValue
            disp("You win")
          %  player1.changeBalance(1)
          % disp("Balance")
          %  disp(player1.balance)
        elseif player1.handValue == aiplayer1.handValue
            disp("Tie")
        else
            disp("You lose")
           % player1.changeBalance(0)
           % disp("Balance")
           % disp(player1.balance)
        end
    elseif player1.handValue > dealer.handValue
        if player1.handValue > aiplayer1.handValue
            disp("You win")
          %  player1.changeBalance(1)
          %  disp("Balance")
          %  disp(player1.balance)
        elseif player1.handValue == aiplayer1.handValue
            disp("Tie")
        else
            disp("You lose")
          %  player1.changeBalance(0)
          %  disp("Balance")
          %  disp(player1.balance)
        end
    elseif player1.handValue == dealer.handValue
        if player1.handValue < aiplayer1.handValue
            disp("You lose")
         %   player1.changeBalance(0)
         %   disp("Balance")
         %   disp(player1.balance)
        else
            disp("Tie")
        end
    else
        disp("You lose")
       % player1.changeBalance(0)
       % disp("Balance")
       % disp(player1.balance)
    end
    end
    cardDeck.clearTable
    player1.newHand(cardDeck,0)
    aiplayer1.newHand(cardDeck,0)
    dealer.newHand(cardDeck,1)
    if size(cardDeck.cards) < 5
        cardDeck.resetDeck
    end
end