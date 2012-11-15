package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.levels.Level;

	/**
	 * @author Jonathan Torres
	 */
	public class Level3 extends Level
	{
		public function Level3()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 3;
			nextLevel = new Level3();
			
			trace('Level: ' + gameLevel);
			
			addUI();
			initLasers();
			initEnemies();
			initHealthbars();
			initAsteroids();
			initLifeforces();
		}
	}
}
