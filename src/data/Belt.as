package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Belt extends FlxSprite
	{
		private var beltType:String;
		
		public function Belt(x:Number,y:Number,type:String) 
		{
			super(x, y);
			beltType = type;
			trace(beltType)
			if (beltType == "right") loadGraphic(Registry.rightBelt, false);
			if (beltType == "left") loadGraphic(Registry.leftBelt, false);
			if (beltType == "up") loadGraphic(Registry.upBelt, false);
			if (beltType == "down") loadGraphic(Registry.downBelt, false);
			if (beltType == "tr") loadGraphic(Registry.trBelt, false);
			if (beltType == "br") loadGraphic(Registry.brBelt, false);
			if (beltType == "tl") loadGraphic(Registry.tlBelt, false);
			if (beltType == "bl") loadGraphic(Registry.blBelt, false);
			
			immovable = true;
		}
		
		override public function update():void
        {			
			if (FlxG.overlap(this,Registry.player))
			{
				if (beltType == "right") Registry.player.acceleration.x = Registry.tramSpeed;
				if (beltType == "left") Registry.player.acceleration.x = -Registry.tramSpeed;
				if (beltType == "up") Registry.player.acceleration.y = -Registry.tramSpeed;
				if (beltType == "down") Registry.player.acceleration.y = Registry.tramSpeed;
			}
			super.update();
			
		}
		
	}

}