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

		var overlay = new objects.Overlay();
		add(overlay.screenCenter(XY));
		
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
		
		select.scrollFactor.set(0,0);
		overlay.scrollFactor.set(0,0);
		victory.scrollFactor.set(0,0);

		super.create();

	}

	public override function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER) {
			FlxG.switchState(new MenuState());
		}
	}
}
