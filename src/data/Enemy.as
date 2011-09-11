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
			if (Utils.getDistance(this, Registry.player) <= Registry.agroDist && !FlxG.overlap(this,Registry.player)) 
			{
				FlxVelocity.moveTowardsObject(this, Registry.player, 50);
			}
			super.update();
		}
		
	}

}