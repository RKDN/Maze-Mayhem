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
			if (beltType == "right") loadGraphic(Registry.lrudBelt, true,false,16,16);
			if (beltType == "left") loadGraphic(Registry.lrudBelt, true,false,16,16);
			if (beltType == "up") loadGraphic(Registry.lrudBelt, true,false,16,16);
			if (beltType == "down") loadGraphic(Registry.lrudBelt, true,false,16,16);
			if (beltType == "tr") loadGraphic(Registry.trBelt, false);
			if (beltType == "br") loadGraphic(Registry.brBelt, false);
			if (beltType == "tl") loadGraphic(Registry.tlBelt, false);
			if (beltType == "bl") loadGraphic(Registry.blBelt, false);
			
			addAnimation("up", [2]);
			addAnimation("down", [3]);
			addAnimation("left", [1]);
			addAnimation("right", [0]);
		}

		override public function update():void
        {
			super.update();
			
			if (Registry.beltForward)
			{
				if (beltType == "up") play("up");
				if (beltType == "down") play("down");
				if (beltType == "left") play("left");
				if (beltType == "right") play("right");
			}
			else
			{
				if (beltType == "down") play("up");
				if (beltType == "up") play("down");
				if (beltType == "right") play("left");
				if (beltType == "left") play("right");
			}
			
			if (FlxG.overlap(this,Registry.player))
			{
				if (Registry.beltForward)
				{
					if (beltType == "right") Registry.player.velocity.x = Registry.tramSpeed;
					if (beltType == "left") Registry.player.velocity.x = -Registry.tramSpeed;
					if (beltType == "up") Registry.player.velocity.y = -Registry.tramSpeed;
					if (beltType == "down") Registry.player.velocity.y = Registry.tramSpeed;	
				}
				else
				{
					if (beltType == "right") Registry.player.velocity.x = -Registry.tramSpeed;
					if (beltType == "left") Registry.player.velocity.x = Registry.tramSpeed;
					if (beltType == "up") Registry.player.velocity.y = Registry.tramSpeed;
					if (beltType == "down") Registry.player.velocity.y = -Registry.tramSpeed;
				}
				
				if (Registry.beltForward)
				{
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
				else
				{
					if (beltType == "tr")
					{
						Registry.player.velocity.x = -Registry.tramSpeed;
						Registry.player.velocity.y = -Registry.tramSpeed / 6;
					}
					if (beltType == "br")
					{
						Registry.player.velocity.x = Registry.tramSpeed / 6;
						Registry.player.velocity.y = -Registry.tramSpeed;
					}
					if (beltType == "tl")
					{
						Registry.player.velocity.x = -Registry.tramSpeed / 6;
						Registry.player.velocity.y = Registry.tramSpeed;
					}
					if (beltType == "bl")
					{
						Registry.player.velocity.x = Registry.tramSpeed;
						Registry.player.velocity.y = Registry.tramSpeed / 6;
					}	
				}
			}	
		}
		
	}

}