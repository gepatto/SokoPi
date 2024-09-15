package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class Hud extends FlxTypedGroup<FlxSprite>
{
	var background:FlxSprite;
    var movesText:FlxText;
    var level:FlxText;
    var selectedLevel:Int;
    var moves:Int;

	public function new()
	{
		super();

        level = new FlxText(0, 0, '', 16);
		add(level);

		movesText = new FlxText(level.x + level.width + 32, 0, '', 16);
		add(movesText);

        // keep hud from scrolling
        forEach(function(sprite) sprite.scrollFactor.set(0, 0));
    }

    public function updateHUD(moves:Int, currentLevel:Int)
    {
        level.text = 'level $currentLevel';
        movesText.text = '$moves moves';
        movesText.x = level.x + level.width + 32;
    }
}