package data 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author RKDN
	 */
	public class scoreBoard extends FlxState 
	{
		
		public function scoreBoard() 
		{
			//Adds some text to the screen
            var txt:FlxText
            txt = new FlxText(0, (FlxG.height / 2 - 100), FlxG.width, "Game Over")
            txt.setFormat(null,48,0xFFFFFFFF,"center")
            this.add(txt);

			txt = new FlxText(0, FlxG.height - 35, FlxG.width, "PRESS X TO RESTART")
            txt.setFormat(null, 16, 0xFFFFFFFF, "center");
            this.add(txt);
		}
		
		override public function update():void
		{
			var txt:FlxText
			txt = new FlxText(0, (FlxG.height / 2), FlxG.width,"Score " + String(Registry.scoreThisGame))
            txt.setFormat(null,30,0xFFFFFFFF,"center")
            this.add(txt);

			if (FlxG.keys.pressed("X")) // If the player presses the X key...
            {
                // Flash white and fade over 3/4 of a second
                FlxG.flash(0xffffffff, 0.75); // Use this for Flixel 2.5
                // Fade to black over 1 second and call the function 'onFade'
                FlxG.fade(0xff000000, 1, onFade); // Use this for Flixel 2.5
            }
		}
		
		private function onFade():void
         {
			Registry.scoreThisGame = 0;
			Registry.scoreThisLevel = 0;
            FlxG.switchState(new PlayState); // Use this for Flixel 2.5
        }
	}

}