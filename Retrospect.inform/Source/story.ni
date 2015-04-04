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

[forward declaration hack for murder event to trigger scene change]
The deathFlag is a number that varies.
The deathFlag is 0.

[number of clues found]
The clueCount is a number that varies.
The clueCount is 0.

[number of items staged]
The stagingCount is a number that varies.
The stagingCount is 0.

After deciding the scope of the player:
	Now the Score is 0;
	Increase the Score by clueCount;
	Increase the Score by stagingCount;
	[The Score is add clueCount AND stagingCount.]

A thing has some text called content. 
	The content of a thing is usually "".	
A thing has some text called smell.
A thing has some text called deathStatus.
	The deathStatus of a thing is usually "alive".
	

Current Scene is a scene that varies.

[DEF SCENES]
Investigation is a scene.
	Investigation begins when the player is in the Front Yard for the first time.
	[Investigation ends when Investigation begins.]
	
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
	
The Back Door is a door.
	Instead of picking the Back Door:
		Say "Picking... (press random keys)[line break]";
		while the sentinel is on
		begin;
			Wait for any key;
			Say "[if a random chance of 1 in 2 succeeds]*click*[otherwise]*clank*[end if][line break]";
			if a random chance of 1 in 5 succeeds [this is the shittiest RND I've ever seen]
			begin;
				Say "Done.";
				Now the Back Door is unlocked;
				stop;
			end if;
		end while;
		
The Front Door is a door.
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
				Now the Front Door is unlocked;
				stop;
			end if;
		end while;

[DEF ROOM LOCATIONS]
Living Room is north of Front Door.
Garage is east of Living Room.
Kitchen is north of Living Room.
Kitchen is south of the Back Door.
Upstairs is above Kitchen.
Back Yard is north of	Back Door.
Master Bedroom is east of Upstairs.
Child's Bedroom is south of Upstairs.

The Front Door is north of the Front Yard and south of the Living Room.
The Back Door is north of the Kitchen and south of Back Yard.

When Investigation begins:
	Now the Front Door is unlocked;
	Now the Back Door is unlocked;

When Murder begins:
	Now the Front Door is locked;
	Now the Back Door is locked;

[DEF INVENTORY]
The pick gun is a thing.
	The description is "A pick gun. Pick guns can be used to unlock most residential locks.".
	The pick gun unlocks the Back Door.
	The pick gun unlocks the Front Door.
	
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
	
	The bushes are a container.
		The bushes are in the Front Yard.
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
	The couch is  a thing.
		The couch is in the Living Room.
		The description is "Just a couch".

		
		
	The TV is an Evidence.
		The TV is in the Living Room.
		The description is "An old television. It doesn't seem to be working".
		
		
									
	[Garage]
	The car is a container.
		The car is in the Garage.
		The car is fixed in place.
		The description is "A Toyota. Must be at least 20 years old".
		The car is enterable.
		
	The tool bench is a thing.
		The tool bench is in the Garage.
		The tool bench is fixed in place.
		The description is "An old rusty tool bench.".
		The tool bench contains a wrench, a screwdriver, a hand drill, and a hammer.
		The hand drill is an Evidence.
		The wrench is an Evidence.
		The screwdriver is an Evidence.
		The hammer is an Evidence.
		
	The power box is a thing.
		The power box is in the Garage.
		The power box is fixed in place.
		The description is "It provides electricity to the house. It seems to have been smashed by something".
											
	[Kitchen]
	The microwave is a container.
		The microwave is in the Kitchen.
		The microwave contains a ham sammich.
		The sammich is edible.
	
	The refrigerator is a container.
		The refrigerator is in the Kitchen.
		The refrigerator is fixed in place.
		The refrigerator is enterable.
		Understand "fridge" as refrigerator.
		milk is a thing.
		The description is "Looks like it expired a couple weeks ago. Yuck."
		The refrigerator contains the milk.
		Instead of drinking milk, say "Not with that expiration date you're not.".
		After entering the refrigerator:
			say "Your attempt to catch the door light as it turns off is a success. But now you're cold and it's dark in here."
		
	The oven is a container.
		The oven is in the Kitchen.
		The oven is fixed in place.
		The oven contains an applie pie.
		The apple pie is edible.
		
	The spilled cup is a thing.
		The spilled cup is in the Kitchen.

	The dark stain is a thing.
		The dark stain is in the Kitchen.
		Instead of taking the dark stain, say "Do you even know how stains work?"
	[Back Yard]
															
	[Upstairs]
	
																	
	[Master Bedroom]
	The desk is a container.
		The desk is in the Master Bedroom.
		The description is "A wooden desk with drawers."
		The desk is fixed in place.
		The desk is closed.
	
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
		The description of the alarm clock is "An ordinary alarm clock. It's set to go off at 7:10 am.".
		The alarm clock is fixed in place.
		
	The backpack is a thing.
		The backpack is in the Child's Bedroom.
		The description of the backpack is "An Avengers backpack. It contains Math 6, Biology, and Civics textbooks.". 
		
	The family photo is a thing.
	
	The note is a thing.
		The description of the note is "A text scribbled on a Post-It note.".
		The content of the note is "4ceBew1thYou".
		Instead of reading the note:
			Say "The [noun] reads '[the content of the noun]'";
		
	The bookshelf is a thing.
		The bookshelf is in the Child's Bedroom.
		The bookshelf is fixed in place.
		After examining the bookshelf:
			Now the family photo is in the Child's Bedroom;
			if Investigation is the Current Scene
			begin;
				Now the note is in the Child's Bedroom;
			end if;
		
	When Investigation begins:
		Now the description of the bookshelf is "A wooden bookshelf. It has some books, photos, and Legos.";
		
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
																							
									
	Understand the command "pwd" as "look".
	Understand the command "ls" as "inventory".
	[Understand the command "sudo update-initramfs" as "leveling up".]
 	 Understand the command "cd" as "go".
	Understand the command "echo" as "say".
	 [Understand "cd .." as "up".]



	
	
