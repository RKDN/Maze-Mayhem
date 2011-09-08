package data
{
    import org.flixel.*;
	import Utils;
 
    public class Player extends FlxSprite
    {		
		//Set local variables
		private var ontile:uint;
		private var onpickup:uint;
		private var counter:Number = 2;
 
        public function Player(x:Number,y:Number):void
        {
            super(x, y)
			
			//Load in the player graphic.
			loadGraphic(Registry.ImgPlayer, true, false);
			
			
			//Set the hitbox for the player.
			width = 10;
			height = 10;
			offset.x = 3;
			offset.y = 6;
			
			
			//Set Player Animations
			addAnimation("still", [0]);
			addAnimation("leftidle", [4]);
			addAnimation("rightidle", [3]);
			addAnimation("upidle", [2]);
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

			//Stop player from sliding unless they are on an ice tile.
            if (ontile != Registry.iceTile)
			{
				velocity.x = 0;
				velocity.y = 0;
			}
			
			//execute all the things!
			controls();
			screenCollide();
			tilestuff();
			antistick();
			
			
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
			ontile = Utils.ontile("floor", x, y, width, height);
			
			//Same thing but for the coins
			onpickup = Utils.ontile("pickups", x, y, width, height);
			
			
			
			//Conveyor Belts
			if (ontile == Registry.tramRight)
			{
				velocity.x = Registry.moveSpeed;
				play("rightidle");
				FlxG.play(Registry.tramSound);
			}
			if (ontile == Registry.tramLeft)
			{
				velocity.x = -Registry.moveSpeed;
				play("leftidle");
				FlxG.play(Registry.tramSound);
			}
			if (ontile == Registry.tramUp)
			{
				velocity.y = -Registry.moveSpeed;
				play("upidle");
				FlxG.play(Registry.tramSound);
			}
			if (ontile == Registry.tramDown)
			{
				velocity.y = Registry.moveSpeed;
				FlxG.play(Registry.tramSound);
			}
			if (ontile == Registry.tramBR)
			{
				velocity.x = Registry.tramSpeed/2;
				velocity.y = -Registry.tramSpeed;
				FlxG.play(Registry.tramSound);
			}
			if (ontile == Registry.tramTR)
			{
				velocity.y = -Registry.tramSpeed/2;
				velocity.x = -Registry.tramSpeed;
				FlxG.play(Registry.tramSound);
			}
			if (ontile == Registry.tramTL)
			{
				velocity.x = -Registry.tramSpeed/2;
				velocity.y = Registry.tramSpeed;
				FlxG.play(Registry.tramSound);
			}
			if (ontile == Registry.tramBL)
			{
				velocity.y = Registry.tramSpeed/2;
				velocity.x = Registry.tramSpeed;
				FlxG.play(Registry.tramSound);
			}
			if (ontile == Registry.tramTRrev)
			{
				velocity.x = Registry.tramSpeed/2;
				velocity.y = Registry.tramSpeed;
				FlxG.play(Registry.tramSound);
			}
			if (ontile == Registry.tramTLrev)
			{
				velocity.y = -Registry.tramSpeed/2;
				velocity.x = Registry.tramSpeed;
				FlxG.play(Registry.tramSound);
			}
			if (ontile == Registry.tramBLrev)
			{
				velocity.x = -Registry.tramSpeed/2;
				velocity.y = -Registry.tramSpeed;
				FlxG.play(Registry.tramSound);
			}
			if (ontile == Registry.tramBRrev)
			{
				velocity.y = Registry.tramSpeed/2;
				velocity.x = -Registry.tramSpeed;
				FlxG.play(Registry.tramSound);
			}
			
			
			
			//Dangerous lava!
			if (ontile == Registry.lavaTile)
			{
				Registry.scoreThisGame += Registry.scoreThisLevel;
				FlxG.play(Registry.hitSound);
				FlxG.switchState(new scoreBoard);
				Registry.hasWon = false;
			}
			
			//Win Tile
			if (ontile == Registry.goalTile)
			{
				
				//Set some variables
				Registry.currentLevel += 1;
				Registry.scoreThisGame += Registry.scoreThisLevel;
				Registry.scoreThisLevel = 0;
				Registry.hasWon = true;
				
				//Swap to the scoreboard state.
				FlxG.switchState(new scoreBoard);
			}
			
			//When we are on our yellow key (Registry.keyY) we remove the coresponding doors.
			if (ontile == Registry.keyY)
			{
				Utils.replaceTiles("solids", Registry.doorY, Registry.blankTile);
				Utils.replaceTiles("floor", Registry.keyY, Registry.keyGone);
				FlxG.play(Registry.switchSound);
			}
			//When we are on our green key (Registry.keyG) we remove the coresponding doors.
			if (ontile == Registry.keyG)
			{
				Utils.replaceTiles("solids", Registry.doorG, Registry.blankTile)
				Utils.replaceTiles("floor", Registry.keyG, Registry.keyGone);
				FlxG.play(Registry.switchSound);
			}
			//When we are on our blue key (Registry.keyB) we remove the coresponding doors.
			if (ontile == Registry.keyB)
			{
				Utils.replaceTiles("solids", Registry.doorB, Registry.blankTile);
				Utils.replaceTiles("floor", Registry.keyB, Registry.keyGone);
				FlxG.play(Registry.switchSound);
			}
			//When we are on our orange key (Registry.keyR) we remove the coresponding doors.
			if (ontile == Registry.keyR)
			{
				Utils.replaceTiles("solids", Registry.doorR, Registry.blankTile);
				Utils.replaceTiles("floor", Registry.keyR, Registry.keyGone);
				FlxG.play(Registry.switchSound);
			}
			//If we are on a coin then add points and remove the coin.
			if (onpickup == Registry.coinTile)
			{
				Registry.scoreThisLevel += 1;
				FlxG.play(Registry.coinSound);
				
				if(FlxG.keys.UP)
				{
					Utils.removeTile("pickups", x + (width/2), y);
				}
				if(FlxG.keys.DOWN)
				{
					Utils.removeTile("pickups", x + width/2, y+height);
				}
				if(FlxG.keys.LEFT)
				{
					Utils.removeTile("pickups", x, y + (height/2));
				}
				if(FlxG.keys.RIGHT)
				{
					Utils.removeTile("pickups", x + width, y + (height/2));
				}
				else
				{
					Utils.removeTile("pickups", x + (width/2), y + (height/2));
				}
				
			}
			
			//Tram toggle switch
			if ((ontile == Registry.tramSwitch || ontile == Registry.tramSwitchrev) && counter > 1)
			{
					
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
					
					//Swap switch tile.
					if(ontile == Registry.tramSwitch) Utils.replaceTiles("floor", Registry.tramSwitch, Registry.tramSwitchrev);
					if (ontile == Registry.tramSwitchrev) Utils.replaceTiles("floor", Registry.tramSwitchrev, Registry.tramSwitch);
					
					//Play switch sound
					FlxG.play(Registry.switchSound);
					
					//reset time the player is on the tile.
					counter = 0;
			}
		}
		
		//prevents the player from sticking on edges of tiles.
		public function antistick():void
		{			
			if (FlxG.keys.LEFT && Registry.collideCheck)
			{
				if (Utils.checkTopLeft() == 0)
				{
					velocity.y = -Registry.moveSpeed;
				}
				if (Utils.checkBotLeft() == 0)
				{
					velocity.y = Registry.moveSpeed;
				}
			}
			if (FlxG.keys.UP && Registry.collideCheck)
			{
				if (Utils.checkTopLeft() == 0)
				{
					velocity.x = -Registry.moveSpeed;
				}
				if (Utils.checkTopRight() == 0)
				{
					velocity.x = Registry.moveSpeed;
				}
			}
			if (FlxG.keys.DOWN && Registry.collideCheck)
			{
				if (Utils.checkBotRight() == 0)
				{
					velocity.x = Registry.moveSpeed;
				}
				if (Utils.checkBotLeft() == 0)
				{
					velocity.x = -Registry.moveSpeed;
				}
			}
			if (FlxG.keys.RIGHT && Registry.collideCheck)
			{
				if (Utils.checkTopRight() == 0)
				{
					velocity.y = -Registry.moveSpeed;
				}
				if (Utils.checkBotRight() == 0)
				{
					velocity.y = Registry.moveSpeed;
				}
			}			
		}
		
		
    }
}