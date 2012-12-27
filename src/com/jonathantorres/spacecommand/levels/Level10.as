package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.CloudyBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level10 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level10()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 10;
			bg = new CloudyBackground();
			nextLevel = new Level11();
			
			lifeforceDeploymentInterval = 10000;
			asteroidDeploymentInterval = 1000;
			healthbarsDeploymentInterval = 7500;
			enemiesDeploymentInterval = 2300;
			lessDamageIconDeploymentInterval = 11000;
			tripleLaserIconDeploymentInterval = 12200;
			doubleMissileIconDeploymentInterval = 15500;
			doublePointIconDeploymentInterval = 16900;
			triplePointIconDeploymentInterval = 14900;
			
			numOfLifeforces = 9;
			numOfHealthbars = 9;
			numOfLessDamageIcons = 10;
			numOfTripleLaserIcons = 15;
			numOfDoubleMissileIcons = 4;
			numOfDoublePointIcons = 4;
			numOfTriplePointIcons = 8;
			numOfAsteroids = 70;
			numOfEnemies = 50;
			
			enemyShootingInterval = 1000;
			enemiesSpeed = 0.04;
			asteroidsSpeed = 0.06;
			
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE3,
									   EnemyTypes.ENEMY_TYPE4,
									   EnemyTypes.ENEMY_TYPE5);
									   
			colorsOfEnemies = new Array(EnemyShipColors.SILVER,
										EnemyShipColors.CHARCOAL,
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
