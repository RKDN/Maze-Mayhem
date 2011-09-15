package 
{
	import mx.core.FlexSprite;
    import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import data.*;
 
    public class PlayState extends FlxState
    {
		
		//Map layers
		public static var floor:FlxTilemap;
		public static var solids:FlxTilemap;
		public static var foreground:FlxTilemap;
		
		//Score
		public var score:FlxText;
		public var time:FlxText;
		
		//Number of coins in the level.
		public var coinCount:uint = 0;
		
		public var playertop:PlayerTop = new PlayerTop();
		
			
        override public function create():void
        {	
			
			Registry.solid = new FlxGroup();
			Registry.belts = new FlxGroup();
			
			//Set the mouse to visible.
			FlxG.mouse.show(Registry.ImgPoint);
			
			//load the map
			loadMap();
			
			//Set the camera to follow the player.
			FlxG.camera.follow(Registry.player, FlxCamera.STYLE_TOPDOWN_TIGHT);
			
			//Set the camera zoom to 2;
			FlxG.camera.zoom = 2;
			
			//music
			//FlxG.playMusic(Registry.music, .5);
			
			FlxG.camera.setBounds(0, 0, floor.width, floor.height);
			
			FlxG.worldBounds = new FlxRect(0, 0, floor.width, floor.height); 
			super.create();
        }
        override public function update():void
        {
			
			//Keeps the top of the player attached to the player mover
			if (playertop.x != Registry.player.x)
			{
				playertop.x = Registry.player.x;
			}
			if (playertop.y != Registry.player.y)
			{
				playertop.y = Registry.player.y;
			}
			
			super.update();
			
			//Set our global variable for collision checks.
			Registry.collideSolids = FlxG.collide(Registry.solid, Registry.solid);  
			
			
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
			
			//temporary fix
			if (Registry.currentLevel == 3) Registry.currentLevel = 1;
			
			//Decide which level we are on. Defaults to 1
			if (Registry.currentLevel == 1) level = new OgmoLevel(new Registry.Level1);
			if (Registry.currentLevel == 2) level = new OgmoLevel(new Registry.Level2);

			//Load each layer
			if (level.isLayer("floor")) floor = level.loadTilemap("floor", Registry.ImgTiles);
			if (level.isLayer("solids")) solids = level.loadTilemap("solids", Registry.ImgTiles);
			if (level.isLayer("foreground")) foreground = level.loadTilemap("foreground", Registry.ImgTiles);
			
			add(floor);
			add(solids);
			Registry.solid.add(solids);
			
			//Make keys
			var key:Key;
			for each(p in level.xml.actors.key)
			{
				key = new Key(p.@x, p.@y,p.@color);
				add(key);
			}
			
			//Make Doors
			var door:Door;
			for each(p in level.xml.actors.door)
			{
				door = new Door(p.@x, p.@y,p.@color);
				add(door);
				Registry.solid.add(door);
			}
			
			//Add coins to the level
			for each(p in level.xml.actors.coin)
			{
				//Create coins
				var coin:Coin = new Coin(p.@x, p.@y);
				add(coin);
				coinCount += 1;
			}
			
			//Add lava tiles.
			for each(p in level.xml.actors.lava)
			{
				var lava:Lava = new Lava(p.@x, p.@y);
				add(lava);
			}
			
			//Add switch tiles
			for each(p in level.xml.actors.button)
			{
				var button:Button = new Button(p.@x, p.@y);
				add(button);
			}
			
			//Add exit tile
			for each(p in level.xml.actors.exit)
			{
				var exit:Exit = new Exit(p.@x, p.@y);
				add(exit);
			}
			
			//Add belt tiles
			for each(p in level.xml.actors.belt)
			{
				var belt:Belt = new Belt(p.@x, p.@y,p.@type);
				add(belt);
				Registry.belts.add(belt);
			}
			
			for each(p in level.xml.actors.enemy)
			{
				//Create the enemies
				var enemy:Enemy = new Enemy(p.@x, p.@y);
				add(enemy);
				Registry.solid.add(enemy);
			}
			
			
			add(playertop.bullets);
			
			//Add the player to the screen.
			for each(p in level.xml.actors.spawn)
			{
				//Create the player
				Registry.player = new Player(p.@x, p.@y);
				add(Registry.player);
				Registry.solid.add(Registry.player);
			}
			
			add(playertop);
			
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