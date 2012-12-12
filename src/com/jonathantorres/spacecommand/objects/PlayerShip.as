package com.jonathantorres.spacecommand.objects
{
	import com.jonathantorres.spacecommand.utils.GameElements;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.extensions.PDParticleSystem;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.Assets;
	import com.jonathantorres.spacecommand.consts.LaserColors;
	import com.jonathantorres.spacecommand.consts.PlayerShipStates;
	import com.jonathantorres.spacecommand.levels.Level;
	import com.jonathantorres.spacecommand.utils.MouseMode;

	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;

	/**
	 * @author Jonathan Torres
	 */
	public class PlayerShip extends Sprite
	{
		private var _ship : MovieClip;
		private var _shipNormal : MovieClip;
		private var _shipTripleLaser : MovieClip;
		private var _shipDoubleMissile : MovieClip;
		private var _shipToTripleLaser : MovieClip;
		
		private var _fire : PDParticleSystem;
		private var _gameElements : TextureAtlas;
		private var _parent : Level;
		private var _state : String;
		private var _previousState : String;
		
		private var _moveLeft : Boolean;
		private var _moveRight : Boolean;
		private var _moveUp : Boolean;
		private var _moveDown : Boolean;
		private var _isBlinking : Boolean;
		private var _isMorphing : Boolean;
		private var _blinkTimer : Timer;
		private var _vx : Number = 0.0;
		private var _vy : Number = 0.0;
		private var _ax : Number = 0.0;
		private var _ay : Number = 0.0;
		private var _speed : Number = 0.08;
		
		private var _endX : Number;
		private var _endY : Number;
		private var _mouseX : Number;
		private var _mouseY : Number;
		
		public function PlayerShip()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			this.x = stage.stageWidth * 0.5;
			this.y = stage.stageHeight * 0.5;
			
			_gameElements = GameElements.gameElements;
			
			_isBlinking = false;
			_isMorphing = false;
			_state = PlayerShipStates.NORMAL;
			_parent = Level(this.parent);
			
			_shipNormal = new MovieClip(_gameElements.getTextures('spaceship_normal'), 30);
			_shipNormal.x = -_shipNormal.width;
			_shipNormal.y = -(_shipNormal.height * 0.5) + 5;
			_shipNormal.currentFrame = 0;
			_shipNormal.loop = false;
			_shipNormal.stop();
			
			_shipTripleLaser = new MovieClip(_gameElements.getTextures('spaceship_triplelaser'), 30);
			_shipTripleLaser.x = -_shipTripleLaser.width;
			_shipTripleLaser.y = -(_shipTripleLaser.height * 0.5) + 5;
			_shipTripleLaser.currentFrame = 0;
			_shipTripleLaser.loop = false;
			_shipTripleLaser.stop();
			
			_shipDoubleMissile = new MovieClip(_gameElements.getTextures('spaceship_doublemissile'), 30);
			_shipDoubleMissile.x = -_shipDoubleMissile.width;
			_shipDoubleMissile.y = -(_shipDoubleMissile.height * 0.5) + 5;
			_shipDoubleMissile.currentFrame = 0;
			_shipDoubleMissile.loop = false;
			_shipDoubleMissile.stop();
			
			_shipToTripleLaser = new MovieClip(_gameElements.getTextures('spaceship_totriplelaser'), 30);
			_shipToTripleLaser.x = -_shipToTripleLaser.width;
			_shipToTripleLaser.y = -(_shipToTripleLaser.height * 0.5) + 5;
			_shipToTripleLaser.currentFrame = 0;
			_shipToTripleLaser.loop = false;
			_shipToTripleLaser.stop();
			
			_ship = _shipNormal;

			_fire = new PDParticleSystem(Assets.getTextureXML('MainShipThrustParticle'), 
										 Assets.getTexture('MainShipThrust'));
			_fire.emitterX = -(_ship.width - 25);
			_fire.emitterY = 5;
			_fire.start();

			addChild(_fire);
			addChild(_ship);

			Starling.juggler.add(_fire);
			Starling.juggler.add(_ship);
			Starling.juggler.add(_shipNormal);
			Starling.juggler.add(_shipTripleLaser);
			Starling.juggler.add(_shipDoubleMissile);
			Starling.juggler.add(_shipToTripleLaser);
			
			MouseMode.mouseMode ? mouseMode() : keyboardMode();
		}
		
		public function moveShip() : void
		{
			// Movement with mouse
			if (MouseMode.mouseMode) {
				_mouseX = Starling.current.nativeStage.mouseX;
				_mouseY = Starling.current.nativeStage.mouseY;
				
				_endX = (_mouseX + (_ship.width * 0.5));
				_endY = _mouseY;
				this.x += (_endX - this.x) / 5;
				this.y += (_endY - this.y) / 5;
			}
			
			// Movement with keyboard
			else {
				_vx += _ax;
				_vy += _ay;
	
				this.x += _vx;
				this.y += _vy;
	
				if (this.x <= 0) {
					this.x = stage.stageWidth + _ship.width;
				} else if ((this.x - _ship.width) >= stage.stageWidth) {
					this.x = 0;
				}
	
				if (this.y <= 0) {
					this.y = stage.stageHeight + _ship.height;
				} else if ((this.y - _ship.height) >= stage.stageHeight) {
					this.y = 0;
				}
			}
		}
		
		public function blink() : void
		{
			_blinkTimer = new Timer(70, 10);
			_blinkTimer.addEventListener(TimerEvent.TIMER, onBlinkTimer);
			_blinkTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onBlinkTimerComplete);
			_blinkTimer.start();
		}
		
		public function morph(state : String) : void
		{
			_previousState = _state;
			this.removeChild(_ship);
			
			switch(state) {
				case PlayerShipStates.TRIPLE_LASER :
					if (_previousState == PlayerShipStates.DOUBLE_MISSILE) {
						_ship = _shipToTripleLaser;
						_state = state;
						_isMorphing = true;
					} else {
						_ship = _shipTripleLaser;
						_state = state;
						_isMorphing = true;
					}
						
					break;
					
				case PlayerShipStates.DOUBLE_MISSILE :
					if (_previousState == PlayerShipStates.TRIPLE_LASER) {
						 _ship = _shipDoubleMissile;
						 _state = state;
						 _isMorphing = true;
					}
					
					break;
			}
			
			this.addChild(_ship);
			_ship.currentFrame = 0;
			_ship.play();
			_ship.addEventListener(Event.COMPLETE, onShipMorphComplete);
		}

		public function removeListeners() : void
		{
			if (stage != null) {
				if (MouseMode.mouseMode) {
					Starling.current.nativeStage.removeEventListener(MouseEvent.CLICK, onStageClick);
				}
				
				else {
					stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
					stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				}
			}
		}
		
		private function shoot() : void
		{
			switch(_state) {
				case PlayerShipStates.NORMAL :
					createLaser(this.x - 5, this.y - 3); //front
					break;
					
				case PlayerShipStates.TRIPLE_LASER : 
					createLaser(this.x - 5, this.y - 3); //front
					createLaser(this.x - 80, this.y - 22); //top
					createLaser(this.x - 80, this.y + 22); //bottom
					createLaser(this.x - 95, this.y + 5); //middle
					break;
					
				case PlayerShipStates.DOUBLE_MISSILE :
					createMissile(this.x - 80, this.y - 28); //top missile
					createMissile(this.x - 80, this.y + 28); //bottom missile
					createLaser(this.x - 5, this.y - 3); //front
					createLaser(this.x - 80, this.y - 22); //top
					createLaser(this.x - 80, this.y + 22); //bottom
					createLaser(this.x - 95, this.y + 5); //middle
					break;
			}
		}
		
		private function createMissile(x : Number, y : Number) : void
		{
			var missile : Missile = Missile(_parent.missilesPool.getSprite());
			missile.x = x;
			missile.y = y;
			_parent.addChild(missile);
			_parent.missiles.push(missile);
		}

		private function createLaser(x : Number, y : Number) : void
		{
			var laser : Laser = Laser(_parent.lasersPool.getSprite());
			laser.color = LaserColors.PLAYER;
			laser.x = x;
			laser.y = y;
			_parent.addChild(laser);
			laser.updateTexture();
			_parent.lasers.push(laser);
		}
		
		private function mouseMode() : void
		{
			trace('mouse mode engaged!');
			Starling.current.nativeStage.addEventListener(MouseEvent.CLICK, onStageClick);
		}

		private function keyboardMode() : void
		{
			trace('keyboard mode engaged!');
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onBlinkTimer(event : TimerEvent) : void
		{
			_isBlinking = true;
			
			if (_ship.alpha == 0.3) {
				 _ship.alpha = 1;
			} else if (_ship.alpha == 1) {
				_ship.alpha = 0.3;
			}
		}
		
		private function onBlinkTimerComplete(event : TimerEvent) : void
		{
			_ship.alpha = 1;
			
			_blinkTimer.stop();
			_blinkTimer.removeEventListener(TimerEvent.TIMER, onBlinkTimer);
			_blinkTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onBlinkTimerComplete);
			_blinkTimer = null;
			
			_isBlinking = false;
		}
		
		private function onStageClick(event : MouseEvent) : void
		{
			shoot();
		}

		private function onKeyUp(event : KeyboardEvent) : void
		{
			_ax = 0;
			_ay = 0;

			switch(event.keyCode) {
				case Keyboard.LEFT :
				case Keyboard.A :
					_moveLeft = false;
					break;

				case Keyboard.RIGHT :
				case Keyboard.D :
					_moveRight = false;
					break;

				case Keyboard.UP :
				case Keyboard.W :
					_moveUp = false;
					break;

				case Keyboard.DOWN :
				case Keyboard.S :
					_moveDown = false;
					break;

				case Keyboard.SPACE :
					shoot();
					break;
			}
		}

		private function onKeyDown(event : KeyboardEvent) : void
		{
			switch(event.keyCode) {
				case Keyboard.LEFT :
				case Keyboard.A :
					_moveLeft = true;
					_ax = -_speed;
					break;

				case Keyboard.RIGHT :
				case Keyboard.D :
					_moveRight = true;
					_ax = _speed;
					break;

				case Keyboard.UP :
				case Keyboard.W :
					_moveUp = true;
					_ay = -_speed;
					break;

				case Keyboard.DOWN :
				case Keyboard.S :
					_moveDown = true;
					_ay = _speed;
					break;
			}
		}
		
		private function onShipMorphComplete(event : Event) : void
		{
			_isMorphing = false;
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
		
		/*
		 * Getters and setters 
		 */
		public function get ship() : MovieClip
		{
			return _ship;
		}

		public function set ship(ship : MovieClip) : void
		{
			_ship = ship;
		}

		public function get isBlinking() : Boolean
		{
			return _isBlinking;
		}

		public function set isBlinking(isBlinking : Boolean) : void
		{
			_isBlinking = isBlinking;
		}

		public function get state() : String
		{
			return _state;
		}

		public function set state(state : String) : void
		{
			_state = state;
		}
	}
}
