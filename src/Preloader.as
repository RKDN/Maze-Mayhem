package
{
    import org.flixel.system.FlxPreloader;
 
    public class Preloader extends FlxPreloader
    {
        public function Preloader():void
        {
            className = "Main";
            super();
            minDisplayTime = 3; //Force the preloader to show for a minimum of 3 seconds
        }
    }
}