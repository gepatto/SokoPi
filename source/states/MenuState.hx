package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Arrow extends FlxSprite {
	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		loadGraphic(AssetPaths.arrow_right__png);
	}
}

class MenuState extends FlxState {
	var arrow:Arrow;
	var levelIndex = 0;
	var levelProgress:Int;
	var bg:FlxBackdrop;

	inline static var NUM_COLUMNS = 3;

	override public function create() {
		levelProgress = Helper.getLevelProgress();
		levelIndex = levelProgress > 0 ? levelProgress - 1 : 0;

		bg = new FlxBackdrop(AssetPaths.bg__png, 0, 0);
		add(bg);
		bg.velocity.set(-12, 25);

		add(new objects.Overlay());

		var title = new FlxText(0, 0, 0, "SokoPi", 64);
		add(title);
		title.screenCenter();
		title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		title.y -= title.height + 20;

		arrow = new Arrow();
		add(arrow);
		arrow.x = (FlxG.width / 4) - (arrow.width + 20); // account for level text width

		createLevelSelect();

		var enter = new FlxText(0, 0, 0, "press enter", 28);
		add(enter);
		enter.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		enter.x = FlxG.width / 2 - enter.width / 2;
		enter.y = FlxG.width * 3 / 4;

		#if FLX_MOUSE
		FlxG.mouse.visible = false;
		#end

		super.create();
	}

	function createLevelSelect() {
		for (i in 0...(Helper.NUM_LEVELS)) {
			var level = i + 1;
			var levelDisplay = Helper.leftPad(level, "0");
			var text = new FlxText(0, 0, 0, levelDisplay, 24);

			if (level > levelProgress) {
				text.color = FlxColor.GRAY;
			}

			var offset = getColumnOffset(i);

			add(text);
			text.x = FlxG.width / 2 + offset.x * (FlxG.width / 8) - 2 * (FlxG.width / 8) + 20;
			text.y = FlxG.height / 2 + offset.y * 40 - text.height / 2;
		}
	}

	override function update(elasped:Float) {
		super.update(elasped);

		var offset = getColumnOffset(levelIndex);
		arrow.x = FlxG.width / 2 + offset.x * (FlxG.width / 8) - 2 * (FlxG.width / 8) - arrow.width / 2;
		arrow.y = FlxG.height / 2 + offset.y * 40 - arrow.height / 2;

		if (FlxG.keys.justPressed.ENTER) {
			selectLevel();
		}

		if (FlxG.keys.justPressed.UP) {
			levelIndex = clamp(levelIndex - 1);
		} else if (FlxG.keys.justPressed.DOWN) {
			levelIndex = clamp(levelIndex + 1);
		} else if (FlxG.keys.justPressed.RIGHT) {
			levelIndex = clamp(levelIndex + 3);
		} else if (FlxG.keys.justPressed.LEFT) {
			levelIndex = clamp(levelIndex - 3);
		}
	}

	function getColumnOffset(i:Int) {
		return { x: Std.int(Math.floor(i / NUM_COLUMNS)), y: i % NUM_COLUMNS };
	}

	function clamp(i:Int):Int {
		var clamped = i % levelProgress;
		if (clamped > levelProgress - 1) {
			return 0;
		}

		if (clamped < 0) {
			return levelProgress + clamped;
		}

		return clamped;
	}

	function selectLevel() {
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() {
			FlxG.switchState(new PlayState(levelIndex + 1));
		});
	}
}
