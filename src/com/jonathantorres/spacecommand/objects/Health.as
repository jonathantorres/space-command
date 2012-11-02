package com.jonathantorres.spacecommand.objects
{
	import com.jonathantorres.spacecommand.Assets;
	import starling.textures.TextureAtlas;
	import starling.display.Image;
	import starling.events.Event;
	import starling.display.Sprite;

	/**
	 * @author Jonathan Torres
	 */
	public class Health extends Sprite
	{
		private var _vx : Number = 0.0;
		private var _vy : Number = 0.0;
		private var _speed : Number = 0.01;

		private var _health : Image;
		private var _gameElements : TextureAtlas;
		
		public var lifeIncrease : Number = 40;
		
		public function Health()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_gameElements = new TextureAtlas(Assets.getTexture('GameElements'), Assets.getTextureXML('GameElementsXML'));
			
			_health = new Image(_gameElements.getTexture('icon_health'));
			_health.x = _health.width * 0.5;
			_health.y = _health.height * 0.5;
			addChild(_health);
		}
		
		public function animate() : void
		{
			_vx += _speed;
			_vy += (_speed / 10);

			this.x -= _vx;
			this.y += _vy;
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
