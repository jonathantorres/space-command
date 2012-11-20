package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.CloudyBackground;
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
			bg = new CloudyBackground();
			nextLevel = new Level3();
			
			lifeforceDeploymentInterval = 7500;
			asteroidDeploymentInterval = 4500;
			healthbarsDeploymentInterval = 7000;
			enemiesDeploymentInterval = 1800;
			numOfLifeforces = 10;
			numOfAsteroids = 25;
			numOfHealthbars = 10;
			numOfEnemies = 45;
			enemyShootingInterval = (Math.random() * 2000) + 1000; // 1 to 3 seconds
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE1);
			colorsOfEnemies = new Array(EnemyShipColors.BLUE, 
										EnemyShipColors.GRAY, 
										EnemyShipColors.GREEN, 
										EnemyShipColors.RED);
			
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
