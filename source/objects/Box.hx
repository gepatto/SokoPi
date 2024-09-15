package objects;

class Box extends GameObject {
	public function new(x:Int = 0, y:Int = 0) {
		super(x, y);
		moveable = false;
		loadGraphic(AssetPaths.sokoban_tilesheet__png, true, 48, 48);
		animation.add("idle", [5]);
		animation.play("idle");
	}
}
