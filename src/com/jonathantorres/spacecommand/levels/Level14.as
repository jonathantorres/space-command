package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.CloudyBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level14 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level14()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 14;
			bg = new CloudyBackground();
			nextLevel = new Level15();
			
			lifeforceDeploymentInterval = 11300;
			asteroidDeploymentInterval = 1000;
			healthbarsDeploymentInterval = 9000;
			enemiesDeploymentInterval = 1100;
			lessDamageIconDeploymentInterval = 12000;
			tripleLaserIconDeploymentInterval = 13900;
			doubleMissileIconDeploymentInterval = 17500;
			doublePointIconDeploymentInterval = 19500;
			triplePointIconDeploymentInterval = 17500;
			
			numOfLifeforces = 8;
			numOfHealthbars = 7;
			numOfLessDamageIcons = 7;
			numOfTripleLaserIcons = 8;
			numOfDoubleMissileIcons = 9;
			numOfDoublePointIcons = 8;
			numOfTriplePointIcons = 8;
			numOfAsteroids = 75;
			numOfEnemies = 75;
			
			enemyShootingInterval = 1000;
			enemiesSpeed = 0.06;
			asteroidsSpeed = 0.08;
			
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE1,
									   EnemyTypes.ENEMY_TYPE2,
									   EnemyTypes.ENEMY_TYPE3,
									   EnemyTypes.ENEMY_TYPE4,
									   EnemyTypes.ENEMY_TYPE5);
									   
			colorsOfEnemies = new Array(EnemyShipColors.SILVER,
										EnemyShipColors.CHARCOAL,
										EnemyShipColors.RED,
										EnemyShipColors.BLUE,
										EnemyShipColors.GRAY,
										EnemyShipColors.BROWN,
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
