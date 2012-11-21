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
			
			lifeforceDeploymentInterval = 6000;
			asteroidDeploymentInterval = 6000;
			healthbarsDeploymentInterval = 5000;
			enemiesDeploymentInterval = 3000;
			lessDamageIconDeploymentInterval = 2000;
			tripleLaserIconDeploymentInterval = 2000;
			doubleMissileIconDeploymentInterval = 2000;
			numOfLifeforces = 15;
			numOfAsteroids = 15;
			numOfHealthbars = 15;
			numOfLessDamageIcons = 15;
			numOfTripleLaserIcons = 15;
			numOfDoubleMissileIcons = 15;
			numOfEnemies = 30;
			enemyShootingInterval = (Math.random() * 2000) + 1000; // 1 to 3 seconds
			typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE1, 
									   EnemyTypes.ENEMY_TYPE2,
									   EnemyTypes.ENEMY_TYPE3,
									   EnemyTypes.ENEMY_TYPE4,
									   EnemyTypes.ENEMY_TYPE5);
									   
			colorsOfEnemies = new Array(EnemyShipColors.BLUE, 
										EnemyShipColors.GRAY, 
										EnemyShipColors.GREEN, 
										EnemyShipColors.RED,
										EnemyShipColors.CHARCOAL,
										EnemyShipColors.GRAY);
			
			trace('Level: ' + gameLevel);
			
			addUI();
			initLasers();
			initEnemies();
			initHealthbars();
			initAsteroids();
			initLifeforces();
			initLessDamageIcons();
			initTripleLaserIcons();
			initDoubleMissileIcons();
			
			var startTween : Tween = new Tween(this, 0.7, Transitions.EASE_OUT);
			startTween.animate('x', 0);
			Starling.juggler.add(startTween);
		}
	}
}
