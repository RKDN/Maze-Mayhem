package 
{
    import org.flixel.*;
	import data.*
 
    public class PlayState extends FlxState
    {
		//Maps
		[Embed(source = 'assets/levels/map1.oel', mimeType = 'application/octet-stream')]
		private var Level1:Class;
		[Embed(source = 'assets/levels/map2.oel', mimeType = 'application/octet-stream')]
		private var Level2:Class;
		
		//Music
		[Embed(source = "assets/sounds/Cipher.mp3")] private var music:Class;
		
		[Embed(source="assets/tiles.png")]
		private var ImgTiles:Class;
		
		public static var spawn:FlxTilemap;
		public static var pickups:FlxTilemap;
		public static var floor:FlxTilemap;
		public static var solids:FlxTilemap;
		public static var foreground:FlxTilemap;
		public static var score:FlxText;
		public static var coinCount:uint;
			
        override public function create():void
        {	
			loadMap();	
			
			coinCount = pickups.getTileInstances(19).length;
			
			FlxG.camera.follow(Registry.player, FlxCamera.STYLE_TOPDOWN_TIGHT);
			FlxG.camera.zoom = 2;
			
			FlxG.playMusic(music, .5);
			
			super.create();
        }
        override public function update():void
        {
			super.update();
			Registry.collideCheck = FlxG.collide(Registry.player, solids);
			FlxG.collide(Registry.player, solids);
			Registry.timeThisLevel += FlxG.elapsed;
			score.text = "Coins " + String(Registry.scoreThisLevel) + " / " + String(coinCount) + "  " + "Press R to Restart Level.";
        }
		
		public function loadMap():void
		{
			//Load an Ogmo level File
			var level:OgmoLevel;
			
			if (!Registry.currentLevel) Registry.currentLevel = 1;
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
			var aplayerstart:Array = spawn.getTileInstances(20);
			var playerstart:uint = aplayerstart[0];
			Registry.player = new Player((playerstart % spawn.widthInTiles) * 16, (Math.round(playerstart / spawn.widthInTiles)) * 16 );
			
			
			add(Registry.player);
			add(foreground);
			
			//Score   
            score = new FlxText(FlxG.width/2/2,FlxG.height/2/2,300,"Score")
            score.setFormat(null, 8, 0xcccccccc)
			score.scrollFactor.x = 0;
			score.scrollFactor.y = 0;
            add(score);
		}
    }
}