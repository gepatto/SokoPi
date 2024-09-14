package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PauseState extends FlxSubState {
	public override function create() {
		add(new objects.Overlay());
		var paddingTop = 48;

		var paused = new FlxText(0, 0, 0, "Paused", 32);
		add(paused);
		paused.screenCenter();
		paused.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		paused.y = FlxG.height / 4 - paused.height / 2;

		var z = new FlxText(0, 0, 0, "z: undo", 18);
		add(z);
		z.screenCenter();
		z.y = paused.y + paused.height / 2 + paddingTop - z.height / 2;

		var arrows = new FlxText(0, 0, 0, "arrow keys: move", 18);
		add(arrows);
		arrows.screenCenter();
		arrows.y = z.y + z.height / 2 + paddingTop - arrows.height / 2;

		var r = new FlxText(0, 0, 0, "r: reset level", 18);
		add(r);
		r.screenCenter();
		r.y = arrows.y + arrows.height / 2 + paddingTop - r.height / 2;
	}

	public override function update(elapsed:Float) {
		if (FlxG.keys.justPressed.ESCAPE)
			close();
	}
}
