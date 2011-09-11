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
			if (type == "right") loadGraphic(Registry.rightBelt, false);
			if (type == "left") loadGraphic(Registry.leftBelt, false);
			if (type == "up") loadGraphic(Registry.upBelt, false);
			if (type == "down") loadGraphic(Registry.downBelt, false);
			
			immovable = true;
		}
		
		override public function update():void
        {
			velocity.x = 0;
			velocity.y = 0;
			
			if (FlxG.overlap(this,Registry.player)
			{
				if (beltType == "right") Registry.player.velocity.x = Registry.tramSpeed;
			}
			super.update();
			
		}
		
	}

}