package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import ldtk.Level;
import sprites.PlayeSprite.Player;
import utils.LDtkUtils.gridTilesToTilemap;

class PlayState extends FlxState
{
	var collisionMap:FlxTilemap;
	var player:Player;

	override public function create()
	{
		super.create();

		// This for load the LDtk map class
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

			var terrain = level.l_Terrain;

			var csv = level.l_IntGrid.json.intGridCsv;

			collisionMap = new FlxTilemap();
			// TODO: still work in this for how efficient load collision layer.
			// collisionMap.loadMapFromArray(csv, 8, 8, AssetPaths.IntGrid_int__png, 32, 32);
			// collisionMap.loadMapFromArray(csv, 320, 320, AssetPaths.cyber_world_terain__png, 32, 32, AUTO, 0, 1, 2);
			collisionMap.loadMapFromCSV(AssetPaths.IntGrid__csv, AssetPaths.Terrain__png, 32, 32);
			// Render layer "Background"

			terrain.render(container);

			var playerPosition = level.l_PlayerPosition.all_Player[0];

			player = new Player(32, 32);

			container.add(player);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, collisionMap);
	}
}
