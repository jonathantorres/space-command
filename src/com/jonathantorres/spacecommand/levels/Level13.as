package com.jonathantorres.spacecommand.levels
{
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.LevelIndicator;
	import com.jonathantorres.spacecommand.ui.bg.CloudyBackground;

	/**
	 * @author Jonathan Torres
	 */
	public class Level13 extends Level
	{
		private var _levelIndicator : LevelIndicator;
		
		public function Level13()
		{
			super();
		}
		
		override protected function init() : void
		{
			super.init();
			
			gameLevel = 13;
			bg = new CloudyBackground();
			nextLevel = new Level14();
			
			lifeforceDeploymentInterval = 11000;
			asteroidDeploymentInterval = 1000;
			healthbarsDeploymentInterval = 8500;
			enemiesDeploymentInterval = 1200;
			lessDamageIconDeploymentInterval = 11800;
			tripleLaserIconDeploymentInterval = 13500;
			doubleMissileIconDeploymentInterval = 16800;
			doublePointIconDeploymentInterval = 18500;
			triplePointIconDeploymentInterval = 16500;
			
			numOfLifeforces = 5;
			numOfHealthbars = 5;
			numOfLessDamageIcons = 8;
			numOfTripleLaserIcons = 8;
			numOfDoubleMissileIcons = 9;
			numOfDoublePointIcons = 9;
			numOfTriplePointIcons = 9;
			numOfAsteroids = 70;
			numOfEnemies = 70;
			
			enemyShootingInterval = 900;
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
