package objects;

import flixel.effects.particles.FlxEmitter.FlxTypedEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxColor;

// https://github.com/HaxeFlixel/flixel-demos/blob/master/Features/Particles/source/PlayState.hx
class Confetti extends FlxTypedEmitter<FlxParticle> {
	public function new(x:Float, y:Float) {
		super(x, y);
		makeParticles(6, 6, FlxColor.WHITE, 200);
		color.set(FlxColor.RED, FlxColor.PINK, FlxColor.BLUE, FlxColor.CYAN);
		lifespan.set(1, 3);
		acceleration.start.min.y = 50;
		acceleration.start.max.y = 100;
		acceleration.end.min.y = 50;
		acceleration.end.max.y = 500;
	}
}
