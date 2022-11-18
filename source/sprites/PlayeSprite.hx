package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

enum Direction
{
	Up;
	Down;
	Left;
	Right;
	Nope;
}

class Player extends FlxSprite
{
	// This constant for your Player sprite movement speed
	static inline var SPEED:Float = 200;

	var direction:Direction = Nope;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.character_gajelas__png, true, 32, 32);
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		drag.x = drag.y = 1600;
	}

	function updateMovement()
	{
		// To store condition of pressed key
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		// To catch condition when a key pressed
		up = FlxG.keys.anyPressed([UP]);
		down = FlxG.keys.anyPressed([DOWN]);
		left = FlxG.keys.anyPressed([LEFT]);
		right = FlxG.keys.anyPressed([RIGHT]);

		// Semantic of pressed key condition
		if (up && down)
			direction = Nope;
		if (left && right)
			direction = Nope;

		if (up || down || left || right)
		{
			if (up)
				direction = Up;
			if (down)
				direction = Down;
			if (right)
				direction = Right;
			if (left)
				direction = Left;
		}

		var angle:Float = 0;
		angle = switch (direction)
		{
			case Up:
				-90;
			case Down:
				90;
			case Right:
				facing = RIGHT;
				0;
			case Left:
				facing = LEFT;
				180;
			case _:
				angle;
		};

		velocity.set(SPEED, 0);
		velocity.rotate(FlxPoint.weak(0, 0), angle);

		setFacingFlip(RIGHT, false, false);
		setFacingFlip(LEFT, true, false);

		if ((velocity.x != 0 || velocity.y != 0) && touching == NONE)
		{
			switch (direction)
			{
				case Left, Right:
					animation.play("lr");
				case Up:
					animation.play("u");
				case Down:
					animation.play("d");
				case _:
			}
		}
	}

	override public function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}
}
