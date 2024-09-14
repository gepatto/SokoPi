package objects;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Overlay extends FlxSprite {
	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		makeGraphic(640, 480, FlxColor.BLACK);
		alpha = 0.3;
	}
}
