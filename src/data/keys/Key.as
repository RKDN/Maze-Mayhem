package data.keys 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import data.*
	
	public class Key extends FlxSprite
	{
		
		private var keyColor:String;
		public function Key(x:Number,y:Number,color:String) 
		{
			super(x, y);
			
			keyColor = color;
			if (keyColor == "yellow") loadGraphic(Registry.yellowKey, false);
			if (keyColor == "red") loadGraphic(Registry.redKey, false);
			if (keyColor == "blue") loadGraphic(Registry.blueKey, false);
			if (keyColor == "green") loadGraphic(Registry.greenKey, false);
		}
		
		override public function update():void
        {
			velocity.x = 0;
			velocity.y = 0;
			
			if (Utils.getDistance(this, Registry.player) <= Registry.coinDist) 
			{
				FlxVelocity.moveTowardsObject(this, Registry.player, 30);
			}
			
			if (FlxG.overlap(this,Registry.player))
			{
				Registry.haskeys.push(keyColor);
				FlxG.play(Registry.switchSound);
				this.exists = false;
			}
			super.update();
			
		}
		
	}

}