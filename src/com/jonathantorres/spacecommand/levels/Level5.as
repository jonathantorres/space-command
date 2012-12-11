package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.RedRocksBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level5 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level5()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 5;
			bg = new RedRocksBackground();
			nextLevel = new Level6();
			
			lifeforceDeploymentInterval = 9900;
			asteroidDeploymentInterval = 2000;
			healthbarsDeploymentInterval = 6000;
			enemiesDeploymentInterval = 2300;
			lessDamageIconDeploymentInterval = 9000;
			tripleLaserIconDeploymentInterval = 12000;
			doubleMissileIconDeploymentInterval = 12500;
			doublePointIconDeploymentInterval = 14800;
			triplePointIconDeploymentInterval = 15800;
			
			numOfLifeforces = 10;
			numOfHealthbars = 8;
			numOfLessDamageIcons = 3;
			numOfTripleLaserIcons = 3;
			numOfDoubleMissileIcons = 5;
			numOfDoublePointIcons = 5;
			numOfTriplePointIcons = 8;
			numOfAsteroids = 35;
			numOfEnemies = 50;
			
			enemyShootingInterval = 1100;
			enemiesSpeed = 0.02;
			asteroidsSpeed = 0.03;
			
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE1, 
									   EnemyTypes.ENEMY_TYPE2,
									   EnemyTypes.ENEMY_TYPE3,
									   EnemyTypes.ENEMY_TYPE4,
									   EnemyTypes.ENEMY_TYPE5);
									   
			colorsOfEnemies = new Array(EnemyShipColors.BLUE,
										EnemyShipColors.RED,
										EnemyShipColors.BROWN,
										EnemyShipColors.CHARCOAL,
										EnemyShipColors.SILVER,
										EnemyShipColors.GREEN);
			
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
