package com.jonathantorres.spacecommand.objects
{
	import com.jonathantorres.spacecommand.levels.Level;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.extensions.PDParticleSystem;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.Assets;
	import com.jonathantorres.spacecommand.consts.LaserColors;
	import com.jonathantorres.spacecommand.utils.MouseMode;

	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	/**
	 * @author Jonathan Torres
	 */
	public class PlayerShip extends Sprite
	{
		private var _ship : Image;
		private var _fire : PDParticleSystem;
		private var _gameElements : TextureAtlas;
		private var _parent : Level;
		
		private var _moveLeft : Boolean;
		private var _moveRight : Boolean;
		private var _moveUp : Boolean;
		private var _moveDown : Boolean;
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
			
			_gameElements = new TextureAtlas(Assets.getTexture('GameElements'), Assets.getTextureXML('GameElementsXML'));

			_ship = new Image(_gameElements.getTexture('player_ship_normal'));
			_ship.x = -_ship.width;
			_ship.y = -_ship.height * 0.5;

			_fire = new PDParticleSystem(Assets.getTextureXML('MainShipThrustParticle'), 
										 Assets.getTexture('MainShipThrust'));
			_fire.emitterX = -(_ship.width - 30);
			_fire.start();

			addChild(_fire);
			addChild(_ship);

			Starling.juggler.add(_fire);
			
			_parent = Level(this.parent);
			
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
			var laser : Laser = new Laser(LaserColors.PLAYER);
			laser.x = this.x - 5;
			laser.y = this.y - 3;
			_parent.addChild(laser);
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

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
		
		/*
		 * Getters and setters 
		 */
		public function get ship() : Image
		{
			return _ship;
		}

		public function set ship(ship : Image) : void
		{
			_ship = ship;
		}
	}
}
