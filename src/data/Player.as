package data
{
    import org.flixel.*;
 
    public class Player extends FlxSprite
    {
        [Embed(source="../assets/player.png")] private var ImgPlayer:Class;
		
		[Embed(source = "../assets/sounds/coin.mp3")] private var coinSound:Class;
		[Embed(source = "../assets/sounds/tram.mp3")] private var tramSound:Class;
		[Embed(source = "../assets/sounds/switch.mp3")] private var switchSound:Class;
		[Embed(source = "../assets/sounds/hit.mp3")] private var hitSound:Class;
		
		private var ontile:uint;
		private var onpickup:uint;
		private var counter:Number = 2;
 
        public function Player(x:Number,y:Number):void
        {
            super(x, y)
			loadGraphic(ImgPlayer, true, false);
			
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
            if (ontile != 22)
			{
				velocity.x = 0;
				velocity.y = 0;
			}
			
			controls();
			screenCollide();
			tilestuff();
			moveCorrect();
			
        }
		
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
			
			if(FlxG.keys.R)
            {
                FlxG.resetState();
				Registry.scoreThisLevel = 0;
            }
		}
		
		public function tilestuff():void
		{	
			ontile = PlayState.floor.getTile(Math.floor((x + offset.x) / 16), Math.floor((y + offset.y) / 16));
			onpickup = PlayState.pickups.getTile(Math.floor((x + offset.x) / 16), Math.floor((y + offset.y) / 16));
			

			if (ontile == 3)
			{
				velocity.x = Registry.moveSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == 4)
			{
				velocity.x = -Registry.moveSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == 5)
			{
				velocity.y = -Registry.moveSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == 6)
			{
				velocity.y = Registry.moveSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == 27)
			{
				velocity.x = Registry.tramSpeed;
				velocity.y = -Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == 28)
			{
				velocity.y = -Registry.tramSpeed;
				velocity.x = -Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == 29)
			{
				velocity.x = -Registry.tramSpeed;
				velocity.y = Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == 30)
			{
				velocity.y = Registry.tramSpeed;
				velocity.x = Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == 31)
			{
				velocity.x = Registry.tramSpeed;
				velocity.y = Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == 32)
			{
				velocity.y = -Registry.tramSpeed;
				velocity.x = Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == 33)
			{
				velocity.x = -Registry.tramSpeed;
				velocity.y = -Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			if (ontile == 34)
			{
				velocity.y = Registry.tramSpeed;
				velocity.x = -Registry.tramSpeed;
				FlxG.play(tramSound);
			}
			
			if (ontile == 7)
			{
				Registry.scoreThisGame += Registry.scoreThisLevel;
				FlxG.play(hitSound);
				FlxG.switchState(new scoreBoard);
			}
			if (ontile == 2)
			{
				Registry.currentLevel += 1;
				Registry.scoreThisGame += Registry.scoreThisLevel;
				Registry.scoreThisLevel = 0;
				FlxG.switchState(new scoreBoard);
			}
			
			//When we are on our yellow key (10) we remove the coresponding doors.
			if (ontile == 10)
			{
				replaceTiles("solids", 14, 0);
				replaceTiles("floor", 10, 21);
				FlxG.play(switchSound);
				counter = 0;
			}
			//When we are on our green key (13) we remove the coresponding doors.
			if (ontile == 13)
			{
				replaceTiles("solids", 17, 0)
				replaceTiles("floor", 13, 21);
				FlxG.play(switchSound);
				counter = 0;
			}
			//When we are on our blue key (11) we remove the coresponding doors.
			if (ontile == 11)
			{
				replaceTiles("solids", 15, 0);
				replaceTiles("floor", 11, 21);
				FlxG.play(switchSound);
				counter = 0;
			}
			//When we are on our orange key (10) we remove the coresponding doors.
			if (ontile == 12)
			{
				replaceTiles("solids", 16, 0);
				replaceTiles("floor", 12, 21);
				FlxG.play(switchSound);
				counter = 0;
			}
			//If we are on a coin then add points and remove the coin.
			if (onpickup == 19)
			{
				Registry.scoreThisLevel += 1;
				FlxG.play(coinSound);
				removeTile("pickups",x + offset.x, y + offset.y);
				
			}
			
			//Tram toggle switch
			if ((ontile == 8 || ontile == 23) && counter > 1)
			{
				//This works but its kind of a hack.
					replaceTiles("floor", 3, 18)
					replaceTiles("floor", 4, 3);
					replaceTiles("floor", 18, 4);
					replaceTiles("floor", 5, 18);
					replaceTiles("floor", 6, 5);
					replaceTiles("floor", 18, 6);
					replaceTiles("floor", 27, 18);
					replaceTiles("floor", 34, 27);
					replaceTiles("floor", 18, 34);
					replaceTiles("floor", 28, 18);
					replaceTiles("floor", 31, 28);
					replaceTiles("floor", 18, 31);
					replaceTiles("floor", 29, 18);
					replaceTiles("floor", 32, 29);
					replaceTiles("floor", 18, 32);
					replaceTiles("floor", 30, 18);
					replaceTiles("floor", 33, 30);
					replaceTiles("floor", 18, 33);
					
					
					//Registry.tramSpeed = Registry.tramSpeed * -1;
					if(ontile == 8) replaceTiles("floor", 8, 23);
					if(ontile == 23) replaceTiles("floor", 23, 8);
					FlxG.play(switchSound);
					counter = 0;
			}
		}
		
		public function replaceTiles(layer:String,x:uint,n:uint):void
		{
			var i:uint = 0;
			var Tiles:Array;
			
			switch (layer)
			{
			case "solids":
			Tiles = PlayState.solids.getTileInstances(x);
			if (Tiles)
				{
					for (i = 0; i < Tiles.length; i++) 
					{
						PlayState.solids.setTileByIndex(Tiles[i], n, true);	
					}
				}
			break;
			case "floor":
			Tiles = PlayState.floor.getTileInstances(x);
			if (Tiles)
				{
					for (i = 0; i < Tiles.length; i++) 
					{
						PlayState.floor.setTileByIndex(Tiles[i], n, true);
					}
				}
			break;
			}
		}
		
		public function removeTile(layer:String,x:uint,y:uint):void
		{
			var location:uint;
			
			switch (layer)
			{
			case "floor":
			location = Math.floor(x / 16) + Math.floor(y / 16) * PlayState.floor.widthInTiles;
			PlayState.floor.setTileByIndex(location,0)
			break;
			case "pickups":
			location = Math.floor(x / 16) + Math.floor(y / 16) * PlayState.pickups.widthInTiles;
			PlayState.pickups.setTileByIndex(location,0)
			break;
			}
		}
		public function moveCorrect():void
		{
			if (ontile != 3 && ontile != 4 && ontile != 5 && ontile != 6
			&& ontile != 27 && ontile != 28 && ontile != 29 && ontile != 30
			&& ontile != 31 && ontile != 32 && ontile != 33 && ontile != 34)
			{
				if (((Registry.player.x + 6) % 16) > 6 && Registry.collideCheck && Registry.player.velocity.x == 0)
				{
					x -= Registry.player.width/2;
				}
				if (((Registry.player.x + 6) % 16) < 6 && Registry.collideCheck && Registry.player.velocity.x == 0)
				{
					x += Registry.player.width/2;
				}
				if (((Registry.player.y + 4) % 16) > 4 && Registry.collideCheck && Registry.player.velocity.y == 0)
				{
					y -= Registry.player.height/2;
				}
				if (((Registry.player.y + 4) % 16) < 4 && Registry.collideCheck && Registry.player.velocity.y == 0)
				{
					y += Registry.player.height/2;
				}
			}
			else
			{
				if (ontile == 27 && ((Registry.player.x + offset.x) % 16) >= 12)
				{
					x -= Registry.correctDist;
				}
				if (ontile == 29 && ((Registry.player.x + offset.x) % 16) <= 4)
				{
					x += Registry.correctDist;
				}
				if (ontile == 30 && ((Registry.player.y + offset.y) % 16) >= 12)
				{
					y -= Registry.correctDist;
				}
				if (ontile == 28 && ((Registry.player.y + offset.y) % 16) <= 4)
				{
					y += Registry.correctDist;
				}
				
				if (ontile == 31 && ((Registry.player.x + offset.x) % 16) >= 12)
				{
					trace("31");
					x -= Registry.correctDist;
				}
				if (ontile == 33 && ((Registry.player.x + offset.x) % 16) <= 4)
				{
					trace("33");
					x += Registry.correctDist;
				}
				if (ontile == 34 && ((Registry.player.y + offset.y) % 16) >= 12)
				{
					trace("34");
					y -= Registry.correctDist;
				}
				if (ontile == 32 && ((Registry.player.y + offset.y) % 16) <= 4)
				{
					trace("32");
					y += Registry.correctDist;
				}
			}
		}
		
		
    }
}