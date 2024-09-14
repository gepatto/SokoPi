package objects;

import CommandManager.Command;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;

typedef Point = {
	x:Int,
	y:Int
};

class GameObject extends FlxSprite {
	static inline var SIZE:Int = 48;

	public var coordX:Int;
	public var coordY:Int;

	public var moveable = false;
	public var passable = false;

	public function new(coordX:Int = 0, coordY:Int = 0) {
		super(0, 0);
		updatePosition(coordX, coordY, setPosition);
	}

	public function updatePosition(x:Int, y:Int, onUpdate:(Int, Int) -> Void) {
		coordX = x;
		coordY = y;
		onUpdate(x * SIZE, y * SIZE);
	}

	public function move(dir:Point):Command {
		if (!moveable)
			return null;

		var next = { x: coordX + dir.x, y: coordY + dir.y };
		var animationName = getAnimationName(dir);
		function execute() {
			updatePosition(next.x, next.y, (x, y) -> {
				FlxTween.tween(this, { x: x, y: y }, 0.1);
			});
			if (animation.exists(animationName))
				animation.play(animationName);
		}

		var prev = { x: coordX, y: coordY };
		function undo() {
			updatePosition(prev.x, prev.y, setPosition);
			if (animation.exists(animationName))
				animation.play(animationName);
		}

		return {
			execute: execute,
			undo: undo
		};
	}

	function getAnimationName(dir:Point) {
		return switch (dir) {
			case { x: 1, y: 0 }: "right";
			case { x: -1, y: 0 }: "left";
			case { x: 0, y: 1 }: "down";
			case { x: 0, y: -1 }: "up";
			case _: null;
		};
	}
}
