package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.RocksBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level3 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level3()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 3;
			bg = new RocksBackground();
			nextLevel = new Level4();
			
			lifeforceDeploymentInterval = 9000;
			asteroidDeploymentInterval = 3000;
			healthbarsDeploymentInterval = 4500;
			enemiesDeploymentInterval = 2200;
			lessDamageIconDeploymentInterval = 8000;
			tripleLaserIconDeploymentInterval = 11500;
			doubleMissileIconDeploymentInterval = 10500;
			doublePointIconDeploymentInterval = 13000;
			triplePointIconDeploymentInterval = 14500;
			
			numOfLifeforces = 6;
			numOfHealthbars = 8;
			numOfLessDamageIcons = 4;
			numOfTripleLaserIcons = 3;
			numOfDoubleMissileIcons = 5;
			numOfDoublePointIcons = 5;
			numOfTriplePointIcons = 3;
			numOfAsteroids = 30;
			numOfEnemies = 30;
			
			enemyShootingInterval = 1200;
			enemiesSpeed = 0.01;
			asteroidsSpeed = 0.01;
			
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE1,
									   EnemyTypes.ENEMY_TYPE3,
									   EnemyTypes.ENEMY_TYPE4);
									   
			colorsOfEnemies = new Array(EnemyShipColors.BLUE,
										EnemyShipColors.RED,
										EnemyShipColors.BROWN,
										EnemyShipColors.RED);
			
			trace('Level: ' + gameLevel);
			
			addUI();
			initPools();
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
