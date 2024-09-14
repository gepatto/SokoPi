package objects;

class Raspberry extends GameObject {
	public function new(x:Int = 0, y:Int = 0) {
		super(x, y);
		moveable = true;
		loadGraphic(AssetPaths.sokoban_tilesheet__png, true, 48, 48);
		animation.add("idle", [4]);
		animation.play("idle");
	}
}
