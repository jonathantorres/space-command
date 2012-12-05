package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.RocksBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level2 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level2()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 2;
			bg = new RocksBackground();
			nextLevel = new Level3();
			
			lifeforceDeploymentInterval = 8000;
			asteroidDeploymentInterval = 4800;
			healthbarsDeploymentInterval = 4500;
			enemiesDeploymentInterval = 2500;
			lessDamageIconDeploymentInterval = 7300;
			tripleLaserIconDeploymentInterval = 11000;
			doubleMissileIconDeploymentInterval = 10000;
			doublePointIconDeploymentInterval = 12500;
			triplePointIconDeploymentInterval = 14000;
			
			numOfLifeforces = 8;
			numOfHealthbars = 10;
			numOfLessDamageIcons = 6;
			numOfTripleLaserIcons = 5;
			numOfDoubleMissileIcons = 5;
			numOfDoublePointIcons = 3;
			numOfTriplePointIcons = 3;
			numOfAsteroids = 20;
			numOfEnemies = 25;
			
			enemyShootingInterval = 1300;
			enemiesSpeed = 0.01;
			asteroidsSpeed = 0.01;
			
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE1, 
									   EnemyTypes.ENEMY_TYPE2,
									   EnemyTypes.ENEMY_TYPE3,
									   EnemyTypes.ENEMY_TYPE4);
									   
			colorsOfEnemies = new Array(EnemyShipColors.BLUE, 
										EnemyShipColors.GRAY, 
										EnemyShipColors.GREEN, 
										EnemyShipColors.RED,
										EnemyShipColors.BROWN);
			
			trace('Level: ' + gameLevel);
			
			addUI();
			initLasers();
			initMissiles();
			initEnemies();
			initHealthbars();
			initAsteroids();
			initLifeforces();
			initLessDamageIcons();
			initTripleLaserIcons();
			initDoubleMissileIcons();
			initDoublePointIcons();
			initTriplePointIcons();
			
			_levelIndicator = new LevelIndicator(gameLevel);
			_levelIndicator.x = stage.stageWidth * 0.5;
			_levelIndicator.y = stage.stageHeight * 0.5;
			addChild(_levelIndicator);
		}
	}
}
