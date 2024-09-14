package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.math.Vector2;
import objects.Confetti;

class VictoryState extends FlxSubState {
	var emitterX:Float;
	var emitterY:Float;
	var emitter:Confetti;

	public function new(level:Int, emitterCoords:Vector2) {
		Helper.saveNextLevel(level + 1);
		emitterX = emitterCoords.x;
		emitterY = emitterCoords.y;
		super();
	}

	public override function create() {
		add(new objects.Overlay());

		var victory = new FlxText(0, 0, 0, "Well Done!", 32);
		add(victory);
		victory.screenCenter();
		victory.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		victory.y -= victory.height;

		var select = new FlxText(0, 0, 0, "enter to continue", 18);
		add(select);
		select.screenCenter();

		emitter = new Confetti(emitterX, emitterY);
		add(emitter);
		emitter.start(true, 0.01, 0);

		super.create();
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER) {
			FlxG.switchState(new MenuState());
		}
	}
}
