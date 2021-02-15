
class Fitset
	def initialize(first, second, third)
		@first_fit = first
		@second_fit = second
		@third_fit = third
	end

end


#this method check if the number feature of three cards meet the requirement
def numberfillter (cards, i ,j ,k)
	fit = (cards[i][0]== cards[j][0])&&(cards[i][0]==cards[k][0])&&(cards[j][0]== cards[k][0])||(cards[i][0]!= cards[j][0])&&(cards[i][0]!=cards[k][0])&&(cards[j][0]!= cards[k][0])
	return fit
end

#this method check if the symbol feature of three cards meet the requirement
def symbolfillter cards, i, j, k
  fit = (cards[i][1]== cards[j][1])&&(cards[i][1]==cards[k][1])&&(cards[j][1]== cards[k][1])||(cards[i][1]!= cards[j][1])&&(cards[i][1]!=cards[k][1])&&(cards[j][1]!= cards[k][1])
        return fit

end

#this method check if the shading feature of three cards meet the requirement
def shadingfillter( cards ,i, j, k)
  fit = (cards[i][2]== cards[j][2])&&(cards[i][2]==cards[k][2])&&(cards[j][2]== cards[k][2])||(cards[i][2]!= cards[j][2])&&(cards[i][2]!=cards[k][2])&&(cards[j][2]!= cards[k][2])
        return fit
end
#this method check if the color feature of three cards meet the requirement
def colorfillter (cards, i, j, k)
  fit = (cards[i][3]== cards[j][3])&&(cards[i][3]==cards[k][3])&&(cards[j][3]== cards[k][3])||(cards[i][3]!= cards[j][3])&&(cards[i][3]!=cards[k][3])&&(cards[j][3]!= cards[k][3])
        return fit

end

#this method find all the sets in 12 cards that meet the requirement
def findSet(cards)
	allgoodSet = []
	i, j, k , m= 0, 0, 0, 0
	while i<cards.size do
		j = i+1
		while j <cards.size do
		       k = j+1
		       while k <cards.size do
				colorfillter cards, i, j, k

				if((numberfillter cards, i, j, k)&&(symbolfillter cards, i, j, k)&&(shadingfillter cards, i, j ,k)&&(colorfillter cards, i, j, k))
					oneSet= Fitset.new(i, j, k)
					puts "Fit sets are "+i.to_s+" "+ j.to_s+" "+ k.to_s
					allgoodSet.push oneSet
					m= m+1
				end

				k=k+1
			end
			j = j+1
	 	end
		i=i+1
	end

return allgoodSet, m
end

#Translates the numerical representation of the card number to a string
def translateNumber (number)
	num = ""
	if (number == 0)
		num = "One "
	elsif (number == 1)
		num = "Two "
	elsif (number == 2)
		num = "Three "
	end
	return num
end

#Translates the numerical representation of the card symbol to a string
def translateSymbol (number)
	symbol = ""
	if (number == 0)
		symbol = "Diamond "
	elsif (number == 1)
		symbol = "Squiggle "
	elsif(number == 2)
		symbol = "Oval "
	end
	return symbol
end

# Translates the numerical representation of the card shading to a string
def translateShading(number)
	shade = ""
	if (number == 0)
		shade = "Solid "
	elsif (number == 1)
		shade = "Stripped "
	elsif (number == 2)
		shade = "Open "
	end
	return shade
end

# Translates the numerical representation of the card color to a string
def translateColors(number)
	color = ""
	if (number == 0)
		color = "Red"
	elsif (number == 1)
		color = "Green"
	elsif (number == 2)
		color = "Purple"
	end
	return color
end

#this method print out all 12 cards
def printCards( cards)
	i =0
	while i < cards.size do
		puts "Card "+i.to_s+": "+translateNumber(cards[i][0])+translateSymbol(cards[i][1])+translateShading(cards[i][2])+translateColors(cards[i][3])
	i=i+1
	end

end

