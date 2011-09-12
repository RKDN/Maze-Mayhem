package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Door extends FlxSprite
	{
		private var colorDoor:String;
		
		public function Door(x:Number,y:Number,color:String) 
		{
			super(x, y);
			colorDoor = color;
			if (colorDoor == "yellow") loadGraphic(Registry.yellowDoor, false);
			if (colorDoor == "red") loadGraphic(Registry.redDoor, false);
			if (colorDoor == "blue") loadGraphic(Registry.blueDoor, false);
			if (colorDoor == "green") loadGraphic(Registry.greenDoor, false);
			
			immovable = true;
		}
		
		override public function update():void
        {
			velocity.x = 0;
			velocity.y = 0;
			
			if (isTouching(FlxObject.ANY))
			{
				for (var i:Number = 0; i < Registry.haskeys.length; i++)
				{
					if (Registry.haskeys[i] == colorDoor )
					{
							FlxG.play(Registry.switchSound);
							this.exists = false;
					}
				}
			}
			super.update();
			
		}
		
	}

}