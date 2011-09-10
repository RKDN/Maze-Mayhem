package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Enemy extends FlxSprite
	{
		
		
		public function Enemy(x:Number,y:Number) 
		{
			super(x, y);
			
			loadGraphic(Registry.ImgEnemy, false, false);
		}
		
		override public function update():void
        {
			velocity.x = 0;
			velocity.y = 0;
			
			if (Utils.getDistance(this, Registry.player) <= Registry.agroDist && !Registry.collideCheck) 
			{
				FlxVelocity.moveTowardsObject(this, Registry.player, 50);
			}
			super.update();
		}
		
	}

}