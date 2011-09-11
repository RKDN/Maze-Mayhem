package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Button extends FlxSprite
	{
		
		public function Button(x:Number,y:Number) 
		{
			super(x, y);
			
			loadGraphic(Registry.ImgButton, false, true);
			
		}
		
		override public function update():void
        {
			velocity.x = 0;
			velocity.y = 0;
			
			if (overlaps(Registry.player) && Registry.toggled == false)
			{
				if (facing == FlxObject.LEFT)
				{
					facing = FlxObject.RIGHT;
				}
				else 
				{
					facing = FlxObject.LEFT;
				}
				
					//Swap left and right tiles
					Utils.replaceTiles("floor", Registry.tramRight, Registry.tempTile)
					Utils.replaceTiles("floor", Registry.tramLeft, Registry.tramRight);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramLeft);
					
					//Swap up and down tiles
					Utils.replaceTiles("floor", Registry.tramUp, Registry.tempTile);
					Utils.replaceTiles("floor", Registry.tramDown, Registry.tramUp);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramDown);
					
					//Swap bottom right tiles
					Utils.replaceTiles("floor", Registry.tramBR, Registry.tempTile);
					Utils.replaceTiles("floor", Registry.tramBRrev, Registry.tramBR);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramBRrev);
					
					//Swap bottom left tiles
					Utils.replaceTiles("floor", Registry.tramBL, Registry.tempTile);
					Utils.replaceTiles("floor", Registry.tramBLrev, Registry.tramBL);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramBLrev);
					
					//Swap top right tiles.
					Utils.replaceTiles("floor", Registry.tramTR, Registry.tempTile);
					Utils.replaceTiles("floor", Registry.tramTRrev, Registry.tramTR);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramTRrev);
					
					//Swap top left tiles
					Utils.replaceTiles("floor", Registry.tramTL, Registry.tempTile);
					Utils.replaceTiles("floor", Registry.tramTLrev, Registry.tramTL);
					Utils.replaceTiles("floor", Registry.tempTile, Registry.tramTLrev);
					
					//Play switch sound
					FlxG.play(Registry.switchSound);
					
					Registry.toggled = true;
			}
			
			if(!overlaps(Registry.player))
			{
				Registry.toggled = false;
			}
			super.update();
			
		}
		
	}

}