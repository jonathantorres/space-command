package com.jonathantorres.spacecommand.objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.Assets;
	import com.jonathantorres.spacecommand.consts.AsteroidSizes;

	/**
	 * @author Jonathan Torres
	 */
	public class Asteroid extends Sprite
	{
		private var _asteroid : Image;
		private var _gameElements : TextureAtlas;
		private var _size : String;
		private var _vx : Number = 0.0;
		private var _vy : Number = 0.0;
		private var _speed : Number;
		private var _rotationSpeed : Number = 0.01;
		
		public var scoreValue : uint = 30;
		public var damage : uint;
		
		public function Asteroid(size : String, speed : Number = 0.01)
		{
			super();
			_size = size;
			_speed = speed;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_gameElements = new TextureAtlas(Assets.getTexture('GameElements'), Assets.getTextureXML('GameElementsXML'));
			
			switch(_size) {
				case AsteroidSizes.SMALL :
					_asteroid = new Image(_gameElements.getTexture('asteroid_small'));
					damage = 5;
					break;

				case AsteroidSizes.MEDIUM :
					_asteroid = new Image(_gameElements.getTexture('asteroid_medium'));
					damage = 10;
					break;

				case AsteroidSizes.LARGE :
					_asteroid = new Image(_gameElements.getTexture('asteroid_large'));
					damage = 15;
					break;
			}

			_asteroid.x = -_asteroid.width * 0.5;
			_asteroid.y = -_asteroid.height * 0.5;
			addChild(_asteroid);
		}
		
		public function animate() : void
		{
			_vx += _speed;
			_vy += _speed;

			this.x -= _vx;
			this.rotation += _rotationSpeed;
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
