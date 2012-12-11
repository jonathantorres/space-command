package com.jonathantorres.spacecommand.objects.icons
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.Assets;

	/**
	 * @author Jonathan Torres
	 */
	public class Icon extends Sprite
	{
		private var _vx : Number = 0.0;
		private var _vy : Number = 0.0;
		private var _speed : Number = 0.01;
		
		private var _gameElements : TextureAtlas;
		private var _textureName : String;
		private var _icon : Image;
		
		public function Icon(textureName : String)
		{
			super();
			_textureName = textureName;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function init() : void
		{
			_gameElements = new TextureAtlas(Assets.getTexture('GameElements'), Assets.getTextureXML('GameElementsXML'));
			
			_icon = new Image(_gameElements.getTexture(_textureName));
			_icon.x = _icon.width * 0.5;
			_icon.y = _icon.height * 0.5;
			addChild(_icon);
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
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		private function onRemovedFromStage(event : Event) : void
		{
			_vx = 0.0;
			_vy = 0.0;
		}
	}
}
