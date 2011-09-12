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
			if (beltType == "right") loadGraphic(Registry.rightBelt, false);
			if (beltType == "left") loadGraphic(Registry.leftBelt, false);
			if (beltType == "up") loadGraphic(Registry.upBelt, false);
			if (beltType == "down") loadGraphic(Registry.downBelt, false);
			if (beltType == "tr") loadGraphic(Registry.trBelt, false);
			if (beltType == "br") loadGraphic(Registry.brBelt, false);
			if (beltType == "tl") loadGraphic(Registry.tlBelt, false);
			if (beltType == "bl") loadGraphic(Registry.blBelt, false);
		}

		//TODO: change this to use paths
		override public function update():void
        {
			super.update();
			
			if (FlxG.overlap(this,Registry.player))
			{
				if (beltType == "right") Registry.player.velocity.x = Registry.tramSpeed;
				if (beltType == "left") Registry.player.velocity.x = -Registry.tramSpeed;
				if (beltType == "up") Registry.player.velocity.y = -Registry.tramSpeed;
				if (beltType == "down") Registry.player.velocity.y = Registry.tramSpeed;
				
				if (beltType == "tr")
				{
					Registry.player.velocity.x = Registry.tramSpeed / 6;
					Registry.player.velocity.y = Registry.tramSpeed;
				}
				if (beltType == "br")
				{
					Registry.player.velocity.x = -Registry.tramSpeed;
					Registry.player.velocity.y = Registry.tramSpeed / 6;
				}
				if (beltType == "tl")
				{
					Registry.player.velocity.x = Registry.tramSpeed / 6;
					Registry.player.velocity.y = -Registry.tramSpeed;
				}
				if (beltType == "bl")
				{
					Registry.player.velocity.x = -Registry.tramSpeed;
					Registry.player.velocity.y = -Registry.tramSpeed / 6;
				}
			}	
		}
		
	}

}