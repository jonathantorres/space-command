package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.ui.RedRocksBackground;
	import com.jonathantorres.spacecommand.levels.Level;

	/**
	 * @author Jonathan Torres
	 */
	public class Level2 extends Level
	{
		public function Level2()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 2;
			bg = new RedRocksBackground();
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
