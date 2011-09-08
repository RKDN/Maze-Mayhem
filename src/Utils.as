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
		
		public static function ontile(layer:String,x:uint,y:uint,width:uint,height:uint):uint
		{
			var ontile:uint;
			
			switch(layer)
			{
				case "floor":
					if(FlxG.keys.UP)
					{
						ontile = PlayState.floor.getTile(Math.floor((x + (width/2)) / Registry.tileSize), Math.floor(y / Registry.tileSize));
					}
					if(FlxG.keys.DOWN)
					{
						ontile = PlayState.floor.getTile(Math.floor((x + (width/2)) / Registry.tileSize), Math.floor(y+height) / Registry.tileSize);
					}
					if(FlxG.keys.LEFT)
					{
						ontile = PlayState.floor.getTile(Math.floor(x / Registry.tileSize), Math.floor((y + (height/2)) / Registry.tileSize));
					}
					if(FlxG.keys.RIGHT)
					{
						ontile = PlayState.floor.getTile(Math.floor((x + width) / Registry.tileSize), Math.floor((y + (height/2)) / Registry.tileSize));
					}
					else
					{
						ontile = PlayState.floor.getTile(Math.floor((x + (width/2)) / Registry.tileSize), Math.floor((y + (height/2)) / Registry.tileSize));
					}
				break;
				
				case "pickups":
					if(FlxG.keys.UP)
					{
						ontile = PlayState.pickups.getTile(Math.floor((x + (width/2)) / Registry.tileSize), Math.floor(y / Registry.tileSize));
					}
					if(FlxG.keys.DOWN)
					{
						ontile = PlayState.pickups.getTile(Math.floor((x + (width/2)) / Registry.tileSize), Math.floor(y+height) / Registry.tileSize);
					}
					if(FlxG.keys.LEFT)
					{
						ontile = PlayState.pickups.getTile(Math.floor(x / Registry.tileSize), Math.floor((y + (height/2)) / Registry.tileSize));
					}
					if(FlxG.keys.RIGHT)
					{
						ontile = PlayState.pickups.getTile(Math.floor((x + width) / Registry.tileSize), Math.floor((y + (height/2)) / Registry.tileSize));
					}
					else
					{
						ontile = PlayState.pickups.getTile(Math.floor((x + (width/2)) / Registry.tileSize), Math.floor((y + (height/2)) / Registry.tileSize));
					}
				break;
			}			
			return ontile;
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