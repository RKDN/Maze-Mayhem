package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Enemy extends FlxSprite
	{
		[Embed(source = "../assets/player.png")] private var ImgEnemy:Class;
		
		public function Enemy(x:Number,y:Number) 
		{
			loadGraphic(ImgEnemy, true, false);
			
			addAnimation("still", [0]);
			super(x, y);
		}
		
		override public function update():void
        {
			play("still");
			FlxVelocity.moveTowardsObject(Registry.enemy, Registry.player, 60);
			super.update();
		}
		
	}

}