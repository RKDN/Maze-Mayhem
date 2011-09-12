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
				
				//Reset stuff
				Registry.scoreThisLevel = 0;
				Registry.timeThisLevel = 0;
				Registry.haskeys = [];
            }
		}
		
		//prevents the player from sticking on edges of tiles.
		public function antistick():void
		{			
			if (FlxG.keys.LEFT && Registry.collideSolids)
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
			if (FlxG.keys.UP && Registry.collideSolids)
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
			if (FlxG.keys.DOWN && Registry.collideSolids)
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
			if (FlxG.keys.RIGHT && Registry.collideSolids)
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