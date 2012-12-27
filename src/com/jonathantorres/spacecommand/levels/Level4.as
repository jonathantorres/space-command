package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.RocksBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level4 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level4()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 4;
			bg = new RocksBackground();
			nextLevel = new Level5();
			
			lifeforceDeploymentInterval = 8200;
			asteroidDeploymentInterval = 2500;
			healthbarsDeploymentInterval = 4900;
			enemiesDeploymentInterval = 2000;
			lessDamageIconDeploymentInterval = 8500;
			tripleLaserIconDeploymentInterval = 11000;
			doubleMissileIconDeploymentInterval = 12500;
			doublePointIconDeploymentInterval = 13800;
			triplePointIconDeploymentInterval = 14800;
			
			numOfLifeforces = 8;
			numOfHealthbars = 4;
			numOfLessDamageIcons = 4;
			numOfTripleLaserIcons = 4;
			numOfDoubleMissileIcons = 4;
			numOfDoublePointIcons = 4;
			numOfTriplePointIcons = 4;
			numOfAsteroids = 40;
			numOfEnemies = 30;
			
			enemyShootingInterval = 1000;
			enemiesSpeed = 0.02;
			asteroidsSpeed = 0.02;
			
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE1, 
									   EnemyTypes.ENEMY_TYPE2,
									   EnemyTypes.ENEMY_TYPE3,
									   EnemyTypes.ENEMY_TYPE4,
									   EnemyTypes.ENEMY_TYPE5);
									   
			colorsOfEnemies = new Array(EnemyShipColors.BLUE,
										EnemyShipColors.RED,
										EnemyShipColors.BROWN,
										EnemyShipColors.CHARCOAL,
										EnemyShipColors.SILVER);
			
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
