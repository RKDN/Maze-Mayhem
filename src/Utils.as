package  
{
	import data.*
	import org.flixel.*;
	
	public class Utils 
	{
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
		
		public static function removeTile(layer:String,x:uint,y:uint):void
		{
			var location:uint;
			
			switch (layer)
			{
			case "floor":
			location = Math.floor(x / Registry.tileSize) + Math.floor(y / Registry.tileSize) * PlayState.floor.widthInTiles;
			PlayState.floor.setTileByIndex(location,Registry.blankTile)
			break;
			case "pickups":
			location = Math.floor(x / Registry.tileSize) + Math.floor(y / Registry.tileSize) * PlayState.pickups.widthInTiles;
			PlayState.pickups.setTileByIndex(location,Registry.blankTile)
			break;
			}
		}		
	}

}