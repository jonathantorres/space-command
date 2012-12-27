package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.CloudyBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level15 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level15()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 15;
			bg = new CloudyBackground();
			nextLevel = new Level15();
			
			lifeforceDeploymentInterval = 11800;
			asteroidDeploymentInterval = 900;
			healthbarsDeploymentInterval = 9500;
			enemiesDeploymentInterval = 1000;
			lessDamageIconDeploymentInterval = 12500;
			tripleLaserIconDeploymentInterval = 14000;
			doubleMissileIconDeploymentInterval = 18000;
			doublePointIconDeploymentInterval = 20000;
			triplePointIconDeploymentInterval = 18000;
			
			numOfLifeforces = 9;
			numOfHealthbars = 9;
			numOfLessDamageIcons = 8;
			numOfTripleLaserIcons = 9;
			numOfDoubleMissileIcons = 10;
			numOfDoublePointIcons = 7;
			numOfTriplePointIcons = 6;
			numOfAsteroids = 80;
			numOfEnemies = 80;
			
			enemyShootingInterval = 900;
			enemiesSpeed = 0.06;
			asteroidsSpeed = 0.09;
			
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
