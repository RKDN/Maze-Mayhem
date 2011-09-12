package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Button extends FlxSprite
	{
		private var toggled:Boolean = false;
		public function Button(x:Number,y:Number) 
		{
			super(x, y);
			
			loadGraphic(Registry.ImgButton, false, true);
			
		}
		
		override public function update():void
        {	
			if (overlaps(Registry.player) && toggled == false)
			{
				if (facing == FlxObject.LEFT)
				{
					facing = FlxObject.RIGHT;
				}
				else 
				{
					facing = FlxObject.LEFT;
				}
				
					Registry.beltForward = !Registry.beltForward
					
					//Play switch sound
					FlxG.play(Registry.switchSound);
					toggled = true;
			}
			if (!overlaps(Registry.player))
			{
				toggled = false;
			}
			super.update();
			
		}
		
	}

}