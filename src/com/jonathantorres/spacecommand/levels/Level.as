package com.jonathantorres.spacecommand.levels
{
	import flash.media.Sound;
	import com.jonathantorres.spacecommand.utils.SoundManager;
	import com.jonathantorres.spacecommand.Assets;
	import com.jonathantorres.spacecommand.pools.SpritePool;
	import starling.display.Sprite;
	import starling.events.Event;

	import com.jonathantorres.spacecommand.consts.AsteroidSizes;
	import com.jonathantorres.spacecommand.consts.LaserColors;
	import com.jonathantorres.spacecommand.consts.PlayerShipStates;
	import com.jonathantorres.spacecommand.menu.GameOver;
	import com.jonathantorres.spacecommand.objects.Asteroid;
	import com.jonathantorres.spacecommand.objects.EnemyShip;
	import com.jonathantorres.spacecommand.objects.Explotion;
	import com.jonathantorres.spacecommand.objects.Laser;
	import com.jonathantorres.spacecommand.objects.LifeforceLarge;
	import com.jonathantorres.spacecommand.objects.Missile;
	import com.jonathantorres.spacecommand.objects.PlayerShip;
	import com.jonathantorres.spacecommand.objects.icons.DoubleMissile;
	import com.jonathantorres.spacecommand.objects.icons.DoublePoints;
	import com.jonathantorres.spacecommand.objects.icons.Health;
	import com.jonathantorres.spacecommand.objects.icons.LessDamage;
	import com.jonathantorres.spacecommand.objects.icons.Lifeforce;
	import com.jonathantorres.spacecommand.objects.icons.TripleLasers;
	import com.jonathantorres.spacecommand.objects.icons.TriplePoints;
	import com.jonathantorres.spacecommand.ui.LevelNumber;
	import com.jonathantorres.spacecommand.ui.Lifebar;
	import com.jonathantorres.spacecommand.ui.Score;
	import com.jonathantorres.spacecommand.ui.TextBurst;
	import com.jonathantorres.spacecommand.ui.bg.GameBackground;

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
		private var _protectingLifeforce : LifeforceLarge;
		private var _parent : Sprite;
		
		private var _shipIsProtected : Boolean;
		private var _allAsteroidsDeployed : Boolean;
		private var _allEnemyShipsDeployed : Boolean;
		
		private var _lessDamageEnabled : Boolean;
		private var _lessDamageHits : uint;
		private var _lessDamageLimitHits : uint;
		
		private var _doublePointsEnabled : Boolean;
		private var _triplePointsEnabled : Boolean;
		
		private var _enemyShips : Array;
		private var _asteroids : Array;
		private var _typesOfAsteroids : Array;
		private var _lifeforces : Array;
		private var _healthbars : Array;
		private var _lessDamageIcons : Array;
		private var _tripleLaserIcons : Array;
		private var _doubleMissileIcons : Array;
		private var _doublePointsIcons : Array;
		private var _triplePointsIcons : Array;
		private var _lasers : Array;
		private var _missiles : Array;
		
		private var _enemyDeployment : Timer;
		private var _healthbarsDeployment : Timer;
		private var _asteroidDeployment : Timer;
		private var _lifeforceDeployment : Timer;
		private var _lessDamageIconDeployment : Timer;
		private var _tripleLaserIconDeployment : Timer;
		private var _doubleMissileIconDeployment : Timer;
		private var _doublePointIconDeployment : Timer;
		private var _triplePointIconDeployment : Timer;
		
		private var _lifeforcesPool : SpritePool;
		private var _healthbarsPool : SpritePool;
		private var _lessDamageIconsPool : SpritePool;
		private var _tripleLaserIconsPool : SpritePool;
		private var _doubleMissileIconsPool : SpritePool;
		private var _doublePointsIconsPool : SpritePool;
		private var _triplePointsIconsPool : SpritePool;
		private var _lasersPool : SpritePool;
		private var _missilesPool : SpritePool;
		private var _enemiesPool : SpritePool;
		private var _asteroidsPool : SpritePool;
		private var _explotionsPool : SpritePool;
		private var _textBurstsPool : SpritePool;
		
		protected var gameScore : int;
		protected var gameLevel : int;
		protected var bg : GameBackground;
		protected var nextLevel : Level;
		
		protected var lifeforceDeploymentInterval : Number;
		protected var numOfLifeforces : Number;
		
		protected var asteroidDeploymentInterval : Number;
		protected var numOfAsteroids : Number;
		protected var asteroidsSpeed : Number;
		
		protected var healthbarsDeploymentInterval : Number;
		protected var numOfHealthbars : Number;
		
		protected var lessDamageIconDeploymentInterval : Number;
		protected var numOfLessDamageIcons : Number;
		
		protected var tripleLaserIconDeploymentInterval : Number;
		protected var numOfTripleLaserIcons : Number;
		
		protected var doubleMissileIconDeploymentInterval : Number;
		protected var numOfDoubleMissileIcons : Number;
		
		protected var doublePointIconDeploymentInterval : Number;
		protected var numOfDoublePointIcons : Number;
		
		protected var triplePointIconDeploymentInterval : Number;
		protected var numOfTriplePointIcons : Number;
		
		protected var enemiesDeploymentInterval : Number;
		protected var numOfEnemies : Number;
		protected var enemyShootingInterval : Number;
		protected var enemiesSpeed : Number;
		
		protected var typesOfEnemies : Array;
		protected var colorsOfEnemies : Array;
		
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
			_lessDamageEnabled = false;
			_lessDamageHits = 0;
			_lessDamageLimitHits = 3;
			_doublePointsEnabled = false;
			_triplePointsEnabled = false;
			
			_parent = Sprite(parent);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function initPools() : void
		{
			_lifeforcesPool = new SpritePool(Lifeforce, Math.floor(numOfLifeforces / 2));
			_healthbarsPool = new SpritePool(Health, Math.floor(numOfHealthbars / 2));
			_lessDamageIconsPool = new SpritePool(LessDamage, Math.floor(numOfLessDamageIcons / 2));
			_tripleLaserIconsPool = new SpritePool(TripleLasers, Math.floor(numOfTripleLaserIcons / 2));
			_doubleMissileIconsPool = new SpritePool(DoubleMissile, Math.floor(numOfDoubleMissileIcons / 2));
			_doublePointsIconsPool = new SpritePool(DoublePoints, Math.floor(numOfDoublePointIcons / 2));
			_triplePointsIconsPool = new SpritePool(TriplePoints, Math.floor(numOfTriplePointIcons / 2));
			
			_lasersPool = new SpritePool(Laser, 50);
			_missilesPool = new SpritePool(Missile, 20);
			_enemiesPool = new SpritePool(EnemyShip, Math.floor(numOfEnemies / 2));
			_asteroidsPool = new SpritePool(Asteroid, Math.floor(numOfAsteroids / 2));
			
			_explotionsPool = new SpritePool(Explotion, 20);
			_textBurstsPool = new SpritePool(TextBurst, 20);
		}

		protected function initLifeforces() : void
		{
			_lifeforces = new Array();
			_lifeforceDeployment = new Timer(lifeforceDeploymentInterval, numOfLifeforces);
			_lifeforceDeployment.addEventListener(TimerEvent.TIMER, onLifeforceDeploymentTimer);
			_lifeforceDeployment.start();
		}

		protected function initAsteroids() : void
		{
			_asteroids = new Array();
			_typesOfAsteroids = new Array(AsteroidSizes.SMALL, AsteroidSizes.MEDIUM, AsteroidSizes.LARGE);
			_asteroidDeployment = new Timer(asteroidDeploymentInterval, numOfAsteroids);
			_asteroidDeployment.addEventListener(TimerEvent.TIMER, onAsteroidDeploymentTimer);
			_asteroidDeployment.addEventListener(TimerEvent.TIMER_COMPLETE, onAsteroidDeploymentTimerComplete);
			_asteroidDeployment.start();
		}

		protected function initHealthbars() : void
		{
			_healthbars = new Array();
			_healthbarsDeployment = new Timer(healthbarsDeploymentInterval, numOfHealthbars);
			_healthbarsDeployment.addEventListener(TimerEvent.TIMER, onHealthbarDeploymentTimer);
			_healthbarsDeployment.start();
		}
		
		protected function initLessDamageIcons() : void
		{
			_lessDamageIcons = new Array();
			_lessDamageIconDeployment = new Timer(lessDamageIconDeploymentInterval, numOfLessDamageIcons);
			_lessDamageIconDeployment.addEventListener(TimerEvent.TIMER, onLessDamageIconDeploymentTimer);
			_lessDamageIconDeployment.start();
		}

		protected function initTripleLaserIcons() : void
		{
			_tripleLaserIcons = new Array();
			_tripleLaserIconDeployment = new Timer(tripleLaserIconDeploymentInterval, numOfTripleLaserIcons);
			_tripleLaserIconDeployment.addEventListener(TimerEvent.TIMER, onTripleLaserIconDeploymentTimer);
			_tripleLaserIconDeployment.start();
		}
		
		protected function initDoubleMissileIcons() : void
		{
			_doubleMissileIcons = new Array();
			_doubleMissileIconDeployment = new Timer(doubleMissileIconDeploymentInterval, numOfDoubleMissileIcons);
			_doubleMissileIconDeployment.addEventListener(TimerEvent.TIMER, onDoubleMissileIconDeploymentTimer);
			_doubleMissileIconDeployment.start();
		}
		
		protected function initDoublePointIcons() : void
		{
			_doublePointsIcons = new Array();
			_doublePointIconDeployment = new Timer(doublePointIconDeploymentInterval, numOfDoublePointIcons);
			_doublePointIconDeployment.addEventListener(TimerEvent.TIMER, onDoublePointIconDeploymentTimer);
			_doublePointIconDeployment.start();
		}
		
		protected function initTriplePointIcons() : void
		{
			_triplePointsIcons = new Array();
			_triplePointIconDeployment = new Timer(triplePointIconDeploymentInterval, numOfTriplePointIcons);
			_triplePointIconDeployment.addEventListener(TimerEvent.TIMER, onTriplePointIconDeploymentTimer);
			_triplePointIconDeployment.start();
		}

		protected function initEnemies() : void
		{
			_enemyShips = new Array();
			_enemyDeployment = new Timer(enemiesDeploymentInterval, numOfEnemies);
			_enemyDeployment.addEventListener(TimerEvent.TIMER, onEnemyDeploymentTimer);
			_enemyDeployment.addEventListener(TimerEvent.TIMER_COMPLETE, onEnemyDeploymentTimerComplete);
			_enemyDeployment.start();
		}

		protected function initLasers() : void
		{
			_lasers = new Array();
		}
		
		protected function initMissiles() : void
		{
			_missiles = new Array();
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
			updateLifeforcePosition();
			
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
							_lasersPool.returnSprite(laser);
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
								sumScore(enemyShip.scoreValue);
								_score.updateScore(gameScore);
								
								var shipExplotion : Explotion = Explotion(_explotionsPool.getSprite());
								addChild(shipExplotion);
								shipExplotion.explode(enemyShip.x, enemyShip.y);
								
								var shipBurst : TextBurst = TextBurst(_textBurstsPool.getSprite());
								addChild(shipBurst);
								shipBurst.show(enemyShip.scoreValue + 'pts', enemyShip.x, enemyShip.y);
	
								removeChild(laser);
								_lasersPool.returnSprite(laser);
								_lasers.splice(i, 1);
	
								removeChild(enemyShip);
								_enemiesPool.returnSprite(enemyShip);
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
								sumScore(asteroid.scoreValue);
								_score.updateScore(gameScore);
								
								var asteroidExplotion : Explotion = Explotion(_explotionsPool.getSprite());
								addChild(asteroidExplotion);
								asteroidExplotion.explode(asteroid.x, asteroid.y);
								
								var asteroidBurst : TextBurst = TextBurst(_textBurstsPool.getSprite());
								addChild(asteroidBurst);
								asteroidBurst.show(asteroid.scoreValue + 'pts', asteroid.x, asteroid.y);
	
								removeChild(asteroid);
								_asteroidsPool.returnSprite(asteroid);
								_asteroids.splice(k, 1);
	
								removeChild(laser);
								_lasersPool.returnSprite(laser);
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
						_lasersPool.returnSprite(laser);
						_lasers.splice(i, 1);
						continue;
					}
					
					// enemy laser hits the player
					if (this.contains(laser)) {
						if (_playerShipRect.intersects(laserRect)) {
							// decrease player life
							if (!_shipIsProtected) enableLessDamage(laser.damage);
							
							removeProtectingLifeforce();

							removeChild(laser);
							_lasersPool.returnSprite(laser);
							_lasers.splice(i, 1);
							continue;
						}
					}
				}
			}
			
			/*
			 * Animation and Collisions : Missiles
			 */
			 for (var u : int = _missiles.length - 1; u >= 0; u--) {
				var missile : Missile = Missile(_missiles[u]);
				var missileRect : Rectangle = missile.getBounds(this.parent);
				
				missile.animate();
				
				// missile is off the stage
				if (stage != null) {
					if (missile.x >= stage.stageWidth) {
						removeChild(missile);
						_missilesPool.returnSprite(missile);
						_missiles.splice(u, 1);
						continue;
					}
				}
				
				// missile hits an enemy
				for (var v : int = _enemyShips.length - 1; v >= 0; v--) {
					var theEnemyShip : EnemyShip = EnemyShip(_enemyShips[v]);

					if (this.contains(theEnemyShip)) {
						var theEnemyShipRect : Rectangle = theEnemyShip.getBounds(this.parent);

						if (missileRect.intersects(theEnemyShipRect)) {
							// sum score
							sumScore(theEnemyShip.scoreValue);
							_score.updateScore(gameScore);
							
							var enemyExplotion : Explotion = Explotion(_explotionsPool.getSprite());
							addChild(enemyExplotion);
							enemyExplotion.explode(theEnemyShip.x, theEnemyShip.y);
							
							var enemyBurst : TextBurst = TextBurst(_textBurstsPool.getSprite());
							addChild(enemyBurst);
							enemyBurst.show(theEnemyShip.scoreValue + 'pts', theEnemyShip.x, theEnemyShip.y);

							removeChild(missile);
							_missilesPool.returnSprite(missile);
							_missiles.splice(u, 1);

							removeChild(theEnemyShip);
							_enemiesPool.returnSprite(theEnemyShip);
							_enemyShips.splice(v, 1);
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
					_enemiesPool.returnSprite(enemy);
					_enemyShips.splice(l, 1);
					continue;
				}
				
				// enemy ship hits the player ship
				if (this.contains(enemy)) {
					var enemyRect : Rectangle = enemy.getBounds(this.parent);

					if (_playerShipRect.intersects(enemyRect)) {
						// decrease player life
						if (!_shipIsProtected) enableLessDamage(enemy.damage);
						
						var enemyShipExplotion : Explotion = Explotion(_explotionsPool.getSprite());
						addChild(enemyShipExplotion);
						enemyShipExplotion.explode(enemy.x, enemy.y);
						removeProtectingLifeforce();

						removeChild(enemy);
						_enemiesPool.returnSprite(enemy);
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
					_asteroidsPool.returnSprite(theAsteroid);
					_asteroids.splice(m, 1);
					continue;
				}
				
				// asteroid hits the player
				if (this.contains(theAsteroid)) {
					var theAsteroidRect : Rectangle = theAsteroid.getBounds(this.parent);

					if (_playerShipRect.intersects(theAsteroidRect)) {
						// decrease player life
						if (!_shipIsProtected) enableLessDamage(theAsteroid.damage);
						
						var asteExplotion : Explotion = Explotion(_explotionsPool.getSprite());
						addChild(asteExplotion);
						asteExplotion.explode(theAsteroid.x, theAsteroid.y);
						removeProtectingLifeforce();

						removeChild(theAsteroid);
						_asteroidsPool.returnSprite(theAsteroid);
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
					_healthbarsPool.returnSprite(healthbar);
					_healthbars.splice(n, 1);
					continue;
				}
				
				// healthbar hits the player
				if (this.contains(healthbar)) {
					var healthbarRect : Rectangle = healthbar.getBounds(this.parent);

					if (_playerShipRect.intersects(healthbarRect)) {
						// increase player life
						_lifebar.increaseLife(healthbar.lifeIncrease);
						
						lifeupSound();
						
						var healthBurst : TextBurst = TextBurst(_textBurstsPool.getSprite());
						addChild(healthBurst);
						healthBurst.show('Health Increase!', _playerShip.x, _playerShip.y);

						removeChild(healthbar);
						_healthbarsPool.returnSprite(healthbar);
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
					_lifeforcesPool.returnSprite(lifeforce);
					_lifeforces.splice(o, 1);
					continue;
				}
				
				// lifeforce hits the player
				if (this.contains(lifeforce)) {
					var lifeforceRect : Rectangle = lifeforce.getBounds(this.parent);

					if (_playerShipRect.intersects(lifeforceRect)) {
						addProtectingLifeforce();
						
						lifeupSound();
						
						var lifeBurst : TextBurst = TextBurst(_textBurstsPool.getSprite());
						addChild(lifeBurst);
						lifeBurst.show('Lifeforce!', _playerShip.x, _playerShip.y);
						
						removeChild(lifeforce);
						_lifeforcesPool.returnSprite(lifeforce);
						_lifeforces.splice(o, 1);
						continue;
					}
				}
			}
			
			/*
			* Animation and Collisions : Less Damage Icons
			*/
			for (var p : int = _lessDamageIcons.length - 1; p >= 0; p--) {
				var lessDamage : LessDamage = LessDamage(_lessDamageIcons[p]);
				lessDamage.animate();
				
				// icon is off the stage
				if (lessDamage.x + lessDamage.width <= 0) {
					removeChild(lessDamage);
					_lessDamageIconsPool.returnSprite(lessDamage);
					_lessDamageIcons.splice(p, 1);
					continue;
				}
				
				// icon hits the player
				if (this.contains(lessDamage)) {
					var lessDamageRect : Rectangle = lessDamage.getBounds(this.parent);

					if (_playerShipRect.intersects(lessDamageRect)) {
						powerupSound();
						
						var damageBurst : TextBurst = TextBurst(_textBurstsPool.getSprite());
						addChild(damageBurst);
						damageBurst.show('Less Damage!', _playerShip.x, _playerShip.y);
						
						if (!_lessDamageEnabled) _lessDamageEnabled = true;
						removeChild(lessDamage);
						_lessDamageIconsPool.returnSprite(lessDamage);
						_lessDamageIcons.splice(p, 1);
						continue;
					}
				}
			}
			
			/*
			* Animation and Collisions : Triple Laser Icons
			*/
			for (var q : int = _tripleLaserIcons.length - 1; q >= 0; q--) {
				var tripleLaser : TripleLasers = TripleLasers(_tripleLaserIcons[q]);
				tripleLaser.animate();
				
				// icon is off the stage
				if (tripleLaser.x + tripleLaser.width <= 0) {
					removeChild(tripleLaser);
					_tripleLaserIconsPool.returnSprite(tripleLaser);
					_tripleLaserIcons.splice(q, 1);
					continue;
				}
				
				// icon hits the player
				if (this.contains(tripleLaser)) {
					var tripleLaserRect : Rectangle = tripleLaser.getBounds(this.parent);

					if (_playerShipRect.intersects(tripleLaserRect)) {
						if (_playerShip.state != PlayerShipStates.TRIPLE_LASER) 
							_playerShip.morph(PlayerShipStates.TRIPLE_LASER);
						
						powerupSound();
						
						var tripleBurst : TextBurst = TextBurst(_textBurstsPool.getSprite());
						addChild(tripleBurst);
						tripleBurst.show('Triple Laser!', _playerShip.x, _playerShip.y);
						
						removeChild(tripleLaser);
						_tripleLaserIconsPool.returnSprite(tripleLaser);
						_tripleLaserIcons.splice(q, 1);
						continue;
					}
				}
			}
			
			/*
			* Animation and Collisions : Double Missile Icons
			*/
			for (var r : int = _doubleMissileIcons.length - 1; r >= 0; r--) {
				var doubleMissile : DoubleMissile = DoubleMissile(_doubleMissileIcons[r]);
				doubleMissile.animate();
				
				// icon is off the stage
				if (doubleMissile.x + doubleMissile.width <= 0) {
					removeChild(doubleMissile);
					_doubleMissileIconsPool.returnSprite(doubleMissile);
					_doubleMissileIcons.splice(r, 1);
					continue;
				}
				
				// icon hits the player
				if (this.contains(doubleMissile)) {
					var doubleMissileRect : Rectangle = doubleMissile.getBounds(this.parent);

					if (_playerShipRect.intersects(doubleMissileRect)) {
						if (_playerShip.state != PlayerShipStates.DOUBLE_MISSILE)
							_playerShip.morph(PlayerShipStates.DOUBLE_MISSILE);
						
						powerupSound();
						
						var doubleBurst : TextBurst = TextBurst(_textBurstsPool.getSprite());
						addChild(doubleBurst);
						doubleBurst.show('Double Missile!', _playerShip.x, _playerShip.y);
						
						removeChild(doubleMissile);
						_doubleMissileIconsPool.returnSprite(doubleMissile);
						_doubleMissileIcons.splice(r, 1);
						continue;
					}
				}
			}
			
			/*
			* Animation and Collisions : Double Points Icons
			*/
			for (var s : int = _doublePointsIcons.length - 1; s >= 0; s--) {
				var doublePoints : DoublePoints = DoublePoints(_doublePointsIcons[s]);
				doublePoints.animate();
				
				// icon is off the stage
				if (doublePoints.x + doublePoints.width <= 0) {
					removeChild(doublePoints);
					_doublePointsIconsPool.returnSprite(doublePoints);
					_doublePointsIcons.splice(s, 1);
					continue;
				}
				
				// icon hits the player
				if (this.contains(doublePoints)) {
					var doublePointsRect : Rectangle = doublePoints.getBounds(this.parent);

					if (_playerShipRect.intersects(doublePointsRect)) {
						pointsSound();
						
						var doublePointBurst : TextBurst = TextBurst(_textBurstsPool.getSprite());
						addChild(doublePointBurst);
						doublePointBurst.show('Double Points!', _playerShip.x, _playerShip.y);
						
						if (!_doublePointsEnabled) enableDoublePoints();
						removeChild(doublePoints);
						_doublePointsIconsPool.returnSprite(doublePoints);
						_doublePointsIcons.splice(s, 1);
						continue;
					}
				}
			}
			
			/*
			* Animation and Collisions : Triple Points Icons
			*/
			for (var t : int = _triplePointsIcons.length - 1; t >= 0; t--) {
				var triplePoints : TriplePoints = TriplePoints(_triplePointsIcons[t]);
				triplePoints.animate();
				
				// icon is off the stage
				if (triplePoints.x + triplePoints.width <= 0) {
					removeChild(triplePoints);
					_triplePointsIconsPool.returnSprite(triplePoints);
					_triplePointsIcons.splice(t, 1);
					continue;
				}
				
				// icon hits the player
				if (this.contains(triplePoints)) {
					var triplePointsRect : Rectangle = triplePoints.getBounds(this.parent);

					if (_playerShipRect.intersects(triplePointsRect)) {
						pointsSound();
						
						var triplePointBurst : TextBurst = TextBurst(_textBurstsPool.getSprite());
						addChild(triplePointBurst);
						triplePointBurst.show('Triple Points!', _playerShip.x, _playerShip.y);
						
						if (!_triplePointsEnabled) enableTriplePoints();
						removeChild(triplePoints);
						_triplePointsIconsPool.returnSprite(triplePoints);
						_triplePointsIcons.splice(t, 1);
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
			level.gameScore = gameScore;
			_parent.addChild(level);
		}
		
		/*
		 * Ends the game
		 */
		private function gameOver() : void
		{
			_parent.removeChild(this);
			_parent.addChild(new GameOver(gameScore));
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
						_lasersPool.returnSprite(laser);
						_lasers.splice(i, 1);
					}
				}
			}
			
			// remove any missiles in the screen
			if (_missiles.length != 0) {
				for (var t : int = 0; t < _missiles.length; t++) {
					var missile : Missile = Missile(_missiles[t]);
					if (missile != null) {
						removeChild(missile);
						_missilesPool.returnSprite(missile);
						_missiles.splice(t, 1);
					}
				}
			}
			
			// remove any enemy ships
			if (_enemyShips.length != 0) {
				for (var j : int = 0; j < _enemyShips.length; j++) {
					var enemyShip : EnemyShip = EnemyShip(_enemyShips[j]);
					if (enemyShip != null) {
						removeChild(enemyShip);
						_enemiesPool.returnSprite(enemyShip);
						_enemyShips.splice(j, 1);
					}
				}
			}
			
			// remove any asteroids
			if (_asteroids.length != 0) {
				for (var l : int = 0; l < _asteroids.length; l++) {
					if (_asteroids[l] != null) {
						removeChild(_asteroids[l]);
						_asteroidsPool.returnSprite(_asteroids[l]);
						_asteroids.splice(l, 1);
					}
				}
			}
			
			// remove any healthbars
			if (_healthbars.length != 0) {
				for (var m : int = 0; m < _healthbars.length; m++) {
					if (_healthbars[m] != null) {
						removeChild(_healthbars[m]);
						_healthbarsPool.returnSprite(_healthbars[m]);
						_healthbars.splice(m, 1);
					}
				}
			}
			
			// remove any lifeforces
			if (_lifeforces.length != 0) {
				for (var n : int = 0; n < _lifeforces.length; n++) {
					if (_lifeforces[n] != null) {
						removeChild(_lifeforces[n]);
						_lifeforcesPool.returnSprite(_lifeforces[n]);
						_lifeforces.splice(n, 1);
					}
				}
			}
			
			// remove any less damage icons
			if (_lessDamageIcons.length != 0) {
				for (var o : int = 0; o < _lessDamageIcons.length; o++) {
					if (_lessDamageIcons[o] != null) {
						removeChild(_lessDamageIcons[o]);
						_lessDamageIconsPool.returnSprite(_lessDamageIcons[0]);
						_lessDamageIcons.splice(o, 1);
					}
				}
			}
			
			// remove any triple laser icons
			if (_tripleLaserIcons.length != 0) {
				for (var p : int = 0; p < _tripleLaserIcons.length; p++) {
					if (_tripleLaserIcons[p] != null) {
						removeChild(_tripleLaserIcons[p]);
						_tripleLaserIconsPool.returnSprite(_tripleLaserIcons[p]);
						_tripleLaserIcons.splice(p, 1);
					}
				}
			}
			
			// remove any double missile icons
			if (_doubleMissileIcons.length != 0) {
				for (var q : int = 0; q < _doubleMissileIcons.length; q++) {
					if (_doubleMissileIcons[q] != null) {
						removeChild(_doubleMissileIcons[q]);
						_doubleMissileIconsPool.returnSprite(_doubleMissileIcons[q]);
						_doubleMissileIcons.splice(q, 1);
					}
				}
			}
			
			// remove any double points icons
			if (_doublePointsIcons.length != 0) {
				for (var r : int = 0; r < _doublePointsIcons.length; r++) {
					if (_doublePointsIcons[r] != null) {
						removeChild(_doublePointsIcons[r]);
						_doublePointsIconsPool.returnSprite(_doublePointsIcons[r]);
						_doublePointsIcons.splice(r, 1);
					}
				}
			}
			
			// remove any triple points icons
			if (_triplePointsIcons.length != 0) {
				for (var s : int = 0; s < _triplePointsIcons.length; s++) {
					if (_triplePointsIcons[s] != null) {
						removeChild(_triplePointsIcons[s]);
						_triplePointsIconsPool.returnSprite(_triplePointsIcons[s]);
						_triplePointsIcons.splice(s, 1);
					}
				}
			}
			
			// remove protecting lifeforce
			removeProtectingLifeforce();
			
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
			
			_lessDamageIconDeployment.stop();
			_lessDamageIconDeployment.removeEventListener(TimerEvent.TIMER, onLessDamageIconDeploymentTimer);
			
			_tripleLaserIconDeployment.stop();
			_tripleLaserIconDeployment.removeEventListener(TimerEvent.TIMER, onTripleLaserIconDeploymentTimer);
			
			_doubleMissileIconDeployment.stop();
			_doubleMissileIconDeployment.removeEventListener(TimerEvent.TIMER, onDoubleMissileIconDeploymentTimer);
			
			_doublePointIconDeployment.stop();
			_doublePointIconDeployment.removeEventListener(TimerEvent.TIMER, onDoublePointIconDeploymentTimer);
			
			_triplePointIconDeployment.stop();
			_triplePointIconDeployment.removeEventListener(TimerEvent.TIMER, onTriplePointIconDeploymentTimer);
			
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
		 * Sum score. Check if 2x or 3x points are enabled.
		 */
		private function sumScore(value : Number) : void
		{
			if (_doublePointsEnabled)
				gameScore += (value * 2);
			else if (_triplePointsEnabled)
				gameScore += (value * 3);
			else 
				gameScore += value;
		}
		
		/*
		 * Double Points. Current player points are doubled.
		 * Disable Triple Points if enabled
		 */
		private function enableDoublePoints() : void
		{
			if (_triplePointsEnabled) _triplePointsEnabled = false;
			_doublePointsEnabled = true;
		}
		
		/*
		 * Triple Points. Current player points are tripled.
		 * Disable Double Points if enabled
		 */
		private function enableTriplePoints() : void
		{
			if (_doublePointsEnabled) _doublePointsEnabled = false;
			_triplePointsEnabled = true;
		}
		
		/*
		 * Less Damage Logic.
		 * If player has "Less Damage" enabled. Damage is reduced by half.
		 */
		private function enableLessDamage(damage : Number) : void
		{
			if (!_playerShip.isBlinking) _playerShip.blink();
			
			if (!_lessDamageEnabled) {
				_lifebar.decreaseLife(damage);
			}
			else {
				_lifebar.decreaseLife((damage) / 2);
				_lessDamageHits++;
			
				if (_lessDamageHits == _lessDamageLimitHits) {
					_lessDamageHits = 0;
					_lessDamageEnabled = false;
				}
			}
		}
		
		/*
		 * Make sure that the lifeforce is always on top of the player ship
		 */
		private function updateLifeforcePosition() : void
		{
			if (_shipIsProtected && (_protectingLifeforce != null)) {
				_protectingLifeforce.x = _playerShip.x - (_playerShip.width * 0.5);
				_protectingLifeforce.y = _playerShip.y;
			}
		}
		
		/*
		 * Add lifeforce to the player ship
		 */
		private function addProtectingLifeforce() : void
		{
			if (!_shipIsProtected) {
				_protectingLifeforce = new LifeforceLarge();
				_protectingLifeforce.x = _playerShip.x - (_playerShip.width * 0.5);
				_protectingLifeforce.y = _playerShip.y;
				addChild(_protectingLifeforce);

				_shipIsProtected = true;
			}
		}
		
		/*
		 * If player ship is protected, remove it when hit.
		 */
		private function removeProtectingLifeforce() : void
		{
			if (_shipIsProtected && (_protectingLifeforce != null)) {
				removeChild(_protectingLifeforce);
				_protectingLifeforce = null;
				_shipIsProtected = false;
			}
		}

		/*
		 * Deploy a lifeforce
		 */
		private function onLifeforceDeploymentTimer(event : TimerEvent) : void
		{
			var lifeforce : Lifeforce = Lifeforce(_lifeforcesPool.getSprite());
			lifeforce.x = stage.stageWidth + (lifeforce.width) + 20;
			lifeforce.y = Math.random() * (360 - 50 + 1) + 50;
			addChild(lifeforce);

			_lifeforces.push(lifeforce);
		}
		
		/*
		 * Deploy an asteroid
		 */
		private function onAsteroidDeploymentTimer(event : TimerEvent) : void
		{
			var asteroid : Asteroid = Asteroid(_asteroidsPool.getSprite());
			asteroid.size = _typesOfAsteroids[Math.floor(Math.random() * _typesOfAsteroids.length)];
			asteroid.speed = asteroidsSpeed;
			asteroid.x = stage.stageWidth + (asteroid.width) + 50;
			asteroid.y = Math.random() * (360 - 50 + 1) + 50;
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
			var healthbar : Health = Health(_healthbarsPool.getSprite());
			healthbar.x = stage.stageWidth + healthbar.width;
			healthbar.y = Math.random() * (360 - 50 + 1) + 50;
			addChild(healthbar);

			_healthbars.push(healthbar);
		}
		
		/*
		 * Deploy a "Less Damage" Icon
		 */
		private function onLessDamageIconDeploymentTimer(event : TimerEvent) : void
		{
			var lessDamage : LessDamage = LessDamage(_lessDamageIconsPool.getSprite());
			lessDamage.x = stage.stageWidth + lessDamage.width;
			lessDamage.y = Math.random() * (360 - 50 + 1) + 50;
			addChild(lessDamage);
			
			_lessDamageIcons.push(lessDamage);
		}
		
		/*
		 * Deploy a "Triple Laser" Icon
		 */
		private function onTripleLaserIconDeploymentTimer(event : TimerEvent) : void
		{
			var tripleLaser : TripleLasers = TripleLasers(_tripleLaserIconsPool.getSprite());
			tripleLaser.x = stage.stageWidth + tripleLaser.width;
			tripleLaser.y = Math.random() * (360 - 50 + 1) + 50;
			addChild(tripleLaser);
			
			_tripleLaserIcons.push(tripleLaser);
		}
		
		/*
		 * Deploy a "Double Missile" Icon
		 */
		private function onDoubleMissileIconDeploymentTimer(event : TimerEvent) : void
		{
			var doubleMissile : DoubleMissile = DoubleMissile(_doubleMissileIconsPool.getSprite());
			doubleMissile.x = stage.stageWidth + doubleMissile.width;
			doubleMissile.y = Math.random() * (360 - 50 + 1) + 50;
			addChild(doubleMissile);
			
			_doubleMissileIcons.push(doubleMissile);
		}
		
		/*
		 * Deploy "Double Points" Icon
		 */
		private function onDoublePointIconDeploymentTimer(event : TimerEvent) : void
		{
			var doublePoints : DoublePoints = DoublePoints(_doublePointsIconsPool.getSprite());
			doublePoints.x = stage.stageWidth + doublePoints.width;
			doublePoints.y = Math.random() * (360 - 50 + 1) + 50;
			addChild(doublePoints);
			
			_doublePointsIcons.push(doublePoints);
		}
		
		/*
		 * Deploy "Triple Points" Icon
		 */
		private function onTriplePointIconDeploymentTimer(event : TimerEvent) : void
		{
			var triplePoints : TriplePoints = TriplePoints(_triplePointsIconsPool.getSprite());
			triplePoints.x = stage.stageWidth + triplePoints.width;
			triplePoints.y = Math.random() * (360 - 50 + 1) + 50;
			addChild(triplePoints);
			
			_triplePointsIcons.push(triplePoints);
		}

		/*
		 * Deploy an enemy
		 */
		private function onEnemyDeploymentTimer(event : TimerEvent) : void
		{
			var typeOfEnemy : String;
			
			if (typesOfEnemies.length == 1)
				typeOfEnemy = typesOfEnemies[0];
			else
				typeOfEnemy = typesOfEnemies[Math.floor(Math.random() * typesOfEnemies.length)];
			
			var enemyShip : EnemyShip = EnemyShip(_enemiesPool.getSprite());
			enemyShip.type = typeOfEnemy;
			enemyShip.color = colorsOfEnemies[Math.floor(Math.random() * colorsOfEnemies.length)];
			enemyShip.shootingInterval = enemyShootingInterval;
			enemyShip.speed = enemiesSpeed;
			enemyShip.x = stage.stageWidth + enemyShip.width;
			enemyShip.y = Math.random() * (360 - 50 + 1) + 50;
			enemyShip.initShooting();
			addChild(enemyShip);

			_enemyShips.push(enemyShip);
		}
		
		private function onEnemyDeploymentTimerComplete(event : TimerEvent) : void
		{
			_allEnemyShipsDeployed = true;
		}
		
		private function powerupSound() : void
		{
			var powerupSound : Sound = Assets.getSound('PowerupSound');
			if (SoundManager.sfxOn) powerupSound.play();
		}
		
		private function lifeupSound() : void
		{
			var lifeupSound : Sound = Assets.getSound('LifeupSound');
			if (SoundManager.sfxOn) lifeupSound.play();
		}
		
		private function pointsSound() : void
		{
			var pointsSound : Sound = Assets.getSound('PointsSound');
			if (SoundManager.sfxOn) pointsSound.play();
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

		public function get missiles() : Array
		{
			return _missiles;
		}

		public function set missiles(missiles : Array) : void
		{
			_missiles = missiles;
		}

		public function get lasersPool() : SpritePool
		{
			return _lasersPool;
		}

		public function set lasersPool(lasersPool : SpritePool) : void
		{
			_lasersPool = lasersPool;
		}

		public function get missilesPool() : SpritePool
		{
			return _missilesPool;
		}

		public function set missilesPool(missilesPool : SpritePool) : void
		{
			_missilesPool = missilesPool;
		}

		public function get explotionsPool() : SpritePool
		{
			return _explotionsPool;
		}

		public function set explotionsPool(explotionsPool : SpritePool) : void
		{
			_explotionsPool = explotionsPool;
		}

		public function get textBurstsPool() : SpritePool
		{
			return _textBurstsPool;
		}

		public function set textBurstsPool(textBurstsPool : SpritePool) : void
		{
			_textBurstsPool = textBurstsPool;
		}
	}
}
