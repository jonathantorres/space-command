package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.RedRocksBackground;

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
			
			lifeforceDeploymentInterval = 7000;
			asteroidDeploymentInterval = 5000;
			healthbarsDeploymentInterval = 6000;
			enemiesDeploymentInterval = 2000;
			lessDamageIconDeploymentInterval = 2000;
			tripleLaserIconDeploymentInterval = 2000;
			doubleMissileIconDeploymentInterval = 2000;
			numOfLifeforces = 10;
			numOfAsteroids = 20;
			numOfHealthbars = 10;
			numOfLessDamageIcons = 15;
			numOfTripleLaserIcons = 15;
			numOfDoubleMissileIcons = 15;
			numOfEnemies = 40;
			enemyShootingInterval = (Math.random() * 2000) + 1000; // 1 to 3 seconds
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE1, EnemyTypes.ENEMY_TYPE2);
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
			initLessDamageIcons();
			initTripleLaserIcons();
			initDoubleMissileIcons();
			
			var levelIndicator : LevelIndicator = new LevelIndicator(gameLevel);
			levelIndicator.x = stage.stageWidth * 0.5;
			levelIndicator.y = stage.stageHeight * 0.5;
			addChild(levelIndicator);
		}
	}
}
