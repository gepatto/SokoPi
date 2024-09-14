package objects;

import CommandManager.Command;
import flixel.FlxG;
import flixel.group.FlxGroup;
import objects.GameObject.Point;

class Player extends GameObject {
	var commandManager:CommandManager;

	public var blocks:FlxTypedGroup<GameObject>;

	public function new(x:Int = 0, y:Int = 0, commander:CommandManager) {
		super(x, y);

		moveable = true;
		setSize(48, 48);
		commandManager = commander;

		loadGraphic(AssetPaths.sokoban_tilesheet__png, true, 48, 48);
		animation.add("left", [94, 95, 96, 94], 15, false);
		animation.add("right", [91, 92, 93, 91], 15, false);
		animation.add("up", [68, 69, 70, 68], 15, false);
		animation.add("down", [65, 66, 67, 65], 15, false);
		animation.add("idle", [65]);
		animation.play("idle");
	}

	override function update(elapsed:Float) {
		updateMovement();
		super.update(elapsed);
	}

	function updateMovement() {
		var cmd:Command = null;

		if (FlxG.keys.anyJustPressed([UP, W])) {
			cmd = tryMove({ x: 0, y: -1 });
		} else if (FlxG.keys.anyJustPressed([DOWN, S])) {
			cmd = tryMove({ x: 0, y: 1 });
		} else if (FlxG.keys.anyJustPressed([LEFT, A])) {
			cmd = tryMove({ x: -1, y: 0 });
		} else if (FlxG.keys.anyJustPressed([RIGHT, D])) {
			cmd = tryMove({ x: 1, y: 0 });
		}

		if (cmd != null)
			commandManager.addCommand(cmd);
	}

	// TODO: do this recursively
	function tryMove(dir:Point):Command {
		var next:{x:Int, y:Int} = { x: coordX + dir.x, y: coordY + dir.y };
		for (block in blocks) {
			var collides:Bool = block.coordX == next.x && block.coordY == next.y;

			if (collides && !block.passable && !block.moveable) {
				return null;
			} else if (collides && block.moveable) {
				var pushCmd:Command = push(block, dir);
				if (pushCmd == null) {
					return null;
				}
				return CommandManager.combine([move(dir), pushCmd]);
			}
		}

		return move(dir);
	}

	function push(block:GameObject, dir:Point):Command {
		var blockNext:{x:Int, y:Int} = { x: block.coordX + dir.x, y: block.coordY + dir.y }
		for (block in blocks) {
			var collides:Bool = block.coordX == blockNext.x && block.coordY == blockNext.y;

			if (collides && !block.passable) {
				return null;
			}
		}

		return block.move(dir);
	}
}
