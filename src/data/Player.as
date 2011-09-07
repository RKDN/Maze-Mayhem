package data
{
    import org.flixel.*;
	import Utils;
 
    public class Player extends FlxSprite
    {
        [Embed(source="../assets/player.png")] private var ImgPlayer:Class;
		
		[Embed(source = "../assets/sounds/coin.mp3")] private var coinSound:Class;
		[Embed(source = "../assets/sounds/tram.mp3")] private var tramSound:Class;
		[Embed(source = "../assets/sounds/switch.mp3")] private var switchSound:Class;
		[Embed(source = "../assets/sounds/hit.mp3")] private var hitSound:Class;
		
		//Set local variables
		private var ontile:uint;
		private var onpickup:uint;
		private var counter:Number = 2;
 
        public function Player(x:Number,y:Number):void
        {
            super(x, y)
			
			//Load in the player graphic.
			loadGraphic(ImgPlayer, true, false);
			
			
			//Set the hitbox for the player.
			width = 10;
			height = 10;
			offset.x = 3;
			offset.y = 6;
			
			
			//Set Player Animations
			addAnimation("still", [0]);
			addAnimation("left", [4, 8], 10);
			addAnimation("right", [3, 7], 10);
			addAnimation("down", [1, 5], 10);
			addAnimation("up", [2, 6], 10);
        }
 
        override public function update():void
        {
			super.update();
			
			//Global Timer for Player
			counter += FlxG.elapsed;

			//Stop player from sliding unless he is on an ice tile.
            if (ontile != Registry.iceTile)
			{
				velocity.x = 0;
				velocity.y = 0;
			}
			
			//execute all the functions
			controls();
			screenCollide();
			tilestuff();
			moveCorrect();
			
        }
		
		
		//Keeps the player on the map.
		public function screenCollide():void
		{
			if (x > PlayState.floor.width - width)
			{
				x = PlayState.floor.width - width;
			}
			else if (x < width - width) {    x = width - width; } 
			
			if (y > PlayState.floor.height - height)
			{
				y = PlayState.floor.height - height;
			}
			else if (y < height - height)
			{
				y = height - height;
			}
		}
		
		//Player controls.
		public function controls():void
		{
 
            if(FlxG.keys.LEFT)
            {
                velocity.x = -Registry.moveSpeed;
				play("left");
            }
            else if(FlxG.keys.RIGHT)
            {
                velocity.x = Registry.moveSpeed;
				play("right");
            }
            else if(FlxG.keys.UP)
            {
                velocity.y = -Registry.moveSpeed;
				play("up");
            }
            else if(FlxG.keys.DOWN)
            {
                velocity.y = Registry.moveSpeed;
				play("down");
            }
			else
			{
				play("still");
			}
			
			//Reset the level by pressing R
			if(FlxG.keys.R)
            {
				//Reset
                FlxG.resetState();
				
				//Reset score
				Registry.scoreThisLevel = 0;
            }
		}
		
		public function tilestuff():void
		{	
			//Find out what tile the player is standing on.
			ontile = PlayState.floor.getTile(Math.floor((x + offset.x) / Registry.tileSize), Math.floor((y + offset.y) / Registry.tileSize));
			
			//Same thing but for the coins
			onpickup = PlayState.pickups.getTile(Math.floor((x + offset.x) / Registry.tileSize), Math.floor((y + offset.y) / Registry.tileSize));
			
			
			if (ontile == Registry.tramRight)
			{
				velocity.x = Registry.moveSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == Registry.tramLeft)
			{
				velocity.x = -Registry.moveSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == Registry.tramUp)
			{
				velocity.y = -Registry.moveSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == Registry.tramDown)
			{
				velocity.y = Registry.moveSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == Registry.tramBR)
			{
				velocity.x = Registry.tramSpeed;
				velocity.y = -Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == Registry.tramTR)
			{
				velocity.y = -Registry.tramSpeed;
				velocity.x = -Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == Registry.tramTL)
			{
				velocity.x = -Registry.tramSpeed;
				velocity.y = Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == Registry.tramBL)
			{
				velocity.y = Registry.tramSpeed;
				velocity.x = Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == Registry.tramTRrev)
			{
				velocity.x = Registry.tramSpeed;
				velocity.y = Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == Registry.tramTLrev)
			{
				velocity.y = -Registry.tramSpeed;
				velocity.x = Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == Registry.tramBLrev)
			{
				velocity.x = -Registry.tramSpeed;
				velocity.y = -Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == Registry.tramBRrev)
			{
				velocity.y = Registry.tramSpeed;
				velocity.x = -Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			
			//Dangerous lava!
			if (ontile == Registry.lavaTile)
			{
				Registry.scoreThisGame += Registry.scoreThisLevel;
				FlxG.play(hitSound);
				FlxG.switchState(new scoreBoard);
			}
			
			//Win Tile
			if (ontile == Registry.goalTile)
			{
				
				//Set some variables
				Registry.currentLevel += 1;
				Registry.scoreThisGame += Registry.scoreThisLevel;
				Registry.scoreThisLevel = 0;
				
				//Swap to the scoreboard state.
				FlxG.switchState(new scoreBoard);
			}
			
			//When we are on our yellow key (Registry.keyY) we remove the coresponding doors.
			if (ontile == Registry.keyY)
			{
				Utils.replaceTiles("solids", Registry.doorY, Registry.blankTile);
				Utils.replaceTiles("floor", Registry.keyY, Registry.keyGone);
				FlxG.play(switchSound);
			}
			//When we are on our green key (Registry.keyG) we remove the coresponding doors.
			if (ontile == Registry.keyG)
			{
				Utils.replaceTiles("solids", Registry.doorG, Registry.blankTile)
				Utils.replaceTiles("floor", Registry.keyG, Registry.keyGone);
				FlxG.play(switchSound);
			}
			//When we are on our blue key (Registry.keyB) we remove the coresponding doors.
			if (ontile == Registry.keyB)
			{
				Utils.replaceTiles("solids", Registry.doorB, Registry.blankTile);
				Utils.replaceTiles("floor", Registry.keyB, Registry.keyGone);
				FlxG.play(switchSound);
			}
			//When we are on our orange key (Registry.keyR) we remove the coresponding doors.
			if (ontile == Registry.keyR)
			{
				Utils.replaceTiles("solids", Registry.doorR, Registry.blankTile);
				Utils.replaceTiles("floor", Registry.keyR, Registry.keyGone);
				FlxG.play(switchSound);
			}
			//If we are on a coin then add points and remove the coin.
			if (onpickup == Registry.coinTile)
			{
				Registry.scoreThisLevel += 1;
				FlxG.play(coinSound);
				Utils.removeTile("pickups",x + offset.x, y + offset.y);
				
			}
			
			//Tram toggle switch
			if ((ontile == Registry.tramSwitch || ontile == Registry.tramSwitchrev) && counter > 1)
			{
				//This works but its kind of a hack. Replace all the tram tiles with opposite tiles.
					
					//Swap left and right tiles
					Utils.replaceTiles("floor", Registry.tramRight, Registry.tempTile)
					Utils.replaceTiles("floor", Registry.tramLeft, Registry.tramRight);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramLeft);
					
					//Swap up and down tiles
					Utils.replaceTiles("floor", Registry.tramUp, Registry.tempTile);
					Utils.replaceTiles("floor", Registry.tramDown, Registry.tramUp);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramDown);
					
					//Swap bottom right tiles
					Utils.replaceTiles("floor", Registry.tramBR, Registry.tempTile);
					Utils.replaceTiles("floor", Registry.tramBRrev, Registry.tramBR);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramBRrev);
					
					//Swap bottom left tiles
					Utils.replaceTiles("floor", Registry.tramBL, Registry.tempTile);
					Utils.replaceTiles("floor", Registry.tramBLrev, Registry.tramBL);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramBLrev);
					
					//Swap top right tiles.
					Utils.replaceTiles("floor", Registry.tramTR, Registry.tempTile);
					Utils.replaceTiles("floor", Registry.tramTRrev, Registry.tramTR);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramTRrev);
					
					//Swap top left tiles
					Utils.replaceTiles("floor", Registry.tramTL, Registry.tempTile);
					Utils.replaceTiles("floor", Registry.tramTLrev, Registry.tramTL);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramTLrev);
					
					//Replace the key with empty key tile
					if(ontile == Registry.tramSwitch) Utils.replaceTiles("floor", Registry.tramSwitch, Registry.tramSwitchrev);
					if (ontile == Registry.tramSwitchrev) Utils.replaceTiles("floor", Registry.tramSwitchrev, Registry.tramSwitch);
					
					//Play switch sound
					FlxG.play(switchSound);
					
					//reset time the player is on the tile.
					counter = 0;
			}
		}
		
		//I hate this function but it seems to be necessary to keep the player on the conveyor belts.
		public function moveCorrect():void
		{
			//if we are not on a conveyor belt then use this code to funnel through doors. Prevents player from sticking on edges.
			if (ontile != Registry.tramRight && ontile != Registry.tramLeft && ontile != Registry.tramUp && ontile != Registry.tramDown
			&& ontile != Registry.tramBR && ontile != Registry.tramTR && ontile != Registry.tramTL && ontile != Registry.tramBL
			&& ontile != Registry.tramTRrev && ontile != Registry.tramTLrev && ontile != Registry.tramBLrev && ontile != Registry.tramBRrev)
			{
				if (((Registry.player.x + 6) % Registry.tileSize) > 6 && Registry.collideCheck && Registry.player.velocity.x == 0)
				{
					x -= Registry.player.width/2;
				}
				if (((Registry.player.x + 6) % Registry.tileSize) < 6 && Registry.collideCheck && Registry.player.velocity.x == 0)
				{
					x += Registry.player.width/2;
				}
				if (((Registry.player.y + 4) % Registry.tileSize) > 4 && Registry.collideCheck && Registry.player.velocity.y == 0)
				{
					y -= Registry.player.height/2;
				}
				if (((Registry.player.y + 4) % Registry.tileSize) < 4 && Registry.collideCheck && Registry.player.velocity.y == 0)
				{
					y += Registry.player.height/2;
				}
			}
			else
			{
				if (ontile == Registry.tramBR && ((Registry.player.x + offset.x) % Registry.tileSize) >= 12)
				{
					x -= Registry.correctDist;
				}
				if (ontile == Registry.tramTL && ((Registry.player.x + offset.x) % Registry.tileSize) <= 4)
				{
					x += Registry.correctDist;
				}
				if (ontile == Registry.tramBL && ((Registry.player.y + offset.y) % Registry.tileSize) >= 12)
				{
					y -= Registry.correctDist;
				}
				if (ontile == Registry.tramTR && ((Registry.player.y + offset.y) % Registry.tileSize) <= 4)
				{
					y += Registry.correctDist;
				}
				
				if (ontile == Registry.tramTRrev && ((Registry.player.x + offset.x) % Registry.tileSize) >= 12)
				{
					x -= Registry.correctDist;
				}
				if (ontile == Registry.tramBLrev && ((Registry.player.x + offset.x) % Registry.tileSize) <= 4)
				{
					x += Registry.correctDist;
				}
				if (ontile == Registry.tramBRrev && ((Registry.player.y + offset.y) % Registry.tileSize) >= 12)
				{
					y -= Registry.correctDist;
				}
				if (ontile == Registry.tramTLrev && ((Registry.player.y + offset.y) % Registry.tileSize) <= 4)
				{
					y += Registry.correctDist;
				}
			}
		}
		
		
    }
}