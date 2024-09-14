package objects;

import flixel.group.FlxGroup.FlxTypedGroup;

class Destination extends GameObject {
	public var blocks:FlxTypedGroup<GameObject>;

	public function new(x:Int = 0, y:Int = 0) {
		super(x, y);
		passable = true;
		loadGraphic(AssetPaths.sokoban_tilesheet__png, true, 48, 48);
		animation.add("idle", [37]);
		animation.play("idle");
	}
}
