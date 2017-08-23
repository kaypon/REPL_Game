# Kevin van der Poll
# Monday August 14
# ruby_game.rb
#
#
# variable declarations
alch_level = 0 # alcohol level, used through out game.
money = 50     # money at start of game, used for gambling and buying drinks.
fame = 0       # fame at start of game, used in karaoke.
system "clear" # start a fresh terminal screen

#intro screen at the start of game for small visualization
def intro
  puts "\t--------------------"
  puts "\t---Drink at SHMOS---"
  puts "\t--------------------"
  sleep 1
  system "clear"
  puts "\t++++++++++++++++++++"
  puts "\t+++Drink at SHMOS+++"
  puts "\t++++++++++++++++++++"
  sleep 1
end

#repeats the intro visualization 2 times
2.times{
  intro
  system "clear"
}
intro #display intro screen one more time so that it stays on screen

puts "Welcome to Shmos Bar!"
puts "What is your name?"
player_name = gets.chomp #get player name
player_name.capitalize!  #capitalize name for readability

puts "Welcome to Shmos, #{player_name}!"
sleep 1
loop do #create loop so that the game keeps playing after end of case
  #main page with options
  puts "There are several things you can do here at Shmos,
  \t1) Gamble
  \t2) Drink
  \t3) Karaoke
  \t4) Dance
  \t5) Socialize
  \t6) Check Status
  \t7) Exit"
  puts "To continue, type the command or number of what you'd like to do"

  selection = gets.chomp    #get user selection
  selection.to_s.downcase!  #set their input to downcase for the case statement

  system "clear"
  case selection
  when "gamble" , "1"
    #this game allows the player to bet as much as they want provided they have
    #that much money. the player can double their money if their die is higher
    #than their oponent. if its lower they lose. if its even money is returned.
    loop do

      if money == 0 #checks if the player has money.
        puts "You have $#{money}, you need money to play on these tables kid."
        break #breaks to main screen if they have no money
      end

      puts "Welcome to the dice table #{player_name}!"
      puts "You have $#{money}"
      puts "How much are you willing to bet? (Bet $0 if you wish to leave the table) \n \n"
      bet = Integer(gets) #gets their bet

      system "clear"

      if bet > money
        #player attempts to bet more than they have.
        puts "You can't bet that much!"
        break
      elsif bet == 0
        #player entered 0. they dont want to play again.
        puts "Thank you for playing"
        break
      else
        #text to remind the player how much they have bet and their potential winnings
        puts "You bet #{bet}! If you win, you will recieve $#{bet*2}!"
      end

      player_roll = Random.rand(1...7) #generates random number between 1 and 7
      #puts "You Roll................... #{player_roll}"
      print "You Roll"
      5.times{
        print "..." #small visualization to simulate a roll
        sleep 0.25
      }
      puts "#{player_roll}"

      ai_roll = Random.rand(1...7)
      print "Opponent rolls"
      3.times{
        print "..." #small visualization to simulate a roll
        sleep 0.25
      }
      puts "#{ai_roll}"


      if ai_roll > player_roll #ai wins
        puts "YOU LOST $#{bet}!!!\n\n"
        money -= bet #removes money from players account
        sleep 1
      elsif ai_roll < player_roll #player wins
        puts "YOU WIN $#{bet*2}!!!\n\n"
        money += (bet*2) #adds double the bet to player account
        sleep 1
      else #draw, nothing happens
        puts "ITS A DRAW!!\n\n"
        sleep 1
      end

      break if bet == 0 #breaks out of the loop
    end
  when "drink" , "2"
    #the player goes to the bar to have a drink
    #the player can drink until they are drunk whereby they will be refused service
    loop do
      puts "\nWhat can I get you?"
      puts "1)Wiskey.....$10\n2)Beer.......$5\n3)Moonshine..$15"
      drink_order = gets.chomp
      drink_order.downcase!

      if money <= 0 #checks if the player has any money and kicks them if they are broke
        puts "\n\nGo somewhere else if you have no money!!\n\n"
        sleep 1
        system "clear"
        break
      elsif alch_level > 7 #checks if the player is drunk and offers them water to sober up
        puts "\n\nSorry buddy, you're too drunk!! Would you like some water?\n \t\t y/n?\n\n"
        sober_up = gets.chomp
        if sober_up == "y" #player answers yes
          puts "Here you go, waters on the house!"
          alch_level -= 1 #they sober up
          sleep 1
          break
        elsif sober_up == "n" #player answers no
          puts "Get out of here then!" #they are kicked out
          sleep 1
          system "clear"
          break
        else #input not recognized, clearly they are sluring their words
          puts "I can't understand a word you're saying! BEAT IT!"
          sleep 1
          system "clear"
        end
      end
      system "clear"
      #starts the case statement based on their order.
      case drink_order
      when "wiskey" , "1"
        puts "That'l be $10"
        puts "Take it easy, thats strong stuff!"
        sleep 1
        money -= 10
        alch_level += 2
      when "beer" , "2"
        puts "That'l be $5"
        puts "Hoppy stuff, enjoy it!"
        sleep 1
        money -= 5
        alch_level += 1
      when "moonshine" , "3"
        puts "That'l be $15"
        puts "I don't know anyone who's had more than two of those!"
        sleep 1
        money -= 15
        alch_level += 5
      when "exit"
        puts "Enjoy yourself out there"
      else #incorrect input
        puts "Please input a recognized command!"
        sleep 1
      end
    end

    # karaoke allows the player to choose a song to singing
    # depending on their alcohol level, they might sing well, or terribly
  when "karaoke" , "3"
    loop do
      if fame < -5 #you have made a fool of yourself, fame is too low so no one wants to listen to you.
        puts "You get boo'd as soon as you walk up to the stage, clearly these guys don't like you!"
        sleep 1
        break
      end

      #song choice
      puts "Choose your song! (enter a NUMBER)"
      puts "\t 1) Celine Dion - My heart will go on
      \t 2) Dusty Springfield - Son of a preacher man
      \t 3) Adele - Rolling in the deep
      \t 4) Gloria Gaynor - I will survive
      \t 5) Village People - Y.M.C.A"


      song_choice = gets.chomp
      system "clear"

      #begin case statement for song choice
      case song_choice
      when "1"
        if alch_level < 5 #singing sober
          puts "The crowd doesn't really like this song, but you do did a great job"
          puts "You gained +1 fame!\n\n"
          fame += 1
        else #singing drunk
          puts "The crowd doesn't want to listen to a drunk guy! Get off the stage!"
          puts "You made a fool of yourself, -1 fame!\n\n"
          fame -= 1
        end
        sleep 1
      when "2"
        if alch_level < 5
          puts "People are singing along! You're KILLING IT!!"
          puts "You gained +2 fame!\n\n"
          fame += 2
        else
          puts "You slur your words, and are way off key!"
          puts "That was awful! -2 fame!\n\n"
          fame -= 2
        end
        sleep 1
      when "3"
        if alch_level < 5
          puts "People are up on their feet rocking with you!"
          puts "You gained +1 fame!\n\n"
          fame += 1
        else
          puts "You throw up on stage, how much did you drink man!?"
          puts "The crowd's laughing at you! -2 fame!\n\n"
          fame -= 2
        end
        sleep 1
      when "4"
        if alch_level < 5
          puts "This is your jam! The crowd is loving it!"
          puts "You gained +3 fame!\n\n"
          fame += 3
        else
          puts "It sounds like you have a speach impediment, the owner of the bar has to remove you himself."
          puts "You are an embarrasment, -2 fame\n\n"
          fame -= 2
        end
        sleep 1
      when "5" #YMCA is a tricky one, you can only gain fame if you are drunk
        if alch_level < 5
          puts "You try too hard and the crowd just laughs at you."
          puts "Nice atempt but you lost -1 fame!\n\n"
          fame -= 1
        else
          puts "EVERYONE is as hammered as you! You instantly become the coolest guy in the bar!"
          puts "Rock on buddy! You are killing it with the ladies tonight! +10 FAME!!\n\n"
          fame += 10
        end
        sleep 1
      when "exit" , "back" #leave the karaoke
        puts "Time for something different\n\n"
        sleep 1
        break
      else #unrecognized command
        puts "Please input a recognized command!"
        sleep 1
      end
    end
    #begin dance case. There is no input further it simply returns a String
    #dancing sober gains you fame, dancing too drunk removes your fame
  when "dance" , "4" #
    case alch_level
    when 0 , 1 , 2 #sober dancing
      puts "Nice moves kid!!\n\n"
      fame += 2
      sleep 3
      system "clear"
    when 3 , 4 #tipsy dancing
      puts "Do you have two left feet?\n\n"
      sleep 3
      system "clear"
    when 5 , 6 #drunk dancing
      puts "You're stumbling all over the place!\n\n"
      fame -= 5
      sleep 3
      system "clear"
    else #wasted dancing
      puts "This is just sad to watch!\n\n"
      fame -= 10
      sleep 3
      system "clear"
    end

    #begin the socialize part of the case statement
    #socialize allows the player to chat with people at the bar
    #depending on alch_level the conversations may go different ways.
  when "socialize" , "5"
    loop do
      puts "There are many people you can talk to at this bar! Have a look around!"
      puts "\t1) Bartender
      \t2) Girl
      \t3) Drunk guy"

      chat_choice = gets.chomp
      system "clear"

      #begin new case chat_choice
      case chat_choice
      when "bartender" , "1" #chat to bartender
        loop do
          puts "The bartender seems friendly, but don't get on his bad side!"
          puts "1) Talk about weather\n2) Talk about work\n3) Tell him a joke"
          bar_chat_choice = gets.chomp
          system "clear"

          case bar_chat_choice
          when "weather" , "1"
            puts "He seems really bored.....\n\n"
          when "work" , "2"
            puts "He seems to like his job\n\n"
          when "joke" , "3"
            if alch_level < 5 #if player is sober begin roll to determine if joke is funny
              joke_roll = Random.rand(1...7) #joke roll
              if joke_roll > 3 #joke is funny
                puts "You kill it! He gives you a free beer!\n\n"
                alch_level += 1
              else #joke_roll was unsuccessful and the joke failed
                puts "You mess up the punch line!\n\n"
              end
            else #player is too drunk
              puts "He doesn't understand anything you just said.\n\n"
            end
          when "exit"
            break #stop talking to this person
          else #unrecognized command
            puts "Please input a recognized command!\n\n"
            sleep 1
          end
        end

      when "girl" , "2" #chat to girl
        loop do
          like_you = 0 #points to get the girls number
          puts "There's a cute girl at the bar"
          puts "1) Talk about weather\n2) Talk about work\n3) Talk politics\n4) Tell a joke"
          girl_chat_choice = gets.chomp
          system "clear"

          case girl_chat_choice
          when "weather" , "1"
            puts "Weather? Seriously?\n\n"
          when "work" , "2"
            puts "Turns out she's unemployed! Just like you!\n\n"
          when "politics" , "3"
            puts "Politics are a touchy subject, but you are both well educated!\n\n"
          when "joke" , "4" #same algorithm as the bartender joke
            joke_roll = Random.rand(1...7)
            if joke_roll > 3
              puts "You kill it! She can't stop laughing!\n\n"
              like_you += 1
            else
              puts "You mess up the punch line!\n\n"
              like_you -= 1
            end
            if like_you > 3 #she likes you and gives her number
              puts "You made a good impression, she gives you her number!!\n\n"
              sleep 1
            end
          when "exit" #exit command
            break
          else #unrecognized command
            puts "Please input a recognized command!"
            sleep 1
          end
        end
      when "drunk guy" , "drunk" , "guy" , "3" #talk to drunk guy
        loop do
          puts "This guy is super wasted! Might be a waste of time talking to him."
          puts "1) Talk about weather\n2) Talk about work\n3) Talk politics\n4) Tell a joke"
          #nothing can be said to the drunk guy
          #all inputs return nothing unless you are drunk
          drunk_chat = gets.chomp
          system "clear"

          if drunk_chat == "exit"
            break
          end

          if alch_level > 6 #you are both drunk so are able to communicate
            puts "You guys become best friends!
            The bartender gives you both a glass of water and $5 for a taxi home\n\n"
            alch_level = 2
            money += 5
          else #default return value
            puts "You cant understand a word this guy says. Best leave him alone\n\n"
          end
        end
      when "exit" #exit command
        break
      else #unrecognized command
        puts "Please input a recognized command!\n\n"
        sleep 1
      end
    end

    #begin check status case. allows the player to see their alch_level, money and fame
  when "check status" , "check" , "status" , "6"
    puts "Money: $#{money}"
    puts "Fame: #{fame}"
    case alch_level
      #prints short description of how drunk you are based on alch_level
    when 0
      puts "You're totally sober! Have a drink!"
      puts "Alcohol level: #{alch_level}"
    when 1
      puts "One beer down, I drink all night!"
      puts "Alcohol level: #{alch_level}"
    when 2
      puts "Feeling tipsy!"
      puts "Alcohol level: #{alch_level}"
    when 3
      puts "I'm feeling this booze!"
      puts "Alcohol level: #{alch_level}"
    when 4
      puts "Starting to get drunk!"
      puts "Alcohol level: #{alch_level}"
    when 5
      puts "I'm pretty hammered!"
      puts "Alcohol level: #{alch_level}"
    else
      puts "Rrrrelly waaaayys *hic* sted"
      puts "Alcohol level: #{alch_level}"
    end
    puts "\n\n"
    sleep 1
    #begin exit case
  when "exit" , "7" , "e" #exit the bar
    puts "Thank you for your visit, #{player_name}!"
    break
  else #default unrecognized command
    puts "Please input a recognized command!"
  end
end
