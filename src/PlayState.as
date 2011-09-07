package 
{
    import org.flixel.*;
	import data.*
 
    public class PlayState extends FlxState
    {
		//Maps
		[Embed(source = 'assets/levels/map1.oel', mimeType = 'application/octet-stream')] private var Level1:Class;
		[Embed(source = 'assets/levels/map2.oel', mimeType = 'application/octet-stream')] private var Level2:Class;
		
		//Music
		[Embed(source = "assets/sounds/Cipher.mp3")] private var music:Class;
		
		//Tilesheet
		[Embed(source="assets/tiles.png")] private var ImgTiles:Class;
		
		//Map layers
		public static var spawn:FlxTilemap;
		public static var pickups:FlxTilemap;
		public static var floor:FlxTilemap;
		public static var solids:FlxTilemap;
		public static var foreground:FlxTilemap;
		
		//Score
		public static var score:FlxText;
		
		//Number of coins in the level.
		public static var coinCount:uint;
			
        override public function create():void
        {	
			//load the map
			loadMap();	
			
			//count the number of coins in the level.
			coinCount = pickups.getTileInstances(Registry.coinTile).length;
			
			//Set the camera to follow the player.
			FlxG.camera.follow(Registry.player, FlxCamera.STYLE_TOPDOWN_TIGHT);
			
			//Set the camera zoom to 2;
			FlxG.camera.zoom = 2;
			
			//music
			FlxG.playMusic(music, .5);
			
			super.create();
        }
        override public function update():void
        {
			super.update();
			
			//Set our global variable for collision checks.
			Registry.collideCheck = FlxG.collide(Registry.player, solids);
			
			//Player collision check using Flixel collide code. Player will only collide with tiles on the solid layer.
			FlxG.collide(Registry.player, solids);
			
			//Keep track of how long the player has been on the level.
			Registry.timeThisLevel += FlxG.elapsed;
			
			//update score text
			score.text = "Coins " + String(Registry.scoreThisLevel) + " / " + String(coinCount) + "  " + "Press R to Restart Level.";
        }
		
		public function loadMap():void
		{
			//Load an Ogmo level File
			var level:OgmoLevel;
			
			//Decide which level we are on. Defaults to 1
			if (Registry.currentLevel == 1) level = new OgmoLevel(new Level1);
			if(Registry.currentLevel == 2) level = new OgmoLevel(new Level2);

			//Load each layer
			spawn = level.loadTilemap("spawn", ImgTiles);
			pickups= level.loadTilemap("pickups", ImgTiles);
			floor= level.loadTilemap("floor", ImgTiles);
			solids= level.loadTilemap("solids", ImgTiles);
			foreground = level.loadTilemap("foreground", ImgTiles);
			
			//add the layers to the state
			add(spawn)
			add(floor);
			add(pickups)
			add(solids);
			
			
			// Very odd way of spawning where spawn point was placed on map.
			var aplayerstart:Array = spawn.getTileInstances(Registry.spawnTile);
			var playerstart:uint = aplayerstart[0];
			Registry.player = new Player((playerstart % spawn.widthInTiles) * Registry.tileSize, (Math.round(playerstart / spawn.widthInTiles)) * Registry.tileSize );
			
			//Add the player to the screen.
			add(Registry.player);
			
			//add the foreground last so it is on top
			add(foreground);
			
			//Score setup
            score = new FlxText(FlxG.width/2/2,FlxG.height/2/2,300,"Score")
            score.setFormat(null, 8, 0xcccccccc)
			score.scrollFactor.x = 0;
			score.scrollFactor.y = 0;
			
			//add the score on top
            add(score);
		}
    }
}