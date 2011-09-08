package data 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author RKDN
	 */
	public class scoreBoard extends FlxState 
	{
		private var messageText:String;
		
		public function scoreBoard() 
		{
			
			//Check if the player has won
			if (Registry.hasWon == true)
			{
				messageText = "Congrats!"
			}
			else
			{
				messageText = "Game Over"
			}
			
			//Adds some text to the screen
            var txt:FlxText
            txt = new FlxText(0, (FlxG.height / 2 - 100), FlxG.width, messageText)
            txt.setFormat(null,48,0xFFFFFFFF,"center")
            this.add(txt);

			txt = new FlxText(0, FlxG.height - 35, FlxG.width, "PRESS X TO CONTINUE")
            txt.setFormat(null, 16, 0xFFFFFFFF, "center");
            this.add(txt);
		}
		
		override public function update():void
		{
			var txt:FlxText
			txt = new FlxText(0, (FlxG.height / 2), FlxG.width,"Coins " + String(Registry.scoreThisGame))
            txt.setFormat(null,30,0xFFFFFFFF,"center")
            this.add(txt);

			txt = new FlxText(0, (FlxG.height / 2 + 40), FlxG.width,"Time " + String(FlxU.formatTime(Registry.timeThisLevel)))
            txt.setFormat(null,30,0xFFFFFFFF,"center")
            this.add(txt);

			if (FlxG.keys.pressed("X")) // If the player presses the X key...
            {
                // Flash white and fade over 3/4 of a second
                FlxG.flash(0xffffffff, 0.75);
                // Fade to black over 1 second and call the function 'onFade'
                FlxG.fade(0xff000000, 1, onFade);
            }
		}
		
		private function onFade():void
         {
			Registry.scoreThisGame = 0;
			Registry.scoreThisLevel = 0;
            FlxG.switchState(new PlayState);
        }
	}

}