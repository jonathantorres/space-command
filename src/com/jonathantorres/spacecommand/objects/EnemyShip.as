package com.jonathantorres.spacecommand.objects
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.deg2rad;

	import com.jonathantorres.spacecommand.Assets;
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;
	import com.jonathantorres.spacecommand.consts.LaserColors;
	import com.jonathantorres.spacecommand.levels.Level;
	import com.jonathantorres.spacecommand.utils.GameElements;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Jonathan Torres
	 */
	public class EnemyShip extends Sprite
	{
		private var _type : String;
		private var _color : String;
		private var _shootingInterval : Number;
		private var _vx : Number = 0.0;
		private var _vy : Number = 0.0;
		private var _speed : Number;

		private var _ship : Image;
		private var _fire : PDParticleSystem;
		private var _parent : Level;
		private var _gameElements : TextureAtlas;
		private var _shootTimer : Timer;

		public var scoreValue : uint = 50;
		public var damage : uint = 15;
		
		public function EnemyShip(type : String = EnemyTypes.ENEMY_TYPE1, 
								  color : String = EnemyShipColors.BLUE, 
								  shootingInterval : Number = 1000, 
								  speed : Number = 0.01)
		{
			super();
			_type = type;
			_color = color;
			_shootingInterval = shootingInterval;
			_speed = speed;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function init() : void
		{
			_gameElements = GameElements.gameElements;
			
			_ship = new Image(getEnemyTexture(_color, _type));
			_ship.x = 0;
			_ship.y = -(_ship.height * 0.5);
			
			// add fire thrust depending on ship type
			switch(_type){
				case EnemyTypes.ENEMY_TYPE3 :
					//addShipFire(-(_ship.width * 2) - 10, 0);
					break;
					
				case EnemyTypes.ENEMY_TYPE4 :
					//addShipFire(-(_ship.width * 2) - 20, 0);
					break;
					
				case EnemyTypes.ENEMY_TYPE5 :
					//addShipFire(-(_ship.width * 2), -5);
					break;
			}
			
			addChild(_ship);
			
			_parent = Level(this.parent);
		}

		private function addShipFire(x : Number, y : Number) : void
		{
			_fire = new PDParticleSystem(Assets.getTextureXML('MainShipThrustParticle'), 
										 Assets.getTexture('MainShipThrust'));
			_fire.scaleX = _fire.scaleY = 0.4;
			_fire.rotation = deg2rad(180);
			_fire.emitterX = x;
			_fire.emitterY = y;
			_fire.start();
			
			addChild(_fire);
			
			Starling.juggler.add(_fire);
		}

		private function getEnemyTexture(color : String, type : String) : Texture
		{
			var colorAlias : String;
			var typeAlias : String;
			
			switch(color) {
				case EnemyShipColors.BLUE :
					colorAlias = 'blue';
					break;
					
				case EnemyShipColors.BROWN :
					colorAlias = 'brown';
					break;
					
				case EnemyShipColors.CHARCOAL :
					colorAlias = 'charcoal';
					break;
					
				case EnemyShipColors.GRAY :
					colorAlias = 'gray';
					break;
					
				case EnemyShipColors.GREEN :
					colorAlias = 'green';
					break;
					
				case EnemyShipColors.RED :
					colorAlias = 'red';
					break;
					
				case EnemyShipColors.SILVER :
					colorAlias = 'silver';
					break;
			}
			
			switch(type) {
				case EnemyTypes.ENEMY_TYPE1 :
					typeAlias = '1';
					break;
					
				case EnemyTypes.ENEMY_TYPE2 :
					typeAlias = '2';
					break;
					
				case EnemyTypes.ENEMY_TYPE3 :
					typeAlias = '3';
					break;
					
				case EnemyTypes.ENEMY_TYPE4 :
					typeAlias = '4';
					break;
					
				case EnemyTypes.ENEMY_TYPE5 :
					typeAlias = '5';
					break;
			}
			
			return _gameElements.getTexture('enemy_type_' + typeAlias + '_' + colorAlias);
		}
		
		public function animate() : void
		{
			_vx += _speed;
			_vy += (_speed / 10);

			this.x -= _vx;
			this.y += _vy;
		}
		
		public function shoot() : void
		{
			var laserColor : String;
			
			switch(_color) {
				case EnemyShipColors.BLUE : 
				case EnemyShipColors.SILVER : 
					laserColor = LaserColors.BLUE;		
					break;
					
				case EnemyShipColors.GRAY : 
				case EnemyShipColors.CHARCOAL : 
					laserColor = LaserColors.AEON;	
					break;
					
				case EnemyShipColors.GREEN : 
					laserColor = LaserColors.GREEN;	
					break;
					
				case EnemyShipColors.RED : 
				case EnemyShipColors.BROWN :
					laserColor = LaserColors.RED;	
					break;
			}
			
			var laser : Laser = Laser(_parent.lasersPool.getSprite());
			laser.color = laserColor;
			laser.damage = damage;
			laser.x = this.x - 5;
			laser.y = this.y - 3;
			_parent.addChild(laser);
			laser.updateTexture();
			_parent.lasers.push(laser);
		}
		
		public function initShooting() : void
		{
			_shootTimer = new Timer(_shootingInterval);
			_shootTimer.addEventListener(TimerEvent.TIMER, onShootTimer);
			_shootTimer.start();
		}
		
		private function onShootTimer(event : TimerEvent) : void
		{
			shoot();
		}

		private function onRemovedFromStage(event : Event) : void
		{
			_shootTimer.stop();
			_shootTimer.removeEventListener(TimerEvent.TIMER, onShootTimer);
			_shootTimer = null;
			
			_vx = 0.0;
			_vy = 0.0;
		}

		private function onAddedToStage(event : Event) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}

		/*
		 * Getters and setters 
		 */
		public function get type() : String
		{
			return _type;
		}

		public function set type(type : String) : void
		{
			_type = type;
		}

		public function get color() : String
		{
			return _color;
		}

		public function set color(color : String) : void
		{
			_color = color;
		}

		public function get shootingInterval() : Number
		{
			return _shootingInterval;
		}

		public function set shootingInterval(shootingInterval : Number) : void
		{
			_shootingInterval = shootingInterval;
		}

		public function get speed() : Number
		{
			return _speed;
		}

		public function set speed(speed : Number) : void
		{
			_speed = speed;
		}
	}
}
