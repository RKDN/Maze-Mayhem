package data
{
    import org.flixel.*;
 
    public class Registry
    {
 
        public static var player:Player; // Reference to the player
		public static var enemy:Enemy; // Reference to the enemies
		public static var moveSpeed:int = 100; // Speed the player moves
		public static var timeThisLevel:Number // Time spent on the level
		public static var timeTotal:Number // Time spent on the game
        public static var currentLevel:int; // Keeps track of the current level
        public static var scoreThisLevel:int = 0; // Keeps track of the score for the current level
        public static var scoreThisGame:int = 0; // Keeps track of the score for the whole game
        public static var enemiesKilledThisLevel:int; // Keeps track of the number of enemies killed this level
        public static var enemiesKilledThisGame:int;  // Keeps track of the number of enemies killed the whole game
		public static var collideCheck:Boolean;
		public static var tramSpeed:int = 100;
		public static var correctDist:int = 10;
		
        public function Registry()
        {
        }
    }
}