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

[INCLUDES]
Include Basic Help Menu by Emily Short.

[DEF ABSTRACTIONS]
[ apparently implicit subclasses can be made, but I couldn't get them to work. This wasn't the right approach anyway.
ToggableThing is a kind of thing.
	ToggableThing can be on or off.
	ToggableThing is usually off.
]

[DEF ACTIONS]
Watering is an action applying to one thing.
	Understand "water [thing]" as watering.
	
Listing is an action applying to one thing.
	Understand "list [thing]" as listing.
	
[wrap the default switch commands]
Turning On is an action applying to one thing.
	Understand "turning on [thing]" as switching on.
	
Turning Off is an action applying to one thing.
	Understand "turning off [thing]" as switching off.
	
[DEF GLOBAL VARS]
The Maximum Score is 20. [2x num of clues (whatever the becomes)]
The Score is 0.

[
_Flashback is a number that varies.
_Flashback is 0.

_Staging is a number that varies.
_Staging is 0. 
]

[DEF SCENES]
Investigation is a scene.
	Investigation begins when the player is in the Front Yard for the first time.
	
Murder is a scene.
	Murder begins when Investigation ends.
	
Staging is a scene.
	Staging begins when Murder ends.

[DEF ROOMS]
Front Yard is a room.
Living Room  is a room.
Garage is a room.
Kitchen is a room.
Back Yard is a room.
Upstairs is a room.
Master Bedroom is a room.
Child's Bedroom is a room.

[DEF ROOM LOCATIONS]
Living Room is north of Front Yard.
Garage is east of Living Room.
Kitchen is north of Living Room.
Upstairs is above Kitchen.
Back Yard is north of	Kitchen.
Master Bedroom is east of Upstairs.
Child's Bedroom is south of Upstairs.

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
	
	The front door is in the Front Yard.
		The front door is scenery.
		The description is "The front door is black, devoid of windows, and made of oak. It is unlocked.".
		
	The lawn is in the Front Yard.
		The lawn is scenery.
		The description is "The lawn is freshly mown and free of debris and weeds.".
	
	The mail box is in the Front Yard.
		The mail box is scenery.
		The description is "The mail box is empty. The house number 606 is on the side.".
	
	The apple tree is in the Front Yard.
		The apple tree is scenery.
		The description is "The tree looks to be a few years old. It bears fruit, but it's not ripe enough to eat.".
	
	[Living Room]
	
	[Garage]
	
	[Kitchen]
	
	[Back Yard]
	
	[Upstairs]
	
	[Master Bedroom]
	
	[Child's Bedroom]

[INIT OBJECTS]
	[dynamic surroundings
		tracks the location/scope of the player and updates its position
		allowing the player to always 'examine surroundings'.]
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
	The bushes are a thing.
		The bushes are in the Front Yard.
		The indefinite article is "some".
		The description is "The bushes have beautiful white flowers [if the bushes are not watered]on them, but they could use some water.[otherwise]that glisten in the morning sun.[end if]".
		The bushes can be watered or not watered.
		The bushes are not watered.
		Instead of watering the bushes:
			if the player has the nozzle and the nozzle is switched on
			begin;
				Say "You water the bushes.";
				Now the bushes are watered;
			otherwise if the player has the nozzle and the nozzle is switched off;
				Say "You can't water the bushes when the nozzle is off.";
			otherwise;
				Say "You have nothing with which to water the plant.";
			end if;
			
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
		Instead of taking the garden hose:
			Say "If anyone needs a shower it's you, not your co-workers.".
		After examining the garden hose for the first time:
			Move the nozzle to the Front Yard.
		The garden hose can be switched on or switched off.
			The garden hose is switched off.
			Instead of switching on the garden hose:
				Now the nozzle is switched on;
				Say "The nozzle is now turned on.".				
			Instead of switching off the garden hose:
				Now the nozzle is switched off;
				Say "The nozzle is now turned off.".
						
	[Living Room]
									
	[Garage]
											
	[Kitchen]
													
	[Back Yard]
															
	[Upstairs]
	
																	
	[Master Bedroom]
																			
	[Child's Bedroom]


																							
									





	