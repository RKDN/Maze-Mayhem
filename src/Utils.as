package  
{
	import data.*
	import org.flixel.*;
	
	public class Utils 
	{
		
		public static function getDistance(P1:FlxSprite, P2:FlxSprite):Number
		{
			var XX:Number = P2.x - P1.x;
			var YY:Number = P2.y - P1.y;
			return Math.sqrt( XX * XX + YY * YY );
		
		}
		
		
		public static function replaceTiles(layer:String,x:uint,n:uint):void
		{
			var i:uint = 0;
			var Tiles:Array;
			
			switch (layer)
			{
			case "solids":
			Tiles = PlayState.solids.getTileInstances(x);
			if (Tiles)
				{
					for (i = 0; i < Tiles.length; i++) 
					{
						PlayState.solids.setTileByIndex(Tiles[i], n, true);	
					}
				}
			break;
			case "floor":
			Tiles = PlayState.floor.getTileInstances(x);
			if (Tiles)
				{
					for (i = 0; i < Tiles.length; i++) 
					{
						PlayState.floor.setTileByIndex(Tiles[i], n, true);
					}
				}
			break;
			}
		}
		
		//Some usefull checking functions.
		public static function checkTopLeft():uint
		{
			return PlayState.solids.getTile(Math.floor((Registry.player.x + Registry.player.width - Registry.tileSize) / Registry.tileSize), Math.floor((Registry.player.y + Registry.player.height - Registry.tileSize) / Registry.tileSize))
		}
		public static function checkTopRight():uint
		{
			return PlayState.solids.getTile(Math.floor((Registry.player.x + Registry.tileSize) / Registry.tileSize), Math.floor((Registry.player.y  + Registry.player.height - Registry.tileSize) / Registry.tileSize))
		}
		public static function checkBotLeft():uint
		{
			return PlayState.solids.getTile(Math.floor((Registry.player.x + Registry.player.width - Registry.tileSize) / Registry.tileSize), Math.floor((Registry.player.y + Registry.tileSize) / Registry.tileSize))
		}
		public static function checkBotRight():uint
		{
			return PlayState.solids.getTile(Math.floor((Registry.player.x + Registry.tileSize) / Registry.tileSize), Math.floor((Registry.player.y + Registry.tileSize) / Registry.tileSize))
		}
	}

}