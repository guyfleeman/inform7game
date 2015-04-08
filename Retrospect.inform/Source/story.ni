[ code style when relevant and possible...
	start with commented definitions
	proceed with commented location definitions
	proceed with commented initializations
				
	do no capitalize names unless they are the first word in a statement
]

[helpful links
	-Action Syntax Guide: 		http://inform7.com/learn/documents/I7_syntax.txt
	-Implied Object Structure: http://www.ifwiki.org/index.php/Inform_7_for_Programmers/Part_1
]

[tips
	-Watch plurality when defining objects, check the room description. It seems to be fairly stupid.
			-Fix by stating 'The indefinite article is "".'
	-Only the last statement in conditional blocks has punctuation of *any* kind.
					-Bug?
	-In rules (functions or SR's) Statements ending in a ';' prior to a conditional block generate errors in the 
			compiler if they are followed by a blank line or line with only white space (WTF this took me 20mins to fix)
]

"Retrospect" by "GroopOfFore"

[INCLUDES
 File
	-> Install Extension
 ]
Include Basic Help Menu by Emily Short.
Include Basic Screen Effects by Emily Short.
[Include Version 2 of Title Page by Jon Ingold.]

[DEF ABSTRACTIONS]
[ apparently implicit subclasses can be made, but I couldn't get them to work. This wasn't the right approach anyway.
ToggableThing is a kind of thing.
	ToggableThing can be on or off.
	ToggableThing is usually off.
]
An Evidence is a kind of thing.
	An Evidence is always fixed in place.
	Instead of taking an Evidence, say "You can't take evidence from the scene of the crime".

[DEF ACTIONS]
Understand the command "pwd" as "look".
Understand the command "ls" as "inventory".
Understand the command "dir" as "inventory".
Understand the command "pockets" as "inventory".
[Understand the command "sudo update-initramfs" as "leveling up".]
 	 Understand the command "cd" as "go".
Understand the command "echo" as "say".
 [Understand "cd .." as "up".]

Being is an action applying to one thing.
	Understand "be" as being.

Flying is an action applying to nothing.
	Understand "fly" as flying.
	Instead of flying, say "You wish."
	
Pooping is an action applying to nothing.
	Understand "poop" as pooping.
	Instead of pooping, say "This is not the time to do that."

Importing is an action applying to one thing.
	Understand "import [thing]" as importing.
	antigravity is a thing.
	Instead of importing antigravity:
		Now the player is carrying antigravity;
		say "Medicine cabinet sampled.".
	
Watering is an action applying to one thing.
	Understand "water [thing]" as watering.
	
Listing is an action applying to one thing.
	Understand "list [thing]" as listing.
	
Leveling up is an action applying to nothing.
	Understand "level up" as leveling up.
		
Reading is an action applying to one thing.
	Understand "read [thing]" as reading.
	
Picking is an action applying to a thing.
	Understand "pick [door]" as picking.

Talking is an action applying to one thing.
	Understand "talk [person]" as talking.
	Understand "talk to [person]" as talking.
	
Killing is an action applying to one thing and one carried thing.
	Understand "kill [thing] with [something preferably held]" as killing.
	
[wrap the default switch commands]
Turning On is an action applying to one thing.
	Understand "turning on [thing]" as switching on.
	
Turning Off is an action applying to one thing.
	Understand "turning off [thing]" as switching off.
	
[DEF GLOBAL VARS]
The Maximum Score is 20. [2x num of clues (whatever that becomes)]
The Score is 0.
Use scoring.

The stageCount is a number that varies.
The stageCount is 0.

The clueCount is a number that varies. The clueCount is 0.

The clueFlag is a number that varies.
The clueFlag is 0.

[forward declaration hack for murder event to trigger scene change]
The deathFlag is a number that varies.
The deathFlag is 0.

A thing has some text called content. 
	The content of a thing is usually "".	
A thing has some text called smell.
A thing has some text called deathStatus.
	The deathStatus of a thing is usually "alive".
	
Brightness is a kind of value. 
	The brightnesses are dim and bright.
	
Current Scene is a scene that varies.

[DEF SCENES]
Investigation is a scene.
	Investigation begins when the player is in the Front Yard for the first time.
	Investigation ends when Investigation is the Current Scene AND the clueFlag is 1.
	
Murder is a scene.
	Murder begins when Investigation ends.
	Murder ends when Murder is the Current Scene AND the deathFlag is 1.
	
	When Murder begins:
		Move the player to the Back Yard;
	
Staging is a scene.
	Staging begins when Murder ends.
	
The Current Scene is Investigation.

When Investigation ends:
	Now the Current Scene is Murder;
	Clear the screen;
	
When Murder ends:
	Now the Current Scene is Staging;
[The Current Scene is Murder.]

[DEF ROOMS/DOORS]
Front Yard is a room.
Living Room  is a room.
Garage is a room.
Kitchen is a room.
Back Yard is a room.
Upstairs is a room.
Master Bedroom is a room.
Child's Bedroom is a room.

The sentinel is a thing.
	The sentinel can be on or off.
	The sentinel is on.
	
The back door is a door.
	Instead of picking the back door:
		Say "Picking... (press random keys)[line break]";
		while the sentinel is on
		begin;
			Wait for any key;
			Say "[if a random chance of 1 in 2 succeeds]*click*[otherwise]*clank*[end if][line break]";
			if a random chance of 1 in 5 succeeds [this is the shittiest RND I've ever seen]
			begin;
				Say "Done.";
				Now the back door is unlocked;
				stop;
			end if;
		end while;
		
The front door is a door.
	The description is "The front door is black, devoid of windows, and made of oak. It is unlocked.".
	Instead of picking the Front Door:
		Say "Picking... (press random keys)[line break]";
		while the sentinel is on
		begin;
			Wait for any key;
			Say "[if a random chance of 1 in 2 succeeds]*click*[otherwise]*clank*[end if][line break]";
			if a random chance of 1 in 5 succeeds
			begin;
				Say "Done.";
				Now the front door is unlocked;
				stop;
			end if;
		end while;
		
The fence gate is a door.
	The fence gate is unlocked.
	The fence gate is closed.
	Instead of opening the fence gate:
		if Investigation is the Current Scene
		begin;
			Say "The police have already searched this area and found nothing.";
		otherwise if Murder is the Current Scene;
			Say "You already entered from here. You aren't ready to go back.";
		otherwise if Staging is the Current Scene;
			Say "eval stg score";
		end if;

[DEF ROOM LOCATIONS]
Living Room is north of front door.
Garage is west of Living Room.
Kitchen is north of Living Room.
Kitchen is south of the back door.
Upstairs is above Kitchen.
Back Yard is north of Back Door.
Master Bedroom is east of Upstairs.
Child's Bedroom is south of Upstairs.

The front door is north of the Front Yard and south of the Living Room.
The back door is north of the Kitchen and south of Back Yard.
The fence gate is north of the Back Yard.

The portal gun is in the front door.
	The portal gun is edible.

When Investigation begins:
	Now the front door is unlocked;
	Now the back door is unlocked;

When Murder begins:
	Now the front door is locked;
	Now the back door is locked;

[DEF INVENTORY]
The pick gun is a thing.
	The description is "A pick gun. Pick guns can be used to unlock most residential locks.".
	The pick gun unlocks the back door.
	The pick gun unlocks the front door.
	
The burner phone is a thing.
	The description is "A burner phone with local Ketamine dealers in the contacts.".
	
The machete is a thing.
	The description is "A sharpened machete with a wooden handle.".
	
The zip ties are a thing.
	The indefinite article is "some".
	The description is "Black industrial zip ties.".
	
The vial is a thing.
	[The indefninite article is "some".]
	The description is "A vial of Ketamine.".
	
The needle is a thing.
	The description is "An empty needle.".
	
your phone is a thing.
	The player is carrying your phone.
	Instead of dropping your phone, say "You won’t risk that until you’ve bought a case for it.".
	
your clothes are a thing.
	The description is "Just a typical suit. Your shoes look like they need to be polished."
	The player is carrying your clothes.
	Instead of dropping your clothes, say "Nudity is not acceptable in this society.".
	Instead of eating your clothes, say "You put your sleeve in your mouth and bite down. There are now teeth marks on your arm.[if the player is in the front yard] The police officer looks at you and raises his eyebrow.[end if]".

[inv inits]
When Murder begins:
	Now the player has the pick gun;
	Now the player has the burner phone;
	Now the player has the machete;
	Now the player has the zip ties;
	Now the player has the vial;
	Now the player has the needle.
	

[INIT SCENERY]
	[Front Yard]
	The forest is in the Front Yard.
		The forest is scenery.
		The description is "The pine forest stands tall and strong with age. [if we have not examined the forest]The trees sway lightly in the breeze, as if they're friends.[end if]".
	
	The house is in the Front Yard.
		The house is scenery.
		The description is "The house is two stories with a shale facade and brushed bronze accents.".
	
	The driveway is in the Front Yard.
		The driveway is scenery.
		The description is "The driveway looks new but there are dandelions growing between the section cracks. You've always hated dandelions.[if we have not examined the driveway] *ah Ah ACHOO* You wipe your nose on a napkin and put it back in your back pocket.[end if]".
		
	The porch is in the Front Yard.
		The porch is scenery.
		The description is "The porch has beautiful hanging flower pots that are budding. The handrail rails are made from black woven metal and brushed bronze.". 
		
	The path is in the Front Yard.
		The path is scenery.
		The description is "The path connects the front porch to the driveway and passes the bushes. It is made of dark river stones. [if we have not examined the path]They crunch softly beneath your feet.[end if]".
		
	The lawn is in the Front Yard.
		The lawn is scenery.
		The description is "The lawn is freshly mown and free of debris and weeds.".
	
	The apple tree is in the Front Yard.
		The apple tree is scenery.
		The description is "The tree looks to be a few years old. It bears fruit, but it's not ripe enough to eat.".
		
	[Living Room]
	The lamp is in the Living Room.
		The lamp is scenery.
		The description is "Just your typical lamp. It doesn't seem to be working".
	[Garage]
	
	[Kitchen]
	[
	The back door is in the Kitchen.
		The back door is scenery.
		The description is "There is a door here leading to the backyard. It seems unlocked."]
	
	[Back Yard]
	The shovel is in the back yard.
	
	The flowers are in the back yard.
		The description is "Tulips. Your least favorite flower."
	
	[Upstairs]
	
	[Master Bedroom]
	
	[Child's Bedroom]
	The window is in the Child's Bedroom.
		The window is scenery.
		The description is "A pine forest can be seen. Just past the edge of the forest, you can see a duck blind.".
	
	[Scenery scene routines]
	When Investigation begins:
		Say "Scenery Init investigation".
		
	When Investigation ends:
		Say "Scenery End Investigation".
		
	When Murder begins:
		Say "Scenery Init Murder".
		
	When Murder ends:
		Say "Scenery End Murder".
		
	When Staging begins:
		Say "Scenery Init Staging".
		
	When Staging ends:
		Say "Scenery End Staging".

[INIT OBJECTS]
	[dynamic surroundings
		tracks the location/scope of the player and updates its position
		allowing the government to always 'examine surroundings'.]
	The surroundings are a thing.
	The indefinite article is "some".
	After deciding the scope of the player:
		Place the surroundings in scope;
		[Place the surroundings in scope.]
		if the player is in the Front Yard,
			Move the surroundings to the Front Yard
		instead;
		if the player is in the Living Room,
			Move the surroundings to the Living Room
		instead;
		if the player is in the Garage,
			Move the surroundings to the Garage
		instead;
		if the player is in the Kitchen,
			Move the surroundings to the Kitchen
		instead;
		if the player is in the Upstairs,
			Move the surroundings to the Upstairs
		instead;
		if the player is in the Back Yard,
			Move the surroundings to the Back Yard
		instead;
		if the player is in the Master Bedroom,
			Move the surroundings to the Master Bedroom
		instead;
		if the player is in the Child's Bedroom,
			Move the surroundings to the Child's Bedroom
		instead;
	Instead of examining the surroundings:
		if the player is in the Front Yard,
			Say "You see an earthy house surrounded by a forest. There are several objects that would ordinarily belong in in a front yard."
		instead;
		if the player is in the Living Room,
			Say "Living Room description"
		instead;
		if the player is in the Garage,
			Say "Garage description"
		instead;
		if the player is in the Kitchen,
			Say "Kitchen description"
		instead;
		if the player is in the Upstairs,
			Say "Upstairs description"
		instead;
		if the player is in the Back Yard,
			Say "Back Yard description"
		instead;
		if the player is in the Master Bedroom,
			Say "Master Bedroom description"
		instead;
		if the player is in the Child's Bedroom,
			Say "Child's Room description"
		instead;
	[list scenery for further examination]
	Instead of listing the surroundings:
		if the player is in the Front Yard,
			Say "You see a forest, a house, a driveway, a porch, a path, a front door, a lawn, a mail box, and an apple tree in your surroundings."
		instead;
		if the player is in the Living Room,
			Say "Living Room list"
		instead;
		if the player is in the Garage,
			Say "Living Room list"
		instead;
		if the player is in the Kitchen,
			Say "Living Room list"
		instead;
		if the player is in the Upstairs,
			Say "Living Room list"
		instead;
		if the player is in the Back Yard,
			Say "Living Room list"
		instead;
		if the player is in the Master Bedroom,
			Say "Master Bedroom list"
		instead;
		if the player is in the Child's Bedroom,
			Say "Child's Room list"
		instead;
	Instead of taking the surroundings:
		Say "You can't have everything, you know?".
	
	[Front Yard]	
	The police officer is in the Front Yard.
		The police officer is a person.
		The description is "Just your everyday typical police officer."
		The police officer is fixed in place.
		Instead of talking the police officer:
			if Investigation is the Current Scene
			begin;
				if score > 2
				begin;
					Say "Looks like this one is turning out to be pretty cut and dry. [if score > 4] Clearly t[otherwise]T[end if]his guy was offed by a local cartel. We'll get some more detectives down here to figure out which group was responsible for this butchery.";
					Now the clueFlag is 1;
				otherwise;
					Say "You'd better keep looking for clues instead of chitchatting or the chief is gonna get pissed.";
				end if;
			end if;
	
	The bushes are a container.
		The bushes are in the Front Yard.
		Understand "bush" as bushes.
		The indefinite article is "some".
		The description is "The bushes have beautiful white flowers [if the bushes are not watered]on them, but they could use some water.[otherwise]that glisten in the morning sun.[end if]".
		The bushes are fixed in place.
		The bushes are enterable.
		After entering the bushes:
			say "Ow, that hurt. At least I'm in a bush now.".
		The bushes can be watered or not watered.
		The bushes are not watered.
		Instead of watering the bushes:
			if Investigation is the Current Scene
			begin;
				if the player has the nozzle and the nozzle is switched on
				begin;
					Say "You water the bushes.";
					Now the bushes are watered;
				otherwise if the player has the nozzle and the nozzle is switched off;
					Say "You can't water the bushes when the nozzle is off.";
				otherwise;
					Say "You have nothing with which to water the plant.";
				end if;
			end if.
			
	The nozzle is a thing.
		The description is "The nozzle's plastic is sunbaked and brittle. It is unclear if it has been used recently.".
		The nozzle can be switched on or switched off.
		The nozzle is switched off.
		Instead of switching on the nozzle:
			Say "The hose controls the nozzle.".
		Instead of switching off the nozzle:
			Say "The hose controls the nozzle.".
		
	The garden hose is a thing.
		The garden hose is in the Front Yard.
		The description is "The garden hose has a nozzle attached to it for watering plants.".
		The garden hose is fixed in place.
		After examining the garden hose for the first time:
			if Investigation is the Current Scene
			begin;
				Move the nozzle to the Front Yard;
			end if.
		The garden hose can be switched on or switched off.
			The garden hose is switched off.
			Instead of switching on the garden hose:
				if Investigation is the Current Scene
				begin;
					Now the nozzle is switched on;
					Say "The nozzle is now turned on.";
				end if.				
			After switching off the garden hose:
				if Investigation is the Current Scene
				begin;
					Now the nozzle is switched off;
					Say "The nozzle is now turned off.";
				end if;
				
	The mail box is a container.				
		The mail box is in the Front Yard.
		The description of the mail box is "The house number 606 is on its side.[if the mail box is open] The mail box is empty.[end if]".
		Understand "mailbox" as mail box.
		The mail box is fixed in place.
		
	The magazine is a thing.
		The magazine is in the mailbox.
		The description is "TaeKwonDo Times.".
		
	[dynamic properties]
	When Investigation begins:		
		[mail box]
		Now the mail box is openable;
		Now the mail box is closed;
		
	[Living Room]		
	The couch is an Evidence.
		The couch is in the Living Room.
		The description is "Just a couch".
		
	The TV is an Evidence.
		The TV is in the Living Room.
		The description is "An old television. It doesn't seem to be working".

	The laptop is an Evidence.
		The description is "A modest HP Laptop.
			[if the laptop is switched on and the laptop is unlocked] You copy the password you found into the computer and it successfully unlocks.
			[otherwise if laptop is switched on and the laptop is locked] The Laptop is locked. You will need to find the password. Don't waste your time guessing.
			[otherwise] Try switching it on.
			[end if]".
		The laptop is in the Living Room.
		The laptop is either locked or unlocked.
			The laptop is locked.
		The laptop can be switched on or switched off.
			The laptop is switched off.
			Instead of switching on the laptop:
				Now the laptop is switched on;
				Say "The laptop is now turned on.";
			After switching off the laptop:
				Now the laptop is switched off;
				Say "The laptop is now turned off.";
		After examining the laptop:
			Increase the clueCount by 1. [todo: only if on]
		
	The Ketamine is an Evidence.
		Instead of looking under couch for the first time:
			Now Ketamine is in Living Room;
			say "You find a large bag of Ketamine. You pull it out from underneath the couch".
		The description is "Ketamine is a heavy drug. Worth a lot of money too".
		After examining Ketamine, increase the clueCount by 1.

	[Garage]
	The hood is a thing.
		The hood is fixed in place.
		The description is "You lift the hood open. Underneath, you find a small compartment filled with Ketamine.".
		After examining the hood under the first time, increase the clueCount by 1.
		[Understand looking under the hood as examining the hood.]
		
	The car is a container.
		The car is in the Garage.
		The car is fixed in place.
		The description is "A Toyota. Must be at least 20 years old. The hood is slightly open.". 
		The car is enterable.
		After examining the car for the first time, move the hood to the Garage.
		
	The tool bench is a thing.
		The tool bench is in the Garage.
		The tool bench is fixed in place.
		The description is "An old rusty tool bench.".
		The tool bench contains a wrench, a screwdriver, a hand drill, and a hammer.
		The hand drill is an Evidence.
			The description is "A common household tool... or possibly a brutal weapon".
		The wrench is an Evidence.
			The description is "A common household tool".
		The screwdriver is an Evidence.
			The description is "A common household tool".
		The hammer is an Evidence.
			The description is "A common household tool... or possibly a brutal weapon".
			
	The scale is an Evidence.
		Instead of looking under the tool bench for the first time:
			Now the scale is in the Garage;
			say "You find a small scale behind the TV. The units are currently set to measure in grams. You pull it out from under the tool bench.".
		The description is "A small battery-powered measuring scale. You place your car keys on the scale and see that it has 3 decimal places of precision".
		After examining the scale for the first time, increase the clueCount by 1.
		
	The power box is an Evidence.
		The power box is in the Garage.
		After examining the power box for the first time, increase clueCount by 1.
	When Investigation begins:	
		Now the description of the power box is "It provides electricity to the house. It seems to have been smashed by something".
	When Investigation ends:
		Now the description of the power box is "It provides electricity to the house".
											
	[Kitchen]
	The microwave is a container.
		The microwave is in the Kitchen.
		The microwave is fixed in place.
		The microwave contains a ham sammich.
		The sammich is edible.
		After eating the sammich, say "Maybe that was a bad idea. This is a crime scene, not a buffet.".
	
	The card is an Evidence.
		The description is "Pretend this card says something meaningful." [TODO]
		The card is in the Kitchen.
		After examining the card for the first time, increase clueCount by 1.
	
	The refrigerator is a container.
		The refrigerator is fixed in place.
		The refrigerator is in the Kitchen.
		The refrigerator is enterable.
		Understand "fridge" as refrigerator.
		milk is a thing.
		The description is "The expiration date says 6/06. Yuck."
		The refrigerator contains the milk.
		Instead of drinking milk, say "Not with that expiration date you're not.".
		After entering the refrigerator:
			say "Your attempt to catch the door light as it turns off is a success. But now you're cold and it's dark in here."
		Instead of looking under the refrigerator for the first time:
			Now the card is in the Kitchen;
			say "You see a card here."
				
	The oven is a container.
		The oven is in the Kitchen.
		The oven is fixed in place.
		The oven contains an apple pie.
		The apple pie is edible.
		After eating the apple pie, say "Maybe that was a bad idea. But a delicious one."
		
	The spilled cup is a thing.
		The spilled cup is in the Kitchen.
		The description is "Smells of alcohol."
		After examining the spilled cup for the first time, increase clueCount by 1.

	The dark stain is a thing.
		The dark stain is in the Kitchen.
		Instead of taking the dark stain, say "Do you even know how stains work?"
		After examining the dark stain for the first time, increase clueCount by 1.
		
	The beer cabinet is a container.
		The beer cabinet is in the Kitchen.
		The beer cabinet is openable.
		After opening the beer cabinet, say "Hmm. Looks like someone drank all the alcohol."
	[Back Yard]
															
	[Upstairs]
	
																	
	[Master Bedroom]
	The desk is a container.
		The desk is in the Master Bedroom.
		The description is "A wooden desk with drawers."
		The desk is fixed in place.
		The desk is openable.
		The desk is closed.

	The desk contains a cell phone.
		The cell phone is Evidence.
		The description of the cell phone is "There appear to be the contacts of various drug dealers here.".
		After examining the cell phone for the first time, increase clueCount by 1.
	
	The guy is a person.
		The guy is in the Master Bedroom.
		The guy is fixed in place.
		The deathStatus of the guy is "alive".
		Instead of attacking the guy:
			Say "Kill with what?";
		Instead of killing the guy:
			if Investigation is the Current Scene
			begin;
				Say "That wouldn't be very... professional.";
			otherwise if Murder is the Current Scene;
				if the deathStatus of the guy is "alive" AND the second noun is the machete
				begin;
					Say "After covering the man's mouth, you slit his neck with the [the second noun]. His screams are muffled by your hand and the blood running down his throat. He dies almost instantly.";
					Now the deathStatus of the guy is "dead";
					Now the deathFlag is 1;
				otherwise if the deathStatus of the guy is "dead";
					Say "That doesn't seem necessary.";
				end if;
			otherwise if Staging is the Current Scene;
				Say "Playing with dead bodies isn't really your thing.";
			end if;
		Instead of talking the guy:
			if Investigation is the Current Scene
			begin;
				Say "You wouldn't want your co-workers to think you're crazy. Would you?";
			otherwise if Murder is the Current Scene;
				Say "Despite your best efforts, you can't summon the courage to say something.";
			otherwise if Staging is the Current Scene;
				Say "You couldn't talk before, why would you be able to do that now.";
			end if;
			
	When Investigation begins:
		Now the deathStatus of the guy is "dead";
		
	When Murder begins:
		Now the deathStatus of the guy is "alive";
		
	When staging begins:
		Now the deathStatus of the guy is "dead";
																			
	[Child's Bedroom]
	The child's bed is a thing.
		The bed is in the Child's Bedroom.
		The description of the child's bed is "The child's bed looks normal.".
		The child's bed is fixed in place.
		Instead of smelling the bed:
			Say "[if the smell of the noun is not empty]It smells [the smell of the noun].[paragraph break][otherwise]You smell nothing unexpected.[end if]".
	
	The alarm clock is a thing.
		The alarm clock is in the Child's Bedroom.
		The description of the alarm clock is "An ordinary alarm clock. It's set to go off at 6:06 am.".
		The alarm clock is fixed in place.
		
	The math textbook is a thing.
		The description of the math textbook is "You flip through the textbook. It appears as if someone has poorly drawn some genitals on page 606."
		Instead of reading the math textbook, say "Consider the function f(x) = 606. What kind of line would this make? Regardless of what values of x are inputed into the function, the only value of f(x) that ever comes out is 606. Therefore, this function would be graphed as a horizontal line, where each point on the line is at y = 606.".
	The biology textbook is a thing.
	The civics textbook is a thing.
	
	The backpack is a container.
		The backpack is in the Child's Bedroom.
		The description of the backpack is "An Avengers backpack. It contains Math 6, Biology, and Civics textbooks.". 
		After examining the backpack for the first time:
			Now the backpack contains the math textbook;
			Now the backpack contains the biology textbook;
			Now the backpack contains the civics textbook;
		
	The family photo is a thing. [Don't place this until player x's the bookshelf]
		The description is "A family of four. The photo is torn such that the father's face is ripped out."
	
	The post-it note is a thing.
		The description of the post-it note is "A text scribbled on a post-it note. It appears to say '4ceBew1thYou'. [if we have not examined the post-it note for the first time]It could be a password for something[end if]".
		Instead of reading the post-it note:
			Say "'4ceBew1thYou''";
		
	The bookshelf is a thing.
		The bookshelf is in the Child's Bedroom.
		The bookshelf is fixed in place.
		Understand "shelf" as the bookshelf.
		After examining the bookshelf:
			Now the family photo is in the Child's Bedroom;
			Now the laptop is unlocked;
			if Investigation is the Current Scene
			begin;
				Now the player is carrying the post-it note;
				say "A post-it note falls into your hands as you looked through the books.";
			end if;
		
	When Investigation begins:
		Now the description of the bookshelf is "A wooden bookshelf. It has some books, a family photo, and Legos.";
			
	When Investigation ends:
		Now the description of the bookshelf is "";
		
	When Murder begins:
		Now the smell of the child's bed is "faintly of urine";
		Now the description of the bookshelf is "A wooden bookshelf. It has the Hunger Games and Percy Jackson series neatly aligned on its third shelf. The other shelves are filled with Star Wars Legos and photos.";
		Now the description of the family photo is "A family of four. An infant daughter is on the far left next to her mother. The father is on the far right and has placed his arm on his son's knee. The son is sitting cross-legged evenly between his mother and his father. Nobody seems thrilled to be in the photo.";
		
	[When Murder ends:
		Now the smell of the child's bed is "";
		Now the description of the bookshelf is "";
		Now the description of the family photo is "";]
																							
								

	
	
	