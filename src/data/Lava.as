package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Lava extends FlxSprite
	{
		
		
		public function Lava(x:Number,y:Number) 
		{
			super(x, y);
			
			loadGraphic(Registry.ImgLava, true, false)
			addAnimation("lava", [0, 1, 2, 3], 5);
		}
		
		override public function update():void
        {
			velocity.x = 0;
			velocity.y = 0;
			
			play("lava")
			
			if (FlxG.overlap(this,Registry.player))
			{
				Registry.scoreThisGame += Registry.scoreThisLevel;
				FlxG.play(Registry.hitSound);
				FlxG.switchState(new scoreBoard);
				Registry.hasWon = false;
				Registry.haskeys = [];
			}
			super.update();
			
		}
		
	}

}