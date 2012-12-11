package com.jonathantorres.spacecommand.objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.Assets;
	import com.jonathantorres.spacecommand.consts.LaserColors;

	/**
	 * @author Jonathan Torres
	 */
	public class Laser extends Sprite
	{
		private var _laser : Image;
		private var _ax : Number = 2.0;
		private var _vx : Number = 0.0;
		private var _speed : Number = 0.005;
		private var _color : String;
		private var _gameElements : TextureAtlas;
		
		private var _damage : uint;
		
		public function Laser(color : String = LaserColors.PLAYER)
		{
			super();
			_color = color;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function init() : void
		{
			_gameElements = new TextureAtlas(Assets.getTexture('GameElements'), Assets.getTextureXML('GameElementsXML'));
			
			switch(_color) {
				case LaserColors.PLAYER :
					_laser = new Image(_gameElements.getTexture('laser_player'));
					break;

				case LaserColors.RED :
					_laser = new Image(_gameElements.getTexture('laser_enemy_red'));
					break;

				case LaserColors.GREEN :
					_laser = new Image(_gameElements.getTexture('laser_enemy_green'));
					break;

				case LaserColors.BLUE :
					_laser = new Image(_gameElements.getTexture('laser_enemy_blue'));
					break;
					
				case LaserColors.AEON :
					_laser = new Image(_gameElements.getTexture('laser_enemy_aeon'));
					break;
			}
			
			addChild(_laser);
		}
		
		public function animate(direction : String) : void
		{
			_ax += _speed;
			_vx += _ax;

			if (direction == 'right') {
				this.x += _vx;
			} else if (direction == 'left') {
				this.x -= _vx;
			}
		}
		
		public function updateTexture() : void
		{
			switch(_color) {
				case LaserColors.PLAYER :
					_laser.texture = _gameElements.getTexture('laser_player');
					break;

				case LaserColors.RED :
					_laser.texture = _gameElements.getTexture('laser_enemy_red');
					break;

				case LaserColors.GREEN :
					_laser.texture = _gameElements.getTexture('laser_enemy_green');
					break;

				case LaserColors.BLUE :
					_laser.texture = _gameElements.getTexture('laser_enemy_blue');
					break;
					
				case LaserColors.AEON :
					_laser.texture = _gameElements.getTexture('laser_enemy_aeon');
					break;
			}
		}

		private function onAddedToStage(event : Event) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		private function onRemovedFromStage(event : Event) : void
		{
			_ax = 2.0;
			_vx = 0.0;
		}
		
		/*
		 * Getters and setters 
		 */
		public function get color() : String
		{
			return _color;
		}

		public function set color(color : String) : void
		{
			_color = color;
		}

		public function get damage() : uint
		{
			return _damage;
		}

		public function set damage(damage : uint) : void
		{
			_damage = damage;
		}
	}
}
