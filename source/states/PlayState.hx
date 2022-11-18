package states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import ldtk.Level;
import sprites.PlayeSprite.Player;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();

		var ldtkMap = new LevelMap();

		// Iterate all world levels
		for (level in ldtkMap.levels)
		{
			// Create a FlxGroup for all level layers
			var container = new flixel.group.FlxSpriteGroup();
			add(container);

			// Place it using level world coordinates (in pixels)
			container.x = level.worldX;
			container.y = level.worldY;

			// Attach level background image, if any
			if (level.hasBgImage())
				container.add(level.getBgSprite());

			// Render layer "Background"
			level.l_Terrain.render(container);

			var playerPosition = level.l_PlayerPosition;

			var player:Player;
			player = new Player(playerPosition.pxTotalOffsetX, playerPosition.pxTotalOffsetY);

			container.add(player);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