#this method check if the input three cards from the user meet the requirements
def getCheckInput (cards,i,j, k)
	result = true
	if((numberfillter cards, i, j, k)&&(symbolfillter cards, i, j, k)&&(shadingfillter cards, i, j ,k)&&(colorfillter cards, i, j, k))
		result = true
	else
		result = false
	end
	#puts result
	return result
end
#this method change the number in range [0, 80] into four numbers(0, 1, 2)
def changeNumber allCards
	i =0
	while i<81 do
		element = allCards[i]
		oneCard = []
		oneCard.push element%3
		oneCard.push (element/3)%3
		oneCard.push (element/9)%3
		oneCard.push (element/27)%3
		allCards[i] = oneCard
		i = i+1
	end
	return allCards
end

#this method update the cards at the index i, j, k
def updateCardSet cards, allCards, index, i, j, k
	cards[i] = allCards[index]
	index = index +1
	cards[j] = allCards[index]
	index =index +1
	cards[k] = allCards[index]
	index = index +1
	fitSet = []
	fitSet, fitSize=findSet cards
	#puts "There will be "+fitSize.to_s+" sets cards meets the requirement\n"
	while fitSize == 0 do
        	index = index+3
     	   	cards.push  allCards[index-3], allCards[index-2], allCards[index-1]
        	fitSet, fitSize=findSet cards
		puts fitSize
	end
	return cards, index
end

#this method start the game
def playGame cards, allCards, index

	num = 0
	while index < 81 do
		printCards cards
		puts "Enter three cards that you think are a set: "
		i =gets.chomp.to_s
		j = gets.chomp.to_s
		k =gets.chomp.to_s
		oneSet = Array.new(3)
		if (i == "X") || (i == "x") || (j == "X") || (j == "x") || (k == "X") || (k == "x")
			index = 81 #Break the while loop and end the game
			puts "Thanks for playing!"
			sleep (1)
			puts "You found a total of "+ num.to_s + " sets"
			sleep (1)
			puts "Goodbye!"
		else
			i = i.to_i
			j = j.to_i
			k = k.to_i
			if (i==j)||(i==k)||(j==k)||!(i>=0&&i<=11)||!(j>=0&&j<=11)||!(k>=0&&k<=11)
				puts "Invalid card number inputs. Try again"
				sleep (1)
			elsif getCheckInput cards, i, j, k
				oneSet=[i,j,k]
				oneSet.sort
				puts "You found a set!"
				sleep (1)

				cards, index = updateCardSet cards, allCards, index, i, j, k
				num = num + 1
				#puts "You have find "+num.to_s+" fitted sets"

			else
				puts "I'm sorry that's not a set"
				sleep (1)
			end
		end
	end
end
allCards = Range.new(0,80).to_a.shuffle
allCards = changeNumber allCards
index = 12
cards = allCards[0, index]
fitSet = []
fitSet, fitSize=findSet cards

#puts "There will be "+fitSize.to_s+" sets cards meets the requirement\n"
while fitSize == 0 do
	index = index+3
	cards = allCards[0,index]
	fitSet, fitSize=findSet cards
end

#Introduce the player to the game
puts "Welcome to The Game of Set!"
sleep (1)
puts "This Game of Set is just like the normal card game we all know and love"
sleep (1)

#Give them the instructions and the commands
puts "Once the game starts you will be shown the cards with their corresponding card number"
sleep (1)
puts "The card number will be shown as such: Card 2: card description"
sleep (1)
puts "You will then type ONLY the number corresponding to the card you believe to be part of a set followed by enter"
sleep (1)
puts "Then add the other corresponding card number each followed by an enter"
sleep (1)
puts "Make sure you input the correct card number because once you hit enter your answer is locked in"
sleep (1)
puts "If you want to quit at anytime just type an X in any of the card number options"
sleep (1)
puts "Let's begin!"
sleep (1)
puts "Shuffling deck..."
sleep (1)

# Ask if they would like to play with a timer

#Starting the game of Set
#play = true

#while play
	#start the game
	playGame cards, allCards, index
#end
