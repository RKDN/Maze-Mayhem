package data
{
	import org.flixel.*;
	
	public class Registry
	{
		//Images
		[Embed(source = "/assets/player.png")] public static var ImgPlayer:Class;
		[Embed(source = "../assets/enemy.png")] public static var ImgEnemy:Class;
		[Embed(source = "../assets/coin.png")] public static var ImgCoin:Class;
		[Embed(source = "../assets/lava.png")] public static var ImgLava:Class;
		[Embed(source = "../assets/switch.png")] public static var ImgButton:Class;
		[Embed(source = "../assets/exit.png")] public static var ImgExit:Class;
		[Embed(source = "../assets/beltRight.png")] public static var rightBelt:Class;
		[Embed(source = "../assets/beltLeft.png")] public static var leftBelt:Class;
		[Embed(source = "../assets/beltUp.png")] public static var upBelt:Class;
		[Embed(source = "../assets/beltDown.png")] public static var downBelt:Class;
		[Embed(source = "../assets/beltTL.png")] public static var tlBelt:Class;
		[Embed(source = "../assets/beltBL.png")] public static var blBelt:Class;
		[Embed(source = "../assets/beltTR.png")] public static var trBelt:Class;
		[Embed(source = "../assets/beltBR.png")] public static var brBelt:Class;
		
		[Embed(source = "../assets/yellowkey.png")] public static var yellowKey:Class;
		[Embed(source = "../assets/blueKey.png")] public static var blueKey:Class;
		[Embed(source = "../assets/redKey.png")] public static var redKey:Class;
		[Embed(source = "../assets/greenkey.png")] public static var greenKey:Class;
		
		[Embed(source = "../assets/yellowDoor.png")] public static var yellowDoor:Class;
		[Embed(source = "../assets/blueDoor.png")] public static var blueDoor:Class;
		[Embed(source = "../assets/redDoor.png")] public static var redDoor:Class;
		[Embed(source = "../assets/greenDoor.png")] public static var greenDoor:Class;
		
		//Sounds
		[Embed(source = "/assets/sounds/coin.mp3")] public static var coinSound:Class;
		[Embed(source = "/assets/sounds/tram.mp3")] public static var tramSound:Class;
		[Embed(source = "/assets/sounds/switch.mp3")] public static var switchSound:Class;
		[Embed(source = "/assets/sounds/hit.mp3")] public static var hitSound:Class;
		
		//Maps
		[Embed(source = '/assets/levels/test.oel', mimeType = 'application/octet-stream')] public static var Level1:Class;
		[Embed(source = '/assets/levels/test.oel', mimeType = 'application/octet-stream')] public static var Level2:Class;
		
		//Music
		[Embed(source = "/assets/sounds/Cipher.mp3")] public static var music:Class;
		
		//Tilesheet
		[Embed(source="/assets/tiles.png")] public static var ImgTiles:Class;
		
		// Reference to the player
		public static var player:Player;
		
		//Enemy Spawn Tile
		public static var eSpawnTile:uint = 35;
		public static var agroDist:uint = 100;
		
		//Coin pull distance
		public static var coinDist:uint = 30;
		
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
		
		//Used for checking if the player is colliding
		public static var collideSolids:Boolean;
		public static var collideTrigger:Boolean;
		
		//Speed of the conveyor belts in the game.
		public static var tramSpeed:int = 1000;
		
		//Used for toggle switches.
		public static var toggled:Boolean = false;
		
		//Used for keeping player on belts around corners.
		public static var correctDist:int = 10;
		
		//Tile Variables
		
		public static var haskeys:Array = [];
		
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
		
		
		//Ice Tile
		public static var iceTile:uint = 22;		
		
		//Temp Tile
		public static var tempTile:uint = 18;
		
		//Blank Tile
		public static var blankTile:uint = 0;
		
		//Win variable
		public static var hasWon:Boolean = false;
	
	}
}