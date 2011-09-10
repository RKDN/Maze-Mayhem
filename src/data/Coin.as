package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Coin extends FlxSprite
	{
		
		
		public function Coin(x:Number,y:Number) 
		{
			super(x, y);
			
			loadGraphic(Registry.ImgCoin, true, false)
			addAnimation("spin", [0, 1, 2, 3, 4, 5, 6, 7], 10);
		}
		
		override public function update():void
        {
			velocity.x = 0;
			velocity.y = 0;
			
			play("spin")
			
			if (Utils.getDistance(this, Registry.player) <= Registry.coinDist) 
			{
				FlxVelocity.moveTowardsObject(this, Registry.player, 30);
			}
			
			if (FlxG.overlap(this,Registry.player))
			{
				Registry.scoreThisLevel += 1;
				FlxG.play(Registry.coinSound);
				this.exists = false;
			}
			super.update();
			
		}
		
	}

}