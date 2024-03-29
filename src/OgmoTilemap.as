package
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	import org.flixel.system.FlxTilemapBuffer;
	import flash.display.*;
	import flash.geom.Rectangle;

	public class OgmoTilemap extends FlxTilemap
	{		
		public function OgmoTilemap(Width:int, Height:int):void
		{
			super();
			width = Width;
			height = Height;			
		}
		
		/*
		   Load a Tilemap type of layer
		*/ 
		public function loadTilemap(Layer:XML, TileGraphic:Class, DrawIndex:uint = 0, CollideIndex:uint = 1):OgmoTilemap
		{
			//refresh = true;

			var file:XML = Layer;
			
			//figure out the map dimmesions based on the xml and set variables			
			_tileWidth = file.@tileWidth;
			_tileHeight = file.@tileHeight;
			
			widthInTiles = width / _tileWidth;
			heightInTiles = height / _tileHeight;
			
			totalTiles = widthInTiles * heightInTiles;

			//load graphics
			_tiles = FlxG.addBitmap(TileGraphic);
			
			
			//create tile objects for overlap
			var i:uint = 0;
			var l:uint = (_tiles.width/_tileWidth) * (_tiles.height/_tileHeight);
			l++;
			_tileObjects = new Array(l);
			var ac:uint;
			while(i < l)
			{
				_tileObjects[i] = new FlxTile(this,i,_tileWidth,_tileHeight,(i >= DrawIndex),(i >= CollideIndex)?allowCollisions:NONE);
				i++;
			}

			
			//Initialize the data
			_data = new Array();
			for(var di:int; di < totalTiles; di++)
			{
				_data.push(0);
			}
			
			// Not sure yet
			_rects = new Array(totalTiles);
			

			//create debug tiles:
			_debugTileNotSolid = makeDebugTile(FlxG.BLUE);
			_debugTilePartial = makeDebugTile(FlxG.PINK);
			_debugTileSolid = makeDebugTile(FlxG.GREEN);
			_debugRect = new Rectangle(0,0, _tileWidth, _tileHeight);

			// Set rectTiles
			var t:XML
			for each (t in file.rect)
			{
				var startX:uint = t.@x;
				var startY:uint = t.@y;
				var tw:uint = t.@w / _tileWidth;
				var th:uint = t.@h / _tileHeight;

				for (var w:uint = 0; w < tw; ++w)
				{
					for (var h:uint = 0; h < th; ++h)
					{
						this.setTile((startX + (w*_tileWidth))/_tileWidth, (startY + (h*_tileHeight))/_tileHeight, t.@id, true);
					}
				}

			}

			// Set tiles
			for each (t in file.tile)
			{
				this.setTile((t.@x / _tileWidth), (t.@y / _tileHeight), t.@id, true);
			}

			
			return this;
		}
		
		/*
		   Load a grid type of layer.
		   
		   If you want to use the grid as an invisible tilemap to use it for
		   collision, provide a transparent png as TileGraphic.
		*/
		public function loadGrid(Layer:XML, TileGraphic:Class):FlxTilemap
		{
			var data:String = Layer.toString();
			var array:Array = new Array();
			
			var l:Array = data.split("\n");
			
			widthInTiles = l[0].length;

			
			var tmpString:String = ""
			for each(var i:String in l)
			{
				tmpString += i;
			}

			
			array = tmpString.split("");
			data = arrayToCSV(array, widthInTiles);
			var tmpMap:FlxTilemap = new FlxTilemap().loadMap(data, TileGraphic);
			return tmpMap;
		}		
	}
}
