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
			super.update();
		}
		
	}

}