package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.RedRocksBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level9 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level9()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 9;
			bg = new RedRocksBackground();
			nextLevel = new Level10();
			
			lifeforceDeploymentInterval = 5000;
			asteroidDeploymentInterval = 2000;
			healthbarsDeploymentInterval = 7000;
			enemiesDeploymentInterval = 2000;
			lessDamageIconDeploymentInterval = 12000;
			tripleLaserIconDeploymentInterval = 11200;
			doubleMissileIconDeploymentInterval = 16000;
			doublePointIconDeploymentInterval = 12900;
			triplePointIconDeploymentInterval = 13900;
			
			numOfLifeforces = 9;
			numOfHealthbars = 9;
			numOfLessDamageIcons = 10;
			numOfTripleLaserIcons = 15;
			numOfDoubleMissileIcons = 4;
			numOfDoublePointIcons = 4;
			numOfTriplePointIcons = 8;
			numOfAsteroids = 55;
			numOfEnemies = 40;
			
			enemyShootingInterval = 1000;
			enemiesSpeed = 0.04;
			asteroidsSpeed = 0.06;
			
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE1,
								       EnemyTypes.ENEMY_TYPE2,
									   EnemyTypes.ENEMY_TYPE3);
									   
			colorsOfEnemies = new Array(EnemyShipColors.GRAY,
										EnemyShipColors.GREEN,
										EnemyShipColors.RED,
										EnemyShipColors.BLUE);
			
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
