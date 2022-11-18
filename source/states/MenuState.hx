package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	override public function create()
	{
		var startButton:FlxButton;
		startButton = new FlxButton(0, 0, "Start", clickStart);
		add(startButton);
		startButton.screenCenter();
		super.create();
	}

	function clickStart()
	{
		FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
