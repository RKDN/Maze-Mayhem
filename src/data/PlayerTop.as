package data 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class PlayerTop extends FlxSprite
	{
		public var pistol:FlxWeapon;
		
		public function PlayerTop() 
		{
			super();
			
			loadGraphic(Registry.ImgPlayer, false, false)
			
			
			//Pistol
			pistol = new FlxWeapon("Pistol", this, "x", "y");
			pistol.makeImageBullet(50, Registry.ImgBullet,8,8);
			pistol.setBulletSpeed(300);
			pistol.setFireRate(400);
			pistol.setBulletRandomFactor(40, 40);
		}
		
		override public function update():void
        {
			this.angle = getAngle();
			super.update();
			
			//Update the area that bullets will be rendered in.
			pistol.setBulletBounds(new FlxRect(FlxG.camera.scroll.x - FlxG.width, FlxG.camera.scroll.y - FlxG.height, FlxG.width * 2, FlxG.height * 2));
			
			//Mouse click
			if (FlxG.mouse.justPressed())
			{
				pistol.fireAtMouse();
				pistol.fireAtMouse();
				pistol.fireAtMouse();
				pistol.fireAtMouse();
				pistol.fireAtMouse();
			}
			
		}
		
		public function getAngle():Number
		{
			// get relative mouse location
			var dx:Number = FlxG.mouse.x - (x + 8);
			var dy:Number = FlxG.mouse.y - (y + 8);
			
			// determine angle, convert to degrees
			var cursorAngle:Number = Math.atan2(dy,dx);
			var cursorDegrees:Number = 360*(cursorAngle/(2*Math.PI));
			
			// point at cursor
			return cursorDegrees;
		}
		
		public function get bullets():FlxGroup
		{
		return pistol.group;
		}
		
	}

}