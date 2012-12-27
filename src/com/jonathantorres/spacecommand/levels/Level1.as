package com.jonathantorres.spacecommand.levels
{
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;

	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.ui.bg.RocksBackground;


	/**
	 * @author Jonathan Torres
	 */
	public class Level1 extends Level
	{
		private var _startTween : Tween;
		
		public function Level1()
		{
			super();
		}
		
		override protected function init() : void
		{
			this.x = stage.stageWidth;
			
			super.init();
			
			gameScore = 0;
			gameLevel = 1;
			bg = new RocksBackground();
			nextLevel = new Level2();
			
			lifeforceDeploymentInterval = 8000;
			asteroidDeploymentInterval = 5000;
			healthbarsDeploymentInterval = 4000;
			enemiesDeploymentInterval = 3000;
			lessDamageIconDeploymentInterval = 6000;
			tripleLaserIconDeploymentInterval = 10000;
			doubleMissileIconDeploymentInterval = 11000;
			doublePointIconDeploymentInterval = 12000;
			triplePointIconDeploymentInterval = 13000;
			
			numOfLifeforces = 6;
			numOfHealthbars = 8;
			numOfLessDamageIcons = 8;
			numOfTripleLaserIcons = 3;
			numOfDoubleMissileIcons = 3;
			numOfDoublePointIcons = 5;
			numOfTriplePointIcons = 5;
			numOfAsteroids = 15;
			numOfEnemies = 20;
			
			enemyShootingInterval = 1500;
			enemiesSpeed = 0.01;
			asteroidsSpeed = 0.01;
			
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE1, 
									   EnemyTypes.ENEMY_TYPE2,
									   EnemyTypes.ENEMY_TYPE3);
									   
			colorsOfEnemies = new Array(EnemyShipColors.BLUE, 
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
			
			_startTween = new Tween(this, 0.7, Transitions.EASE_OUT);
			_startTween.animate('x', 0);
			Starling.juggler.add(_startTween);
		}
	}
}
