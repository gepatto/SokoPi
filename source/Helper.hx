package;

import flixel.FlxG;

class Helper {
	public static inline var NUM_LEVELS = 10;

	public static function leftPad(n:Int, char:String):String {
		return n > 9 ? '$n' : '$char$n';
	}

	public static function getLevelProgress():Int {
		return FlxG.save.data.levelProgress != null ? FlxG.save.data.levelProgress : 1;
	}

	public static function saveNextLevel(next:Int) {
		if (next <= NUM_LEVELS && next > getLevelProgress()) {
			FlxG.save.data.levelProgress = next;
			FlxG.save.flush();
		}
	}
}
