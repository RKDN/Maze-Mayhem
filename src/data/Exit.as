package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Exit extends FlxSprite
	{
		
		
		public function Exit(x:Number,y:Number) 
		{
			super(x, y);
			
			loadGraphic(Registry.ImgExit, false, false)
		}
		
		override public function update():void
        {
			velocity.x = 0;
			velocity.y = 0;
			
			if (FlxG.overlap(this,Registry.player))
			{
				//Set some variables
				Registry.currentLevel += 1;
				Registry.scoreThisGame += Registry.scoreThisLevel;
				Registry.scoreThisLevel = 0;
				Registry.hasWon = true;
				Registry.haskeys = [];
				
				//Swap to the scoreboard state.
				FlxG.switchState(new scoreBoard);
			}
			super.update();
			
		}
		
	}

}