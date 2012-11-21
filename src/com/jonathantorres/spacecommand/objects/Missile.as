package com.jonathantorres.spacecommand.objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.Assets;

	/**
	 * @author Jonathan Torres
	 */
	public class Missile extends Sprite
	{
		private var _gameElements : TextureAtlas;
		private var _missile : Image;
		
		private var _ax : Number = 2.0;
		private var _vx : Number = 0.0;
		private var _speed : Number = 0.005;
		
		public function Missile()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_gameElements = new TextureAtlas(Assets.getTexture('GameElements'), Assets.getTextureXML('GameElementsXML'));
			_missile = new Image(_gameElements.getTexture('missile'));
			addChild(_missile);
		}
		
		public function animate() : void
		{
			_ax += _speed;
			_vx += _ax;
			this.x += _vx;
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
