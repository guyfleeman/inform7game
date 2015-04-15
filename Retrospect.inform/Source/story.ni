 [helpful links
	-Action Syntax Guide: 		http://inform7.com/learn/documents/I7_syntax.txt
	-Implied Object Structure: http://www.ifwiki.org/index.php/Inform_7_for_Programmers/Part_1
]

"Retrospect" by "GroopOfFore"

Include Basic Help Menu by Emily Short.
Include Basic Screen Effects by Emily Short.

[DEF ABSTRACTIONS]

[DEF ACTIONS]
Destroying is an action applying to one thing.
	Understand "destroy" as destroying.
	Understand "break" as destroying.
	Understand "annihilate" as destroying.

Being is an action applying to one thing.
	Understand "be" as being.

Using is an action applying to one thing.
	Understand "use" as using.
	
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

Hiding is an action applying to one carried thing and a thing.
	Understand "hide [something preferably held] under [thing]" as hiding.
	Understand "hide [something preferably held] in [thing]" as hiding.

Turning On is an action applying to one thing.
	Understand "turning on [thing]" as switching on.
	
Turning Off is an action applying to one thing.
	Understand "turning off [thing]" as switching off.
	
Password Unlocking is an action applying to one thing.
	Understand "password unlock [thing]" as password unlocking. 
	
Pouring is an action applying to two things.
	Understand "pour [something preferably held] into [thing]" as pouring.
	Understand "pour [something preferably held] in [thing]" as pouring.
	
Tying is an action applying to two things.
	Understand "tie [thing] with [something preferably held]" as tying.
	
[DEF ACTION OVERRIDES]
Instead of taking something:
	if Murder is the Current Scene
	begin;
		Say "You have a job to do. Now isn't the time.";
	end if;
	
[DEF GLOBAL VARS]
The Maximum Score is 20. [2x num of clues (whatever that becomes)]
The Score is 0.
Use scoring.

The stageCount is a number that varies.
The stageCount is 0.

The stagingPassedCutoff is a number that varies.
The stagingPassedCutoff is 7;

The clueCount is a number that varies.
The clueCount is 0.

The investigationPassedCutoff is a number that varies.
The investigationPassedCutoff is 7;

The clueFlag is a number that varies.
The clueFlag is 0.

The deathFlag is a number that varies.
The deathFlag is 0.

[DEF PROPERTIES]
A thing has some text called content. 
	The content of a thing is usually "".	
A thing has some text called smell.
A thing has some text called deathStatus.
	The deathStatus of a thing is usually "alive".
A thing has some text called discoveredStatus.
	The discoveredStatus of a thing is usually "false".
A thing has some text called stagedStatus.
	The stagedStatus of a thing is usually "false".
	
[DEF SCENES]
Current Scene is a scene that varies.

Investigation is a scene.
	Investigation begins when the player is in the Front Yard for the first time.
	Investigation ends when Investigation is the Current Scene AND the clueFlag is 1.
	[Investigation ends when Investigation begins.]
	
Murder is a scene.
	Murder begins when Investigation ends.
	Murder ends when Murder is the Current Scene AND the deathFlag is 1.
	[Murder ends when Murder begins.]
	
Staging is a scene.
	Staging begins when Murder ends.
	
The Current Scene is Investigation.

When Investigation ends:
	Now the Current Scene is Murder;
	Clear the screen;
	
When Murder begins:
	Move the player to the Back Yard;

When Murder ends:
	Now the Current Scene is Staging;

