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
			
			loadGraphic(Registry.ImgPoint, false, false);

			//Set the hitbox for the player.
			width = 12;
			height = 12;
			offset.x = -2;
			offset.y = -2;
        }
 
        override public function update():void
        {
			
			if (!FlxG.overlap(this,Registry.belts))
			{
				velocity.x = 0;
				velocity.y = 0;
			}

			//Global Timer for Player
			counter += FlxG.elapsed;
			
			//execute all the things!
			controls();
			screenCollide();
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
 
            if(FlxG.keys.A)
            {
                velocity.x = -Registry.moveSpeed;
            }
            else if(FlxG.keys.D)
            {
                velocity.x = Registry.moveSpeed;
            }
            else if(FlxG.keys.W)
            {
                velocity.y = -Registry.moveSpeed;
            }
            else if(FlxG.keys.S)
            {
                velocity.y = Registry.moveSpeed;
            }
			
			//Mouse click
			if (FlxG.mouse.justPressed())
			{
				//Spawn a bullet
				Registry.bullets.fire(x + 2, y);
				Registry.bullets.fire(x + 4, y);
				
			}
			
			//Reset the level by pressing R
			if(FlxG.keys.R)
            {
				//Reset
                FlxG.resetState();
				
				//Reset stuff
				Registry.scoreThisLevel = 0;
				Registry.timeThisLevel = 0;
				Registry.haskeys = [];
            }
		}
		
		//prevents the player from sticking on edges of tiles.
		public function antistick():void
		{			
			if (FlxG.keys.A && Registry.collideSolids)
			{
				if (Utils.checkTopLeft(this) == 0)
				{
					velocity.y = -Registry.moveSpeed;
				}
				if (Utils.checkBotLeft(this) == 0)
				{
					velocity.y = Registry.moveSpeed;
				}
			}
			if (FlxG.keys.W && Registry.collideSolids)
			{
				if (Utils.checkTopLeft(this) == 0)
				{
					velocity.x = -Registry.moveSpeed;
				}
				if (Utils.checkTopRight(this) == 0)
				{
					velocity.x = Registry.moveSpeed;
				}
			}
			if (FlxG.keys.S && Registry.collideSolids)
			{
				if (Utils.checkBotRight(this) == 0)
				{
					velocity.x = Registry.moveSpeed;
				}
				if (Utils.checkBotLeft(this) == 0)
				{
					velocity.x = -Registry.moveSpeed;
				}
			}
			if (FlxG.keys.D && Registry.collideSolids)
			{
				if (Utils.checkTopRight(this) == 0)
				{
					velocity.y = -Registry.moveSpeed;
				}
				if (Utils.checkBotRight(this) == 0)
				{
					velocity.y = Registry.moveSpeed;
				}
			}			
		}		
    }
}