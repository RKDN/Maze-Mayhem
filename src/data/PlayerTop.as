package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class PlayerTop extends FlxSprite
	{
		
		
		public function PlayerTop() 
		{
			super();
			
			loadGraphic(Registry.ImgPlayer, false, false)
		}
		
		override public function update():void
        {
			this.angle = angleBetweenMouse(this, true) + 90;
			super.update();
			
		}
		
		public function angleBetweenMouse(a:FlxSprite, asDegrees:Boolean = false):Number
		{
			//	In order to get the angle between the object and mouse, we need the objects screen coordinates (rather than world coordinates)
			var p:FlxPoint = a.getScreenXY();
			
			var dx:Number = FlxG.mouse.screenX - p.x;
			var dy:Number = FlxG.mouse.screenY - p.y;
			
			if (asDegrees)
			{
				return (Math.atan2(dy, dx)) * 180 / Math.PI;;
			}
			else
			{
				return Math.atan2(dy, dx);
			}
		}
		
	}

}