[DEF ROOMS/DOORS]
Front Yard is a room.
Living Room is a room.
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
	The back door can be broken or not broken.
	When Investigation begins:
		Now the back door is broken;
	When Murder begins:
		Now the back door is not broken;
	Instead of picking the back door:
		Say "Picking... (press random keys)[line break]";
		while the sentinel is on
		begin;
			Wait for any key;
			Say "[if a random chance of 1 in 2 succeeds]*click*[otherwise]*clank*[end if][line break]";
			if a random chance of 1 in 5 succeeds [this is the best RND I've ever seen]
			begin;
				Say "Done.";
				Now the back door is unlocked;
				stop;
			end if;
		end while;
		
The front door is a door.
	The front door can be broken or not broken.
	When Investigation begins:
		Now the front door is broken.
	When Murder begins:
		Now the front door is not broken.
	The description is "The front door is black and made of oak.[if the front door is broken]The window on the door has been smashed.[end if][if the front door is unlocked] It's unlocked[end if]".
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
			if stageCount > stagingPassedCutoff
			begin;
				End the story;
			otherwise;
				Say "You aren't ready to leave yet. Perhaps you should stage more clues.";
			end if;
		end if;

[DEF ROOM LOCATIONS]
Living Room is north of front door.
Garage is east of Living Room.
Garage is west of Living Room.
Kitchen is north of Living Room.
Upstairs is above Kitchen.
Back Yard is north of Back Door.
Master Bedroom is east of Upstairs.
Child's Bedroom is south of Upstairs.

The front door is north of the Front Yard and south of the Living Room.
The back door is north of the Kitchen and south of Back Yard.
The fence gate is north of the Back Yard.

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
	
The email drafts are a thing.
	The indefinite article is "some".
	The description is "Email drafts alluding to a drug buy.".
	
The zip ties are a thing.
	The indefinite article is "some".
	The description is "Black industrial zip ties.".
	
The vial is a thing.
	The description is "A vial of Ketamine.".
	
The needle is a thing.
	The description is "An empty needle.".
	
The scale is a thing.
	The description is "A scale with decimals of precision.".
	
Your phone is a thing.
	The player is carrying your phone.
	Instead of dropping your phone, say "You won’t risk that until you’ve bought a case for it.".
	
Your clothes are a thing.
	The description is "Just a typical suit. Your shoes look like they need to be polished."
	The player is carrying your clothes.
	Instead of dropping your clothes, say "Nudity is not acceptable in this society.".
	Instead of eating your clothes, say "You put your sleeve in your mouth and bite down. There are now teeth marks on your arm.[if the player is in the front yard] The police officer looks at you and raises his eyebrow.[end if]".

[inv inits]
When Murder begins:
	Now the player has the pick gun;
	Now the player has the burner phone;
	Now the player has the machete;
	Now the player has the email drafts;
	Now the player has the zip ties;
	Now the player has the vial;
	Now the player has the needle;
	Now the player has the scale.

[DEF SCENERY]
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
	
	[Back Yard]
	This house is in the Back Yard.
		The house is scenery.
		The description is "The house is two stories with a shale facade and brushed bronze accents.".

	The backdoor is in the Back Yard.
		The back door is scenery.
		The description is "The back door hangs on one hinge, its lock splintered. It swings slowly in the breeze, sometimes banging into the side of the house.".
		
		
	The field is in the Back Yard.
		The field is scenery.
		The description is "The field is a display of vibrant, unmowed grass speckled with purple and yellow wildflowers. The landscape hazily reminds you of happier summers gone by.".
		
	The shovel is in the Back Yard.

	The fence is in the Back Yard.
		The fence is scenery.
		The description is "A tan picket fence delineates the yard's perimeter.  Its frame is wrapped in thin vines of honeysuckle, with bumblebees flitting around their blooms.  There is a gate to the north of the yard.".
	
	The flowerbed is in the Back Yard.
		The description is "Tulips. Your least favorite flower."
	
	[Upstairs]
	
	[Master Bedroom]
	The desk is a container.
		The desk is in the Master Bedroom.
		The desk is openable.
	
	[Child's Bedroom]
	The window is in the Child's Bedroom.
		The window is scenery.
		The description is "A pine forest can be seen. Just past the edge of the forest, you can see a duck blind.".
		
[DEF OBJECTS]

[DEF DEBUG]
	The debugFlag is a number that varies.
		The debugFlag is 1.
	The tempScore is a number that varies.
		The tempScore is 0.

[dynamic surroundings
		tracks the location/scope of the player and updates its position
		allowing the government to always 'examine surroundings'.]
	The surroundings are a thing.
	The indefinite article is "some".
	After deciding the scope of the player:
		Place the surroundings in scope;
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
			Say "You see an earthy house surrounded by a forest. There are several objects that would ordinarily belong in a front yard."
		instead;
		if the player is in the Living Room,
			Say "Not many objects for a living room besides a couch and TV. The couch has some tears in it and parts of the wall are torn[if Investigation is the current scene]The couch seems to be positioned such that you could see the kitchen, garage door, and front door when you sit down.[otherwise]It would be hard to get through this room without being seen by someone sitting in the couch. You have a strange urge to avoid going between the couch and TV."
		instead;
		if the player is in the Garage,
			Say "A standard garage containing a car, some tools, and pipes. You notice some termite holes in the walls and ceiling.[if Murder is the current scene or Staging is the current scene]You immediately try to open the door, it's as if i you are used to it being locked."
		instead;
		if the player is in the Kitchen,
			Say "Your average kitchen with a refrigerator and refrigerator.[if Investigation is the current scene]You  can also see an old rusty dog bowl, but there are no other signs of a dog around here.[otherwise]You see a dog bowl, it's not too hard for you to beleive that it could serve as a bowl for a person. Maybe even a child."
		instead;
		if the player is in the Upstairs,
			Say "[if Investigation is the current scene]An average hallway with a few pictures hanging on the wall.[otherwise]You try to take a look at some of the pictures hanging on the wall. You clench your teeth looking at the man's smug grin. The child's face gives you a chill down your spine."
		instead;
		if the player is in the Back Yard,
			Say "You see a field of vibrant, unmowed grass surrounded by forest dense enough to shroud the yard from all other signs of civilization.  From there the house seems like a haven, hidden away from the rest of humanity."
		instead;
		if the player is in the Master Bedroom,
			Say "The large bed and desk are the only two significant furniture in here. [if Investigation is the current scene]Even working your whole life as P.I. you still can't get over the smell of dead corpes.[otherwise]The room feels small, or is that just you?"
		instead;
		if the player is in the Child's Bedroom,
			Say "[if Investigation is the current scene]There is a small bed and a bookshelf. No reason for any criminal activity in here.[otherwise]You look under the bed's pillow and see it's stained with blood. You shake your head and realize it's just your imagination."
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
			Say "Garage list"
		instead;
		if the player is in the Kitchen,
			Say "Kitchen list"
		instead;
		if the player is in the Upstairs,
			Say "Upstairs list"
		instead;
		if the player is in the Back Yard,
			Say "You can see the house, its back door, a field, a swing set, a fence, a flower bed, and a pond."
		instead;
		if the player is in the Master Bedroom,
			Say "Master Bedroom list"
		instead;
		if the player is in the Child's Bedroom,
			Say "Child's Room list"
		instead;
	Instead of taking the surroundings:
		Do nothing.
		
	[Front Yard]	
	The police officer is in the Front Yard.
		The police officer is a person.
		The description is "Just your everyday typical police officer."
		The police officer is fixed in place.
		Instead of talking the police officer:
			if Investigation is the Current Scene
			begin;
				if clueCount > investigationPassedCutoff 
				begin;
					Say "Looks like this one is turning out to be pretty cut and dry. [if score > 4] Clearly t[otherwise]T[end if]his guy was offed by a local cartel. We'll get some more detectives down here to figure out which group was responsible for this butchery.";
					Now the clueFlag is 1;
				otherwise;
					Say "You'd better keep looking for clues instead of chitchatting or the chief is gonna get pissed.";
				end if;
			end if;
		When Murder begins:
			Now the police officer is in the pond;
	
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
		Instead of taking the nozzle:
			Now the player has the nozzle;
			Say "You take the nozzle.";
		
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
				end if;		
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
	The couch is a thing.
		Understand "sofa" as the couch.
		The couch is in the Living Room.
		The description is "Just a couch".
		Instead of taking the couch:
			If Staging is the current scene
			begin;
				Say "Houses typically have couches";
			otherwise;
				continue the action;
			end if;
		
	The TV is a thing.
		Understand "Television" as the TV.
		The TV is in the Living Room.
		The description is "An old television. It doesn't seem to be working".
		
	[Garage]
	The hood is a thing.
		The hood is fixed in place.
		The description is "The hood is slightly open. I wonder if there's anything underneath.".
		The crystal meth is a thing.
		Instead of looking under the hood for the first time:
			Now the crystal meth is in Garage;
			say "You lift the hood open. Underneath, you find a small compartment filled with crystal meth.".
		The description of crystal meth is "Crystal meth is a heavy drug. Worth a lot of money too.".
		After examining the crystal meth:
			increase the clueCount by 1.

	The keyring is a thing.
		When Investigation begins:
			Now the keyring is in the car;
		Instead of taking the keyring:
			Now the player has the keyring;
			Say "You take the keyring.";

	The car is a container.
		The car is in the Garage.
		The car is fixed in place.
		The description is "A Toyota. Must be at least 20 years old".
		The car is enterable.
		The car is openable.
		The car is closed.
		After examining the car for the first time:
			Now the hood is in the Garage;
			say "The hood of the car is slightly ajar.".
		
	The hand drill is a thing.
		The description is "A common household tool.".
	The wrench is a thing.
		The description is "A common household tool".
	The screwdriver is a thing.
		The description is "A common household tool".
	The hammer is a thing.
		The description is "A common household tool.".
		
	The tool bench is a thing.
		The tool bench is in the Garage.
		The tool bench is fixed in place.
		The description is "An old rusty tool bench.".
		The tool bench contains a wrench, a screwdriver, a hand drill, and a hammer.
		
	The power box is a thing.
		The power box is in the Garage.
		The power box is fixed in place.
		The power box can be broken or not broken.
		
	When Investigation begins:	
		Now the description of the power box is "It provides electricity to the house. It seems to have been smashed by something";
		Now the power box is broken;
	When Investigation ends:
		Now the description of the power box is "It provides electricity to the house";
		Now the power box is not broken;
	Instead of attacking the power box:
		if Investigation is the current scene
		begin;
			Say "It's already broken.";
		otherwise if Murder is the current scene;
			Say "It's probably not wise to do that right now.";
		otherwise if Staging is the current scene;
			if the second noun is the machete or the second noun is the hammer
			begin;
					Say "The power box gives off a small burst of sparks, but it looks like [the second noun] did the trick.";
					Now the power box is broken;
			otherwise;
				Say "You will need to find a stronger weapon";
			end if;
		end if;
											
	[Kitchen]
	The microwave is a container.
		The microwave is in the Kitchen.
		The microwave is fixed in place.
		The microwave contains a ham sammich.
		The sammich is edible.
		After eating the sammich:
			say "Maybe that was a bad idea. This is a crime scene, not a buffet.";
			decrease score by 1.
	
	The refrigerator is a container.
		The refrigerator is fixed in place.
		The refrigerator is in the Kitchen.
		The refrigerator is enterable.
		Understand "fridge" as refrigerator.
		milk is a thing.
		The description is "The expiration date says 606. Yuck."
		The refrigerator contains the milk.
		Instead of drinking milk, say "Not with that expiration date you're not.".
		After entering the refrigerator:
			Say "Your attempt to catch the door light as it turns off is a success. But now you're cold and it's dark in here.";
			Decrease score by 1.
				
	The oven is a container.
		The oven is in the Kitchen.
		The oven is fixed in place.
		The oven contains an apple pie.
		The apple pie is edible.
		After eating the apple pie:
			say "Maybe that was a bad idea. But a delicious one.";
			decrease score by 1.
		
	The spilled cup is a thing.
		The spilled cup is in the Kitchen.
		The description is "Smells of alcohol."

	The dark stain is a thing.
		The dark stain is in the Kitchen.
		Instead of taking the dark stain, say "Do you even know how stains work?"
	
	[Back Yard]
	The swingset is a thing.
		The swingset is in the Back Yard.
		The description is "Two swings hang from an old wooden frame[if the swingset is not broken] by rusty chains. They sway and creak in the wind.[otherwise], each by a single chain. They drag on the ground as they sway in the wind.".
		The swingset can be broken or not broken.
		The swingset is not broken.
		Instead of swinging:
			if the swingset is not broken
			begin;
				Say "You decide to swing on a swing. Unsurprisingly, it breaks under your weight. You give the other swing a try, and once again you fall to the ground.";
				Now the swingset is broken;
			otherwise;
				Say "You already broke the swingset.";
			end if;
										
	[Upstairs]
	
																	
	[Master Bedroom]
	The desk is a container.
		The desk is in the Master Bedroom.
		The description is "A wooden desk with drawers."
		The desk is fixed in place.
		The desk is openable.
		The desk is closed.
		The desk is locked.
		When Investigation begins:
			Now the vial is in the desk;
		When Murder begins:
			Now the desk is unlocked;
		
	The left drawer is a container.
		The left drawer is in the Master Bedroom.
		The left drawer is fixed in place.
		The left drawer is openable.
		The left drawer is closed.
	
	The right drawer is a container.
		The right drawer is in the Master Bedroom.
		The right drawer is fixed in place.
		The right drawer is openable.
		The right drawer is closed.
	
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
		Now the guy is in the pond;
		
	When Murder begins:
		Now the deathStatus of the guy is "alive";
		Now the guy is in the Master Bedroom;
		
	When staging begins:
		Now the deathStatus of the guy is "dead";
		Now the guy is in the pond;
																			
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
		The description of the math textbook is "You flip through the textbook. There are some poorly drawn genitals on page 606."
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
		
	The family photo is a thing.
		The description is "A family of four. The photo is torn such that the father's face is ripped out."
	
	The post-it note is a thing.
		The description of the post-it note is "A text scribbled on a post-it note. It appears to say '4ceBew1thYou'. [if we have not examined the post-it note for the first time]It could be a password for something[end if]".
		Instead of reading the post-it note:
			Say "'4cebew1thYou''";
		
	The bookshelf is a thing.
		The bookshelf is in the Child's Bedroom.
		The bookshelf is fixed in place.
		Understand "shelf" as the bookshelf.
		After examining the bookshelf:
			Now the family photo is in the Child's Bedroom;
			Now the post-it note is in the Child's Bedroom;
		
	When Investigation begins:
		Now the description of the bookshelf is "A wooden bookshelf. It has some books, a family photo, and Legos.";
			
	When Investigation ends:
		Now the description of the bookshelf is "";
		
	When Murder begins:
		Now the smell of the child's bed is "faintly of urine";
		Now the description of the bookshelf is "A wooden bookshelf. It has the Hunger Games and Percy Jackson series neatly aligned on its third shelf. The other shelves are filled with Star Wars Legos and photos.";
		Now the description of the family photo is "A family of four. An infant daughter is on the far left next to her mother. The father is on the far right and has placed his arm on his son's knee. The son is sitting cross-legged evenly between his mother and his father. Nobody seems thrilled to be in the photo.";
		
[DEF EVIDENCE]

[Front Yard]
[door smash]

[Living Room]
[
The ketamine powder is a thing.
	Instead of looking under the couch:
		if Investigation is the Current Scene
		begin;
			Say "You found some ketamine powder under the couch.";
			if discoveredStatus of the ketamine powder is "false"
			begin;
				Increase the clueCount by 2;
				Now the discoveredStatus of the ketamine powder is "true";
			end if;
		otherwise if Murder is the Current Scene;
			Say "You find nothing of interest.";
		otherwise if Staging is the Current Scene;
			if stagedStatus of the ketamine powder is "true"
			begin;
				Say "You see some ketamine powder.";
			otherwise;
				Say "You find nothing of interest.";
			end if;
		end if;
	Before inserting the ketamine powder into the couch:
		if Murder is the Current Scene
		begin;
			Say "You have more important things to focus on right now.";
			Reject the Player's command;
		end if;
	After inserting the ketamine powder into the couch:
		if Staging is the Current Scene
		begin;
			If the stagedStatus of the ketamine powder is "false"
			begin;
				Increase stageCount by 2;
				Now the stagedStatus of the ketamine powder is "true";
			end if;
		end if;
]

The glass shards are a thing.
	The description is "The glass shards indicate someone broke into the home through the front door. The shards have an unusual pattern.".
	When Investigation begins:
		Now the glass shards are in the Living Room;
	When Murder begins:
		Now the glass shards are in the pond;
	After examining the glass shards for the second time:
		Say "The glass shards are collected in one localized area and direction.";
	After examining the glass shards for the third time:
		Say "The glass shards clearly indicate the door was broken inward. This must be a point of entry.";
		if the discoveredStatus of the glass shards is "false"
		begin;
			Increase the clueCount by 2;
			Now the discoveredStatus of the glass shards is "true";
		end if;
	Instead of attacking the front door:
		if the front door is broken
		begin;
			Say "The door is already broken.";
		otherwise;
			if Murder is the Current Scene
			begin;
				Say "I wouldn't do that. It might wake someone up.";
			otherwise if Staging is the current scene;
				Say "You smash the door's window with your elbow.";
				if the player is in the Front Yard
				begin;
					Say "The debris flies inward.";
					if the stagedStatus of the glass shards is "false"
					begin;
						Increase the stageCount by 2;
						Now the stagedStatus of the glass shards is "true";
					end if;
				end if;
			end if;
		end if;
		
The reminder is a thing.
	The description of the reminder is "s@v3th3ch1ldr3n".
	
The laptop is a thing.
	The description is "A modest HP Laptop.".
	The laptop is in the Living Room.
	The laptop can be locked or unlocked.
	The laptop is locked.
	Instead of password unlocking the laptop:
		Now the command prompt is "Enter Password: ".
		After reading a command when the command prompt is "Enter Password: ":
			if Investigation is the Current Scene
			begin;
				if the Player's command matches "4cebew1thyou"
				begin;
					Say "Access Granted.";
					Now the laptop is unlocked;
					Now the command prompt is ">";
				otherwise;
					Say "Access Denied.";
					Now the command prompt is ">";
					Reject the Player's command;
				end if;
			otherwise if Murder is the Current Scene;
				Say "You have more important things to focus on right now.";
			otherwise if Staging is the Current Scene;
				if the Player's command matches "s@v3th3ch1ldr3n"
				begin;
					Say "Access Granted.";
					Now the laptop is unlocked;
					Now the command prompt is ">";
				otherwise;
					Say "Access Denied.";
					Now the command prompt is ">";
					Reject the Player's command;
				end if;
			end if;
	When Investigation begins:
		Now the laptop is locked.
	When Murder begins:
		Now the laptop is locked.
	Instead of examining the laptop:
		if the laptop is unlocked
		begin;
			if Investigation is the Current Scene
			begin;
				Say "After a few minutes of looking through the owner's GMail account, you find some cryptic messages mentioning 'cat Valium' and 'jet'.";
				if the discoveredStatus of the laptop is "false"
				begin;
					Increase clueCount by 3;
					Now the discoveredStatus of the laptop is "true";
				end if;
			otherwise if Murder is the Current Scene;
				Say "A murdering investigator huh?"; [this should never happen so easter egg]
			otherwise if Staging is the Current Scene;
				Say "After looking though the owner's email, you find nothing out of the ordinary.";
			end if;
		otherwise;
			Say "A modest HP Laptop.";
		end if;
	Instead of looking under the laptop:
		If Staging is the Current Scene
		begin;
			Say "You find a reminder taped to the bottom of the laptop and you take it.";
			Now the player has the reminder;
		otherwise;
			Say "You find nothing here.";
		end if;
	Instead of inserting the email drafts into the laptop:
		if the laptop is unlocked
		begin;
			if the Investigation is the Current Scene
			begin;
				Say "How in the F&*% you did you do this?";
			otherwise if Murder is the Current Scene;
				Say "You have more important things to focus on right now.";
			otherwise if Staging is the Current Scene;
				Say "The email drafts have been entered into the IMAP record.";
				if the stagedStatus of the laptop is "false"
				begin;
					Increase the stageCount by 3;
					Now the stagedStatus of the laptop is "true";
				end if;
			end if;
		otherwise;
			Say "The laptop is currently locked.";
		end if;
			
[Kitchen]
The cabinets are a thing.
	The indefinite article is "some".
	The cabinets are in the Kitchen.
	The cabinets can be broken or not broken.
	When Investigation begins:
		Now the cabinets are broken;
	When Murder begins:
		Now the cabinets are not broken;
	Instead of attacking the cabinets:
		if Investigation is the Current Scene
		begin;
			Say "No need to beat a dead horse.";
		otherwise if Murder is the Current Scene;
			Say "You have more important things to focus on right now.";
		otherwise if Staging is the Current Scene;
			Say "You pull the contents off of the shelves of the cabinets, destroying everything.";
			Now the cabinets are broken;
			if the stagedStatus of the cabinets is "false"
			begin;
				Increase the stageCount by 1;
				Now the stagedStatus of the cabinets is "true";
			end if;
		end if;
	Instead of examining the cabinets:
		Say "[if the cabinets are not broken]The cabinets are made of dark wood with brushed bronze handles. They have glass panels so you can see all of the ceramic cookware behind them.[otherwise]The cabinets have been thoroughly ransacked.[end if]";
		if Investigation is the Current Scene
		begin;
			Say "It looks a though someone may have been looking for something. It's unclear of they found what they were looking for.";
			if the discoveredStatus of the cabinets is "false"
			begin;
				Increase the clueCount by 1;
				Now the discoveredStatus of the cabinets is "true";
			end if;
		end if;
			
The drawers are a thing.
	The indefinite article is "some".
	The drawers are in the Kitchen.
	The drawers can be broken or not broken.
	When Investigation begins:
		Now the drawers are broken;
	When Murder begins:
		Now the drawers are not broken;
	Instead of attacking the drawers:
		if Investigation is the Current Scene
		begin;
			Say "No need to beat a dead horse.";
		otherwise if Murder is the Current Scene;
			Say "You have more important things to focus on right now.";
		otherwise if Staging is the Current Scene;
			Say "You pull the contents off of the shelves of the drawers, destroying everything.";
			Now the drawers are broken;
			if the stagedStatus of the drawers is "false"
			begin;
				Increase the stageCount by 1;
				Now the stagedStatus of the drawers is "true";
			end if;
		end if;
	Instead of examining the drawers:
		Say "[if the drawers are not broken]The drawers are made of dark wood with brushed bronze handles. They have glass panels so you can see all of the ceramic cookware behind them.[otherwise]The drawers have been thoroughly ransacked.[end if]";
		if Investigation is the Current Scene
		begin;
			Say "It looks a though someone may have been looking for something. It's unclear of they found what they were looking for.";
			if the discoveredStatus of the drawers is "false"
			begin;
				Increase the clueCount by 1;
				Now the discoveredStatus of the drawers is "true";
			end if;
		end if;
	
The beer is a thing.
	When Murder begins:
		Now the beer is in the refrigerator.
	The description is "A delicious Angry Orchard Cinnful holiday special.".
	Instead of drinking the the beer:
		Say "You drink the cider and enjoy it refreshing balance of flavor.";
		Remove the beer from play;
	Instead of taking the beer:
		if Murder is the Current Scene
		begin;
			Say "You have more important things to focus on right now.";
		otherwise if Staging is the Current Scene;
			Say "You take the beer.";
			Now the player has the beer;
		end if;
	Instead of pouring the beer:
		if the second noun is the pond
		begin;
			Say "You waste a perfectly good cider by pouring it into the pond. Hmm... the catfish seem to like it.";
			if the stagedStatus of the beer is "false"
			begin;
				Increase the stageCount by 5;
				Now the stagedStatus of the beer is "true";
			end if;
		otherwise;
			Say "How frightfully un-couth.";
		end if;
		Remove the beer from play;
	
The refrigerator is a container.
	The refrigerator is in the Kitchen.
	The description is "A stainless steel refrigerator.".
	The refrigerator is openable.
	The refrigerator is unlocked.
	The refrigerator is closed.
	
The glass pieces are a thing.
	The description is "The glass pieces indicate someone broke into the home through the back door. The pieces have an unusual pattern.".
	When Investigation begins:
		Now the glass pieces are in the Kitchen;
	When Murder begins:
		Now the glass pieces are in the pond;
	After examining the glass pieces for the second time:
		Say "The glass pieces are collected in one localized area and direction.";
	After examining the glass pieces for the third time:
		Say "The glass pieces clearly indicate the door was broken inward. This must be a point of entry.";
		if the discoveredStatus of the glass pieces is "false"
		begin;
			Increase the clueCount by 2;
			Now the discoveredStatus of the glass pieces is "true";
		end if;
	Instead of attacking the back door:
		if the back door is broken
		begin;
			Say "The door is already broken.";
		otherwise;
			if Murder is the Current Scene
			begin;
				Say "I wouldn't do that. It might wake someone up.";
			otherwise if Staging is the current scene;
				Say "You smash the door's window with your elbow.";
				if the player is in the Back Yard
				begin;
					Say "The debris flies inward.";
					if the stagedStatus of the glass pieces is "false"
					begin;
						Increase the stageCount by 3;
						Now the stagedStatus of the glass pieces is "true";
					end if;
				end if;
			end if;
		end if;

[Garage]
The power box is a thing.

[Back Yard]
The footprints are a thing.
	The footprints are in the backyard.
	The description is "Some footprints have been left in the muddier areas of lawn.".
	Instead of examining the footprints:
		if Investigation is the Current Scene
		begin;
			Say "Some footprints have been left in the muddier areas of lawn. You wonder if they match any other footprints in the home.";
		otherwise;
			Say "Some footprints have been left in the muddier areas of lawn.";
			if the discoveredStatus of the footprints is "false"
			begin;
				Increase the clueCount by 1;
				Now the discoveredStatus of the footprints is "true";
			end if;
		end if;
		
The pond is thing.
	The pond is in the Back Yard.	
	The description is "A small pond lies in the middle of the lush grass. Shimmering bass swim in its clear, green water.[if we have not examined the pond] You spot a catfish lurking deep in the pool.[end if]".
	Instead of examining the pond:
		Say "A small pond lies in the middle of the lush grass. Shimmering bass swim in its clear, green water.[if we have not examined the pond] You spot a catfish lurking deep in the pool.[end if]";
		if Investigation is the Current Scene
		begin;
			Say "The catfish seems to be swimming slowly today.";
			if the discoveredStatus of the beer is "false"
			begin;
				Increase the clueCount by 1;
				Now the discoveredStatus of the beer is "true";
			end if;
		end if;		

[Upstairs]
The blood streaks are a thing.
	The description is "Some blood streaks left by the shoes of the murderer.".
	When Investigation begins:
		Now the blood streaks are in the upstairs;
	When Murder begins:
		Now the blood streaks are in the pond;
	When Staging begins:
		Now the blood streaks are in the pond;
	Instead of examining the blood streaks:
		if Investigation is the Current Scene
		begin;
			Say "The blood streaks are leaving the master bedroom. Based on the spatter patterns, the person who left them didn't leave quickly. Perhaps he or she was injured in the struggle.";
			if the discoveredStatus of the blood streaks is "false"
			begin;
				Increase clueCount by 1;
				Now the discoveredStatus of the blood streaks is "true";
			end if;
		otherwise;
			Say "Some blood streaks left by the shoes of the murderer.";
		end if;

[Master Bedroom]
[body]
The body is a thing.
	When Investigation begins:
		Now the body is in the Master Bedroom;
	When Murder begins:
		Now the body is in the pond;
	When Staging begins:
		Now the body is in the Master Bedroom;
Instead of examining the body:
	if Investigation is the Current Scene
	begin;
		Say "The victim has been cut in the neck. His hands have also been tied with industrial zip ties.";
		if the discoveredStatus of the zip ties is "false"
		begin;
			Increase the clueCount by 1;
			Now the discoveredStatus of the zip ties is "true";
		end if;
	otherwise if Staging is the Current Scene;
		Say "The victim has been cut in the neck.";
	end if;
	Instead of tying the body:
		if the second noun is zip ties
		begin;
			if the stagedStatus of the body is "false"
			begin;
				Say "You tie the hands of the body with the zip tie.";
				Increase the stageCount by 1;
			end if;
		otherwise;
			Say "You can't do that.";
		end if;

[vial]
The keyring unlocks the desk.
Instead of examining the desk:
	if the desk is closed
	begin;
		Say "The desk is closed.";
	otherwise if the desk is locked;
		Say "The desk it locked.";
	otherwise;
		if Investigation is the Current Scene
		begin;
			Say "You find a vial under some paperwork.";
			if the discoveredStatus of the right drawer is "false"
			begin;
				Increase the clueCount by 3;
				Now the discoveredStatus of the right drawer is "true";
			end if;
		otherwise if Murder is the Current Scene;
			Say "You have more important things to focus on right now.";
		otherwise if Staging is the Current Scene;
			Say "You see some cluttered paper work and files.";
		end if;
	end if;
Before taking the vial:
	if Investigation is the Current Scene
	begin;
		Say "You shouldn't take evidence from an active crime scene.";
	end if;
Before inserting the vial into the left drawer:
	if Murder is the Current Scene
	begin;
		Say "You have more important things to focus on right now.";
		Reject the Player's command;
	end if;
Before inserting the vial into the right drawer:
	if Murder is the Current Scene
	begin;
		Say "You have more important things to focus on right now.";
		Reject the Player's command;
	end if;
Before inserting the vial into the desk:
	if Murder is the Current Scene
	begin;
		Say "You have more important things to focus on right now.";
		Reject the Player's command;
	end if;
After inserting the vial into the desk:
	if the stagedStatus of the vial is "false"
	begin;
		Increase the stageCount by 2;
		Now the stagedStatus of the vial is "true";
	end if;
After removing the vial from the desk:
	if the stagedStatus of the vial is "true"
	begin;
		Decrease the stageCount by 2;
		Now the stagedStatus of the vial is "false";
	end if;
When Investigation begins:
	Now the Vial is in the desk;
	Now the desk is closed;
	Now the desk is locked;
When Murder begins:
	Now the desk is closed;
	Now the desk is unlocked;

[scale]
Instead of examining the right drawer:
	if the right drawer is closed
	begin;
		Say "The drawer is closed.";
	otherwise;
		if Investigation is the Current Scene
		begin;
			Say "You find a scale under some paperwork.";
			if the discoveredStatus of the right drawer is "false"
			begin;
				Increase the clueCount by 1;
				Now the discoveredStatus of the right drawer is "true";
			end if;
		otherwise if Murder is the Current Scene;
			Say "You have more important things to focus on right now.";
		otherwise if Staging is the Current Scene;
			Say "You see some cluttered paper work and files.";
		end if;
	end if;
Before taking the scale:
	if Investigation is the Current Scene
	begin;
		Say "You shouldn't take evidence from an active crime scene.";
	end if;
Before inserting the scale into the left drawer:
	if Murder is the Current Scene
	begin;
		Say "You have more important things to focus on right now.";
		Reject the Player's command;
	end if;
Before inserting the scale into the right drawer:
	if Murder is the Current Scene
	begin;
		Say "You have more important things to focus on right now.";
		Reject the Player's command;
	end if;
Before inserting the scale into the desk:
	if Murder is the Current Scene
	begin;
		Say "You have more important things to focus on right now.";
		Reject the Player's command;
	end if;
After inserting the scale into the right drawer:
	if the stagedStatus of the scale is "false"
	begin;
		Increase the stageCount by 2;
		Now the stagedStatus of the scale is "true";
	end if;
After removing the scale from the right drawer:
	if the stagedStatus of the scale is "true"
	begin;
		Decrease the stageCount by 2;
		Now the stagedStatus of the scale is "false";
	end if;
When Investigation begins:
	Now the scale is in the right drawer;
	Now the right drawer is closed;
When Murder begins:
	Now the right drawer is closed;

[needle]
Instead of examining the left drawer:
	if the left drawer is closed
	begin;
		Say "The drawer is closed.";
	otherwise;
		if Investigation is the Current Scene
		begin;
			Say "You find a needle under some paperwork.";
			if the discoveredStatus of the left drawer is "false"
			begin;
				Increase the clueCount by 1;
				Now the discoveredStatus of the left drawer is "true";
			end if;
		otherwise if Murder is the Current Scene;
			Say "You have more important things to focus on right now.";
		otherwise if Staging is the Current Scene;
			Say "You see some cluttered paper work and files.";
		end if;
	end if;
Before taking the needle:
	if Investigation is the Current Scene
	begin;
		Say "You shouldn't take evidence from an active crime scene.";
	end if;
Before inserting the needle into the left drawer:
	if Murder is the Current Scene
	begin;
		Say "You have more important things to focus on right now.";
		Reject the Player's command;
	end if;
Before inserting the needle into the right drawer:
	if Murder is the Current Scene
	begin;
		Say "You have more important things to focus on right now.";
		Reject the Player's command;
	end if;
Before inserting the needle into the desk:
	if Murder is the Current Scene
	begin;
		Say "You have more important things to focus on right now.";
		Reject the Player's command;
	end if;
After inserting the needle into the left drawer:
	if the stagedStatus of the needle is "false"
	begin;
		Increase the stageCount by 2;
		Now the stagedStatus of the needle is "true";
	end if;
After removing the needle from the left drawer:
	if the stagedStatus of the needle is "true"
	begin;
		Decrease the stageCount by 2;
		Now the stagedStatus of the needle is "false";
	end if;
When Investigation begins:
	Now the needle is in the left drawer;
	Now the left drawer is closed;
When Murder begins:
	Now the left drawer is closed.

							

	
	
	
	