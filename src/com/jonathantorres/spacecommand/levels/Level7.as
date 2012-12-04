package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.RedRocksBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level7 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level7()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 7;
			bg = new RedRocksBackground();
			nextLevel = new Level8();
			
			lifeforceDeploymentInterval = 8300;
			asteroidDeploymentInterval = 2000;
			healthbarsDeploymentInterval = 7200;
			enemiesDeploymentInterval = 2000;
			lessDamageIconDeploymentInterval = 11000;
			tripleLaserIconDeploymentInterval = 12000;
			doubleMissileIconDeploymentInterval = 13500;
			doublePointIconDeploymentInterval = 15900;
			triplePointIconDeploymentInterval = 16900;
			
			numOfLifeforces = 10;
			numOfHealthbars = 10;
			numOfLessDamageIcons = 10;
			numOfTripleLaserIcons = 8;
			numOfDoubleMissileIcons = 6;
			numOfDoublePointIcons = 6;
			numOfTriplePointIcons = 7;
			numOfAsteroids = 40;
			numOfEnemies = 40;
			
			enemyShootingInterval = 1000;
			
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE4,
									   EnemyTypes.ENEMY_TYPE5,
									   EnemyTypes.ENEMY_TYPE2);
									   
			colorsOfEnemies = new Array(EnemyShipColors.BLUE,
										EnemyShipColors.RED,
										EnemyShipColors.BROWN,
										EnemyShipColors.CHARCOAL,
										EnemyShipColors.SILVER,
										EnemyShipColors.GRAY,
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
