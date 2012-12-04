package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.CloudyBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level12 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level12()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 12;
			bg = new CloudyBackground();
			nextLevel = new Level13();
			
			lifeforceDeploymentInterval = 10800;
			asteroidDeploymentInterval = 1200;
			healthbarsDeploymentInterval = 8100;
			enemiesDeploymentInterval = 1300;
			lessDamageIconDeploymentInterval = 11600;
			tripleLaserIconDeploymentInterval = 12900;
			doubleMissileIconDeploymentInterval = 16300;
			doublePointIconDeploymentInterval = 18000;
			triplePointIconDeploymentInterval = 16000;
			
			numOfLifeforces = 8;
			numOfHealthbars = 8;
			numOfLessDamageIcons = 6;
			numOfTripleLaserIcons = 6;
			numOfDoubleMissileIcons = 7;
			numOfDoublePointIcons = 7;
			numOfTriplePointIcons = 7;
			numOfAsteroids = 65;
			numOfEnemies = 65;
			
			enemyShootingInterval = 850;
			
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
