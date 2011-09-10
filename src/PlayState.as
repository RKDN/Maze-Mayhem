package 
{
	import mx.core.FlexSprite;
    import org.flixel.*;
	import data.*;
	import data.doors.*
	import data.keys.*
 
    public class PlayState extends FlxState
    {
		
		//Map layers
		public static var spawn:FlxTilemap;
		public static var pickups:FlxTilemap;
		public static var floor:FlxTilemap;
		public static var solids:FlxTilemap;
		public static var foreground:FlxTilemap;
		
		//Score
		public static var score:FlxText;
		public static var time:FlxText;
		
		//Number of coins in the level.
		public static var coinCount:uint = 0;
		
		public static var solid:FlxGroup;
		public static var pickup:FlxGroup;
		public static var triggers:FlxGroup;
			
        override public function create():void
        {	
			
			solid = new FlxGroup();
			pickup = new FlxGroup();
			triggers = new FlxGroup();
			
			//load the map
			loadMap();
			
			//Set the camera to follow the player.
			FlxG.camera.follow(Registry.player, FlxCamera.STYLE_TOPDOWN_TIGHT);
			
			//Set the camera zoom to 2;
			FlxG.camera.zoom = 2;
			
			//music
			FlxG.playMusic(Registry.music, .5);
			
			FlxG.camera.setBounds(0, 0, floor.width, floor.height);
			
			FlxG.worldBounds = new FlxRect(0, 0, floor.width, floor.height); 
			super.create();
        }
        override public function update():void
        {
			super.update();
			
			//Set our global variable for collision checks.
			Registry.collideCheck = FlxG.collide(solid, solids);
			Registry.coinCollide = FlxG.collide(Registry.player, pickup);
			Registry.collideSolids = FlxG.collide(solid, solid);
			Registry.collideTrigger = FlxG.collide(solid, triggers);
			
			
			//Keep track of how long the player has been on the level.
			Registry.timeThisLevel += FlxG.elapsed;
			
			//update score text
			score.text = "Coins " + String(Registry.scoreThisLevel) + " / " + String(coinCount)  + "   " + "Press R to Restart Level.";
			
			//update time text
			time.text = "Time: " + String(FlxU.formatTime(Registry.timeThisLevel));
        }
		
		public function loadMap():void
		{
			//Load an Ogmo level File
			var level:OgmoLevel;
			var p:XML;
			
			//Decide which level we are on. Defaults to 1
			if (Registry.currentLevel == 1) level = new OgmoLevel(new Registry.Level1);
			if(Registry.currentLevel == 2) level = new OgmoLevel(new Registry.Level2);

			//Load each layer
			if (level.isLayer("floor")) floor = level.loadTilemap("floor", Registry.ImgTiles);
			if (level.isLayer("solids")) solids = level.loadTilemap("solids", Registry.ImgTiles);
			if (level.isLayer("foreground")) foreground = level.loadTilemap("foreground", Registry.ImgTiles);
			
			add(floor);
			add(solids);
			
			for each(p in level.xml.actors.enemy)
			{
				//Create the enemies
				var enemy:Enemy = new Enemy(p.@x, p.@y);
				add(enemy);
				solid.add(enemy);
			}
			
			//Make keys
			var key:Key;
			for each(p in level.xml.actors.yellowkey)
			{
				//Create yellowKey
				key = new Key(p.@x, p.@y,"yellow");
				add(key);
			}
			for each(p in level.xml.actors.bluekey)
			{
				//Create blueKey
				key = new Key(p.@x, p.@y,"blue");
				add(key);
			}
			for each(p in level.xml.actors.greenkey)
			{
				//Create greenKey
				key = new Key(p.@x, p.@y,"green");
				add(key);
			}
			for each(p in level.xml.actors.redkey)
			{
				//Create redKey
				key = new Key(p.@x, p.@y,"red");
				add(key);
			}
			
			//Make Doors
			var door:Door;
			for each(p in level.xml.actors.yellowdoor)
			{
				//Create yellowDoor
				door = new Door(p.@x, p.@y,"yellow");
				add(door);
				triggers.add(door);
			}
			for each(p in level.xml.actors.bluedoor)
			{
				//Create blueDoor
				door = new Door(p.@x, p.@y,"blue");
				add(door);
				triggers.add(door);
			}
			for each(p in level.xml.actors.greendoor)
			{
				//Create greenDoor
				door = new Door(p.@x, p.@y,"green");
				add(door);
				triggers.add(door);
			}
			for each(p in level.xml.actors.reddoor)
			{
				//Create redDoor
				door = new Door(p.@x, p.@y,"red");
				add(door);
				triggers.add(door);
			}
			
			//Add the player to the screen.
			for each(p in level.xml.actors.spawn)
			{
				//Create the player
				Registry.player = new Player(p.@x, p.@y);
				add(Registry.player);
				solid.add(Registry.player)
			}
			
			for each(p in level.xml.actors.coin)
			{
				//Create coins
				var coin:Coin = new Coin(p.@x, p.@y);
				add(coin);
				coinCount += 1;
			}
			
			//add the foreground last so it is on top
			add(foreground);
			
			//Score setup
            score = new FlxText(5,5,300,"Score")
            score.setFormat(null, 8, 0xcccccccc)
			score.scrollFactor.x = 0;
			score.scrollFactor.y = 0;
			
			//Time display setup
			time = new FlxText(5,FlxG.height - 15 ,300,"Time")
            time.setFormat(null, 8, 0xcccccccc)
			time.scrollFactor.x = 0;
			time.scrollFactor.y = 0;
			
			//add the score on top
            add(score);
			//add time to screen
			add(time);
		}
    }
}