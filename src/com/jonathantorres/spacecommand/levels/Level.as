package com.jonathantorres.spacecommand.levels
{
	import starling.display.Sprite;
	import starling.events.Event;

	import com.jonathantorres.spacecommand.consts.AsteroidSizes;
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.consts.LaserColors;
	import com.jonathantorres.spacecommand.menu.GameOver;
	import com.jonathantorres.spacecommand.objects.Asteroid;
	import com.jonathantorres.spacecommand.objects.EnemyShip;
	import com.jonathantorres.spacecommand.objects.Health;
	import com.jonathantorres.spacecommand.objects.Laser;
	import com.jonathantorres.spacecommand.objects.Lifeforce;
	import com.jonathantorres.spacecommand.objects.PlayerShip;
	import com.jonathantorres.spacecommand.ui.GameBackground;
	import com.jonathantorres.spacecommand.ui.LevelNumber;
	import com.jonathantorres.spacecommand.ui.Lifebar;
	import com.jonathantorres.spacecommand.ui.Score;

	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	/**
	 * @author Jonathan Torres
	 */
	public class Level extends Sprite
	{
		private var _score : Score;
		private var _lifebar : Lifebar;
		private var _levelNumber : LevelNumber;
		private var _playerShip : PlayerShip;
		private var _playerShipRect : Rectangle;
		private var _parent : Sprite;
		
		private var _shipIsProtected : Boolean;
		private var _allAsteroidsDeployed : Boolean;
		private var _allEnemyShipsDeployed : Boolean;
		
		private var _enemyShips : Array;
		private var _typesOfEnemies : Array;
		private var _colorsOfEnemies : Array;
		private var _asteroids : Array;
		private var _typesOfAsteroids : Array;
		private var _lifeforces : Array;
		private var _healthbars : Array;
		private var _lasers : Array;
		
		private var _enemyDeployment : Timer;
		private var _healthbarsDeployment : Timer;
		private var _asteroidDeployment : Timer;
		private var _lifeforceDeployment : Timer;
		
		protected var gameScore : int;
		protected var gameLevel : int;
		protected var bg : GameBackground;
		protected var nextLevel : Level;
		
		public function Level()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init() : void
		{
			_shipIsProtected = false;
			_allAsteroidsDeployed = false;
			_allEnemyShipsDeployed = false;
			
			_parent = Sprite(parent);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		protected function initLifeforces() : void
		{
			_lifeforces = new Array();
			_lifeforceDeployment = new Timer(12000, 5);
			_lifeforceDeployment.addEventListener(TimerEvent.TIMER, onLifeforceDeploymentTimer);
			_lifeforceDeployment.start();
		}

		protected function initAsteroids() : void
		{
			_asteroids = new Array();
			_typesOfAsteroids = new Array(AsteroidSizes.SMALL, AsteroidSizes.MEDIUM, AsteroidSizes.LARGE);
			_asteroidDeployment = new Timer(4000, 20);
			_asteroidDeployment.addEventListener(TimerEvent.TIMER, onAsteroidDeploymentTimer);
			_asteroidDeployment.addEventListener(TimerEvent.TIMER_COMPLETE, onAsteroidDeploymentTimerComplete);
			_asteroidDeployment.start();
		}

		protected function initHealthbars() : void
		{
			_healthbars = new Array();
			_healthbarsDeployment = new Timer(10000, 10);
			_healthbarsDeployment.addEventListener(TimerEvent.TIMER, onHealthbarDeploymentTimer);
			_healthbarsDeployment.start();
		}

		protected function initEnemies() : void
		{
			_typesOfEnemies = new Array(EnemyTypes.ENEMY_TYPE1);
			_colorsOfEnemies = new Array(EnemyShipColors.BLUE, EnemyShipColors.GRAY, EnemyShipColors.GREEN, EnemyShipColors.RED);
			_enemyShips = new Array();
			_enemyDeployment = new Timer(2000, 50);
			_enemyDeployment.addEventListener(TimerEvent.TIMER, onEnemyDeploymentTimer);
			_enemyDeployment.addEventListener(TimerEvent.TIMER_COMPLETE, onEnemyDeploymentTimerComplete);
			_enemyDeployment.start();
		}

		protected function initLasers() : void
		{
			_lasers = new Array();
		}

		protected function addUI() : void
		{
			addChild(bg);

			_playerShip = new PlayerShip();
			addChild(_playerShip);

			_score = new Score(gameScore);
			_score.y = stage.stageHeight - 42;
			addChild(_score);

			_lifebar = new Lifebar();
			_lifebar.x = (stage.stageWidth * 0.5) - 145;
			_lifebar.y = stage.stageHeight - 42;
			addChild(_lifebar);

			_levelNumber = new LevelNumber(gameLevel);
			_levelNumber.x = stage.stageWidth - 120;
			_levelNumber.y = stage.stageHeight - 42;
			addChild(_levelNumber);
		}
		
		protected function onEnterFrame(event : Event) : void
		{
			_playerShipRect = _playerShip.ship.getBounds(this.parent);
			_playerShip.moveShip();
			bg.animate();
			
			checkEnemies();
			checkPlayerLife();
			
			/*
			 * Animation and Collisions : Lasers
			 */
			for (var i : int = _lasers.length - 1; i >= 0; i--) {
				var laser : Laser = Laser(_lasers[i]);
				var laserRect : Rectangle = laser.getBounds(this.parent);
				
				// player lasers
				if (laser.color == LaserColors.PLAYER) {
					laser.animate('right');
					
					// player laser is off the stage
					if (stage != null) {
						if (laser.x >= stage.stageWidth) {
							removeChild(laser);
							_lasers.splice(i, 1);
							continue;
						}
					}
					
					// player laser hits an enemy
					for (var j : int = _enemyShips.length - 1; j >= 0; j--) {
						var enemyShip : EnemyShip = EnemyShip(_enemyShips[j]);
	
						if (this.contains(enemyShip)) {
							var enemyShipRect : Rectangle = enemyShip.getBounds(this.parent);
	
							if (laserRect.intersects(enemyShipRect)) {
								// sum score
								gameScore += enemyShip.scoreValue;
								_score.updateScore(gameScore);
	
								removeChild(laser);
								_lasers.splice(i, 1);
	
								removeChild(enemyShip);
								_enemyShips.splice(j, 1);
								continue;
							}
						}
					}
					
					// player laser hits an asteroid
					for (var k : int = _asteroids.length - 1; k >= 0; k--) {
						var asteroid : Asteroid = Asteroid(_asteroids[k]);
	
						if (this.contains(asteroid)) {
							var asteroidRect : Rectangle = asteroid.getBounds(this.parent);
	
							if (laserRect.intersects(asteroidRect)) {
								// sum score
								gameScore += asteroid.scoreValue;
								_score.updateScore(gameScore);
	
								removeChild(asteroid);
								_asteroids.splice(k, 1);
	
								removeChild(laser);
								_lasers.splice(i, 1);
								continue;
							}
						}
					}
				} 
				
				// enemy lasers
				else {
					laser.animate('left');
					
					// enemy laser is off the stage
					if (laser.x <= 0) {
						removeChild(laser);
						_lasers.splice(i, 1);
						continue;
					}
					
					// enemy laser hits the player
					if (this.contains(laser)) {
						if (_playerShipRect.intersects(laserRect)) {
							// decrease player life
							//TODO Add lifeforce functionallity
							 _lifebar.decreaseLife(laser.damage);
							//if (!_shipIsProtected) _life.decreaseLife(enemy.damage);
							//removeProtectingLifeforce();

							removeChild(laser);
							_lasers.splice(i, 1);
							continue;
						}
					}
				}
			}
			
			/*
			 * Animation and Collisions : Enemy Ships
			 */
			for (var l : int = _enemyShips.length - 1; l >= 0; l--) {
				var enemy : EnemyShip = EnemyShip(_enemyShips[l]);
				enemy.animate();
				
				// enemy ship is off the stage
				if (enemy.x + enemy.width <= 0) {
					removeChild(enemy);
					_enemyShips.splice(l, 1);
					continue;
				}
				
				// enemy ship hits the player ship
				if (this.contains(enemy)) {
					var enemyRect : Rectangle = enemy.getBounds(this.parent);

					if (_playerShipRect.intersects(enemyRect)) {
						// decrease player life
						//TODO Add lifeforce functionallity
						_lifebar.decreaseLife(enemy.damage);
						//if (!_shipIsProtected) _life.decreaseLife(enemy.damage);
						//removeProtectingLifeforce();

						removeChild(enemy);
						_enemyShips.splice(l, 1);
						continue;
					} 
				}
			}
			
			/*
			* Animation and Collisions : Asteroids
			*/
			for (var m : int = _asteroids.length - 1; m >= 0; m--) {
				var theAsteroid : Asteroid = Asteroid(_asteroids[m]);
				theAsteroid.animate();
				
				// asteroid is off the stage
				if (theAsteroid.x + theAsteroid.width <= 0) {
					removeChild(theAsteroid);
					_asteroids.splice(m, 1);
					continue;
				}
				
				// asteroid hits the player
				if (this.contains(theAsteroid)) {
					var theAsteroidRect : Rectangle = theAsteroid.getBounds(this.parent);

					if (_playerShipRect.intersects(theAsteroidRect)) {
						// decrease player life
						//TODO Add lifeforce functionallity
						_lifebar.decreaseLife(theAsteroid.damage);
						//if (!_shipIsProtected) _life.decreaseLife(theAsteroid.damage);
						//removeProtectingLifeforce();

						removeChild(theAsteroid);
						_asteroids.splice(m, 1);
						continue;
					}
				}
			}
			
			/*
			* Animation and Collisions : Healthbars
			*/
			for (var n : int = _healthbars.length - 1; n >= 0; n--) {
				var healthbar : Health = Health(_healthbars[n]);
				healthbar.animate();
				
				// healthbar is off the stage
				if (healthbar.x + healthbar.width <= 0) {
					removeChild(healthbar);
					_healthbars.splice(n, 1);
					continue;
				}
				
				// healthbar hits the player
				if (this.contains(healthbar)) {
					var healthbarRect : Rectangle = healthbar.getBounds(this.parent);

					if (_playerShipRect.intersects(healthbarRect)) {
						// increase player life
						_lifebar.increaseLife(healthbar.lifeIncrease);

						removeChild(healthbar);
						_healthbars.splice(n, 1);
						continue;
					}
				}
			}
			
			/*
			* Animation and Collisions : Lifeforces
			*/
			for (var o : int = _lifeforces.length - 1; o >= 0; o--) {
				var lifeforce : Lifeforce = Lifeforce(_lifeforces[o]);
				lifeforce.animate();
				
				// lifeforce is off the stage
				if (lifeforce.x + lifeforce.width <= 0) {
					removeChild(lifeforce);
					_lifeforces.splice(o, 1);
					continue;
				}
				
				// lifeforce hits the player
				if (this.contains(lifeforce)) {
					var lifeforceRect : Rectangle = lifeforce.getBounds(this.parent);

					if (_playerShipRect.intersects(lifeforceRect)) {
						//TODO lifeforce functionallity
						//addProtectingLifeforce();

						removeChild(lifeforce);
						_lifeforces.splice(o, 1);
						continue;
					}
				}
			}
		}
		
		/*
		 * Check if all asteroids and enemies have been eliminated 
		 */
		private function checkEnemies() : void
		{
			if (_allAsteroidsDeployed && _allEnemyShipsDeployed) {
				if (_asteroids.length == 0 && _enemyShips.length == 0) {
					cleanUp();
					advanceLevel(nextLevel);
				}
			}
		}
		
		/*
		* Check when player life reaches zero. End the game. 
		*/
		private function checkPlayerLife() : void
		{
			if (_lifebar != null) {
				var totalLife : Number = _lifebar.totalLife;

				if (totalLife <= 0) {
					cleanUp();
					gameOver();
				}
			}
		}
		
		/*
		 * Advance to the next level
		 */
		private function advanceLevel(level : Level) : void
		{
			_parent.removeChild(this);
			trace('Advanced level!');
			level.gameScore = gameScore;
			_parent.addChild(level);
		}
		
		/*
		 * Ends the game
		 */
		private function gameOver() : void
		{
			_parent.removeChild(this);
			trace('game over!');
			_parent.addChild(new GameOver());
		}
		
		/*
		 * Cleans up the game.
		 * Removes ENTER_FRAME event.
		 * Removes any remaining: lasers, enemyShips, asteroids, healthbars, lifeforces and the player ship
		 * Cleans ups Timers
		 */
		private function cleanUp() : void
		{
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			// remove any lasers in the screen
			if (_lasers.length != 0) {
				for (var i : int = 0; i < _lasers.length; i++) {
					var laser : Laser = Laser(_lasers[i]);
					if (laser != null) {
						removeChild(laser);
						_lasers.splice(i, 1);
					}
				}
			}
			
			// remove any enemy ships
			if (_enemyShips.length != 0) {
				for (var j : int = 0; j < _enemyShips.length; j++) {
					var enemyShip : EnemyShip = EnemyShip(_enemyShips[j]);
					if (enemyShip != null) {
						removeChild(enemyShip);
						_enemyShips.splice(j, 1);
					}
				}
			}
			
			// remove any asteroids
			if (_asteroids.length != 0) {
				for (var l : int = 0; l < _asteroids.length; l++) {
					if (_asteroids[l] != null) {
						removeChild(_asteroids[l]);
						_asteroids.splice(l, 1);
					}
				}
			}
			
			// remove any healthbars
			if (_healthbars.length != 0) {
				for (var m : int = 0; m < _healthbars.length; m++) {
					if (_healthbars[m] != null) {
						removeChild(_healthbars[m]);
						_healthbars.splice(m, 1);
					}
				}
			}
			
			// remove any lifeforces
			if (_lifeforces.length != 0) {
				for (var n : int = 0; n < _lifeforces.length; n++) {
					if (_lifeforces[n] != null) {
						removeChild(_lifeforces[n]);
						_lifeforces.splice(n, 1);
					}
				}
			}
			
			// remove player ship
			_playerShip.removeListeners();
			removeChild(_playerShip);

			_enemyDeployment.stop();
			_enemyDeployment.removeEventListener(TimerEvent.TIMER, onEnemyDeploymentTimer);
			_enemyDeployment.removeEventListener(TimerEvent.TIMER_COMPLETE, onEnemyDeploymentTimerComplete);

			_asteroidDeployment.stop();
			_asteroidDeployment.removeEventListener(TimerEvent.TIMER, onAsteroidDeploymentTimer);
			_asteroidDeployment.removeEventListener(TimerEvent.TIMER_COMPLETE, onAsteroidDeploymentTimerComplete);

			_healthbarsDeployment.stop();
			_healthbarsDeployment.removeEventListener(TimerEvent.TIMER, onHealthbarDeploymentTimer);

			_lifeforceDeployment.stop();
			_lifeforceDeployment.removeEventListener(TimerEvent.TIMER, onLifeforceDeploymentTimer);
			
			// remove the UI elements
			removeChild(_lifebar);
			removeChild(_score);
			removeChild(_levelNumber);
			
			_lifebar = null;
			_score = null;
			_levelNumber = null;
			_playerShip = null;
		}

		/*
		 * Deploy a lifeforce
		 */
		private function onLifeforceDeploymentTimer(event : TimerEvent) : void
		{
			var lifeforce : Lifeforce = new Lifeforce();
			lifeforce.x = stage.stageWidth + (lifeforce.width) + 20;
			lifeforce.y = Math.random() * stage.stageHeight;
			addChild(lifeforce);

			_lifeforces.push(lifeforce);
		}
		
		/*
		 * Deploy an asteroid
		 */
		private function onAsteroidDeploymentTimer(event : TimerEvent) : void
		{
			var asteroid : Asteroid = new Asteroid(_typesOfAsteroids[Math.floor(Math.random() * _typesOfAsteroids.length)]);
			asteroid.x = stage.stageWidth + (asteroid.width) + 50;
			asteroid.y = Math.random() * stage.stageHeight;
			addChild(asteroid);

			_asteroids.push(asteroid);
		}
		
		private function onAsteroidDeploymentTimerComplete(event : TimerEvent) : void
		{
			_allAsteroidsDeployed = true;
		}
		
		/*
		 * Deploy a healthbar
		 */
		private function onHealthbarDeploymentTimer(event : TimerEvent) : void
		{
			var healthbar : Health = new Health();
			healthbar.x = stage.stageWidth + healthbar.width;
			healthbar.y = Math.random() * stage.stageHeight;
			addChild(healthbar);

			_healthbars.push(healthbar);
		}
		
		/*
		 * Deploy an enemy
		 */
		private function onEnemyDeploymentTimer(event : TimerEvent) : void
		{
			var enemyShip : EnemyShip = new EnemyShip(_typesOfEnemies[0], _colorsOfEnemies[Math.floor(Math.random() * _colorsOfEnemies.length)]);
			enemyShip.x = stage.stageWidth + enemyShip.width;
			enemyShip.y = Math.random() * stage.stageHeight;
			addChild(enemyShip);

			_enemyShips.push(enemyShip);
		}
		
		private function onEnemyDeploymentTimerComplete(event : TimerEvent) : void
		{
			_allEnemyShipsDeployed = true;
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
		
		/*
		 * Getters and setters 
		 */
		public function get lasers() : Array
		{
			return _lasers;
		}

		public function set lasers(lasers : Array) : void
		{
			_lasers = lasers;
		}
	}
}
