package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Enemy extends FlxSprite
	{
		
		public function Enemy(x:Number,y:Number) 
		{
			super(x, y);
			health = 100;			
			loadGraphic(Registry.ImgEnemy, false, false);
		}
		
		override public function update():void
        {
			if (Utils.getDistance(this, Registry.player) <= Registry.agroDist && !isTouching(FlxObject.ANY)) 
			{
				FlxVelocity.moveTowardsObject(this, Registry.player, 50);
			}
			else if(Utils.getDistance(this, Registry.player) >= Registry.agroDist)
			{
				velocity.x = 0;
				velocity.y = 0;
			}
			
			//antistick();
			
			super.update();
		}
		
		//Fix this
		//prevents the player from sticking on edges of tiles.
		public function antistick():void
		{			
			if (velocity.x > 0 && Registry.collideSolids)
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
			if (velocity.y < 0 && Registry.collideSolids)
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
			if (velocity.y > 0 && Registry.collideSolids)
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
			if (velocity.x < 0 && Registry.collideSolids)
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