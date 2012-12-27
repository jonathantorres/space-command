package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.RedRocksBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level8 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level8()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 8;
			bg = new RedRocksBackground();
			nextLevel = new Level9();
			
			lifeforceDeploymentInterval = 7000;
			asteroidDeploymentInterval = 1800;
			healthbarsDeploymentInterval = 7500;
			enemiesDeploymentInterval = 2000;
			lessDamageIconDeploymentInterval = 12000;
			tripleLaserIconDeploymentInterval = 11000;
			doubleMissileIconDeploymentInterval = 15500;
			doublePointIconDeploymentInterval = 13900;
			triplePointIconDeploymentInterval = 12900;
			
			numOfLifeforces = 8;
			numOfHealthbars = 8;
			numOfLessDamageIcons = 15;
			numOfTripleLaserIcons = 10;
			numOfDoubleMissileIcons = 7;
			numOfDoublePointIcons = 9;
			numOfTriplePointIcons = 7;
			numOfAsteroids = 45;
			numOfEnemies = 45;
			
			enemyShootingInterval = 1300;
			enemiesSpeed = 0.03;
			asteroidsSpeed = 0.05;
			
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE4,
									   EnemyTypes.ENEMY_TYPE5,
									   EnemyTypes.ENEMY_TYPE2,
									   EnemyTypes.ENEMY_TYPE3);
									   
			colorsOfEnemies = new Array(EnemyShipColors.CHARCOAL,
										EnemyShipColors.SILVER,
										EnemyShipColors.GRAY,
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
