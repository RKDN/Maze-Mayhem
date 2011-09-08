package data
{
	import org.flixel.*;
	
	public class Registry
	{
		//Player Image
		[Embed(source = "/assets/player.png")] public static var ImgPlayer:Class;
		
		//Sounds
		[Embed(source = "/assets/sounds/coin.mp3")] public static var coinSound:Class;
		[Embed(source = "/assets/sounds/tram.mp3")] public static var tramSound:Class;
		[Embed(source = "/assets/sounds/switch.mp3")] public static var switchSound:Class;
		[Embed(source = "/assets/sounds/hit.mp3")] public static var hitSound:Class;
		
		//Maps
		[Embed(source = '/assets/levels/test.oel', mimeType = 'application/octet-stream')] public static var Level1:Class;
		[Embed(source = '/assets/levels/map2.oel', mimeType = 'application/octet-stream')] public static var Level2:Class;
		
		//Music
		[Embed(source = "/assets/sounds/Cipher.mp3")] public static var music:Class;
		
		//Tilesheet
		[Embed(source="/assets/tiles.png")] public static var ImgTiles:Class;
		
		// Reference to the player
		public static var player:Player;
		
		// Speed the player moves
		public static var moveSpeed:int = 100;
		
		// Time spent on the level
		public static var timeThisLevel:Number = 0;
		
		// Time spent on the game
		public static var timeTotal:Number
		
		// Keeps track of the current level
		public static var currentLevel:int = 1;
		
		// Keeps track of the score for the current level
		public static var scoreThisLevel:int = 0;
		
		// Keeps track of the score for the whole game
		public static var scoreThisGame:int = 0;
		
		//Used for checking if the player is colliding with something.
		public static var collideCheck:Boolean;
		
		//Speed of the conveyor belts in the game.
		public static var tramSpeed:int = 100;
		
		//Used for keeping player on belts around corners.
		public static var correctDist:int = 10;
		
		//Tile Variables
		
		//Tile Size
		public static var tileSize:uint = 16;
		
		//Tram Tiles
		public static var tramLeft:uint = 4;
		public static var tramRight:uint = 3;
		public static var tramUp:uint = 5;
		public static var tramDown:uint = 6;
		public static var tramTL:uint = 29;
		public static var tramTR:uint = 28;
		public static var tramBL:uint = 30;
		public static var tramBR:uint = 27;
		public static var tramTLrev:uint = 32;
		public static var tramTRrev:uint = 31;
		public static var tramBLrev:uint = 33;
		public static var tramBRrev:uint = 34;
		public static var tramSwitch:uint = 8;
		public static var tramSwitchrev:uint = 23;
		
		//Keys
		public static var keyY:uint = 10;
		public static var keyB:uint = 11;
		public static var keyR:uint = 12;
		public static var keyG:uint = 13;
		public static var keyGone:uint = 21;
		
		//Doors
		public static var doorY:uint = 14;
		public static var doorB:uint = 15;
		public static var doorR:uint = 16;
		public static var doorG:uint = 17;
		
		//Coin Tile
		public static var coinTile:uint = 19;
		
		//Ice Tile
		public static var iceTile:uint = 22;
		
		//Lava Tile
		public static var lavaTile:uint = 7;
		
		//Spawn Tile
		public static var spawnTile:uint = 20;
		
		//Temp Tile
		public static var tempTile:uint = 18;
		
		//Blank Tile
		public static var blankTile:uint = 0;
		
		//Goal Tile
		public static var goalTile:uint = 2;
		
		//Win variable
		public static var hasWon:Boolean = false;
	
	}
}