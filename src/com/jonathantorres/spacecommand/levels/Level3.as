package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.CloudyBackground;

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
			lessDamageIconDeploymentInterval = 2000;
			tripleLaserIconDeploymentInterval = 2000;
			doubleMissileIconDeploymentInterval = 2000;
			doublePointIconDeploymentInterval = 3000;
			triplePointIconDeploymentInterval = 3000;
			numOfLifeforces = 10;
			numOfAsteroids = 25;
			numOfHealthbars = 10;
			numOfLessDamageIcons = 15;
			numOfTripleLaserIcons = 15;
			numOfDoubleMissileIcons = 15;
			numOfDoublePointIcons = 10;
			numOfTriplePointIcons = 10;
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
			initLessDamageIcons();
			initTripleLaserIcons();
			initDoubleMissileIcons();
			initDoublePointIcons();
			initTriplePointIcons();
			
			var levelIndicator : LevelIndicator = new LevelIndicator(gameLevel);
			levelIndicator.x = stage.stageWidth * 0.5;
			levelIndicator.y = stage.stageHeight * 0.5;
			addChild(levelIndicator);
		}
	}
}
