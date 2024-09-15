package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import lime.math.Vector2;
import objects.Hud;
import objects.Destination;
import objects.GameObject;
import objects.Player;
import objects.Raspberry;
import objects.Wall;
import objects.Box;

class PlayState extends FlxState {
	
	static var CAMERA_SPEED:Int = 8;
	
	var commander:CommandManager;

	var blocks:FlxTypedGroup<GameObject> = new FlxTypedGroup(100);
	var player:Player;
	var hud:Hud;
	var dest:Destination;
	var destinations:Array<Destination> = [];

	var room:String;
	var selectedLevel:Int;
	var movesText:FlxText;
	var tileSize:Int = 48;

	public function new(level:Int) {
		super();
		selectedLevel = level;
		var roomString = Helper.leftPad(level, "0");
		room = 'assets/data/room_0$roomString.json';
		
	}

	override public function create() {
		var bg = new FlxBackdrop(AssetPaths.bg_plain__png, 5, 5);
		add(bg);
		bg.scrollFactor.set(0,0);

		var map = new FlxOgmo3Loader(AssetPaths.sokpi__ogmo, room);
		var ground = map.loadTilemap(AssetPaths.sokoban_tilesheet__png, "walls");
		ground.follow();
		add(ground);

		commander = new CommandManager();
		map.loadEntities(placeEntities, "entities");

		for (i in 0...destinations.length) {
			add(destinations[i]);
		}
		add(blocks);
		add(player);

		camera.follow(player, FlxCameraFollowStyle.TOPDOWN,1);

		hud = new Hud();
		add(hud);
		updateMoves();

		super.create();
	}

	override public function update(elapsed:Float) {
		player.blocks = blocks;
		dest.blocks = blocks;
		super.update(elapsed);

		checkVictory();
		updateMoves();

		if (FlxG.keys.justPressed.Z)
			commander.undoCommand();

		if (FlxG.keys.justPressed.R)
			FlxG.switchState(new PlayState(selectedLevel));

		if (FlxG.keys.justPressed.ESCAPE)
			openSubState(new PauseState());
	}

	function updateMoves() {
		hud.updateHUD(commander.count,selectedLevel);
	}

	function checkVictory() {
		var matches = 0;

		for (destination in destinations) {
			for (block in blocks) {
				if (block.coordX == destination.coordX && block.coordY == destination.coordY) {
					matches++;
				}
			}
		}
		if (matches == destinations.length) {
			FlxG.camera.shake(0.01, 0.2);
			final vicState = new states.VictoryState(selectedLevel, new Vector2(player.x + player.width * .5, player.y - player.height * .5));
			openSubState(vicState);
		}
	}

	function placeEntities(entity:EntityData) {
		// Normalize coordinates based on tile size.
		var coordX = Std.int(entity.x / tileSize);
		var coordY = Std.int(entity.y / tileSize);

		if (entity.name == "player") {
			player = new Player(coordX, coordY, commander);
		} else if (entity.name == "destination") {
			dest = new Destination(coordX, coordY);
			destinations.push(dest);
		}

		var block:GameObject = switch (entity.name) {
			case "wall": new Wall(coordX, coordY);
			case "raspberry": new Raspberry(coordX, coordY);
			case "box": new Box(coordX, coordY);
			case _: null;
		}

		if (block != null)
			blocks.add(block);
	}
}
