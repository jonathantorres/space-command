package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.CloudyBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level11 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level11()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 11;
			bg = new CloudyBackground();
			nextLevel = new Level12();
			
			lifeforceDeploymentInterval = 10500;
			asteroidDeploymentInterval = 1300;
			healthbarsDeploymentInterval = 7800;
			enemiesDeploymentInterval = 1500;
			lessDamageIconDeploymentInterval = 11300;
			tripleLaserIconDeploymentInterval = 12400;
			doubleMissileIconDeploymentInterval = 15800;
			doublePointIconDeploymentInterval = 17000;
			triplePointIconDeploymentInterval = 15000;
			
			numOfLifeforces = 7;
			numOfHealthbars = 8;
			numOfLessDamageIcons = 11;
			numOfTripleLaserIcons = 5;
			numOfDoubleMissileIcons = 8;
			numOfDoublePointIcons = 6;
			numOfTriplePointIcons = 7;
			numOfAsteroids = 60;
			numOfEnemies = 60;
			
			enemyShootingInterval = 900;
			enemiesSpeed = 0.04;
			asteroidsSpeed = 0.07;
			
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
