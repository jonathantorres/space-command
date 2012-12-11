package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.RedRocksBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level6 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level6()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 6;
			bg = new RedRocksBackground();
			nextLevel = new Level7();
			
			lifeforceDeploymentInterval = 8000;
			asteroidDeploymentInterval = 1500;
			healthbarsDeploymentInterval = 7000;
			enemiesDeploymentInterval = 2800;
			lessDamageIconDeploymentInterval = 10000;
			tripleLaserIconDeploymentInterval = 12000;
			doubleMissileIconDeploymentInterval = 13500;
			doublePointIconDeploymentInterval = 13900;
			triplePointIconDeploymentInterval = 16900;
			
			numOfLifeforces = 8;
			numOfHealthbars = 10;
			numOfLessDamageIcons = 6;
			numOfTripleLaserIcons = 4;
			numOfDoubleMissileIcons = 3;
			numOfDoublePointIcons = 7;
			numOfTriplePointIcons = 8;
			numOfAsteroids = 60;
			numOfEnemies = 30;
			
			enemyShootingInterval = 1200;
			enemiesSpeed = 0.03;
			asteroidsSpeed = 0.03;
			
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE4,
									   EnemyTypes.ENEMY_TYPE5);
									   
			colorsOfEnemies = new Array(EnemyShipColors.BLUE,
										EnemyShipColors.RED,
										EnemyShipColors.BROWN,
										EnemyShipColors.CHARCOAL,
										EnemyShipColors.SILVER,
										EnemyShipColors.GRAY);
			
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
