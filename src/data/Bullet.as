package data
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Bullet extends FlxSprite
	{
		[Embed(source = '../assets/bullet.png')] private var ImgBullet:Class;
		
		public var damage:int = 1;
		public var speed:int = 300;
		public var distance:int = 50;
		public function Bullet():void
		{
			super();
			
			loadGraphic(ImgBullet, false, false);
			
			exists = false;
		}
		public function fire(bx:int, by:int):void
		{
			x = bx;
			y = by;
			
			FlxVelocity.moveTowardsMouse(this, speed);
			
			exists = true;
		}
		override public function update():void
		{
			super.update();
			
			if (x > Registry.player.x + distance)
			{
				exists = false;
			}
			else if (x < Registry.player.x - distance)
			{    
				exists = false; 
			} 
			
			if (y > Registry.player.y + distance)
			{
				exists = false;
			}
			else if (y < Registry.player.y - distance)
			{
				exists = false;
			}
			
		}
	}
}