package com.jonathantorres.spacecommand.objects
{
	import starling.textures.TextureSmoothing;
	import starling.display.Image;
	import com.jonathantorres.spacecommand.Assets;
	import starling.textures.TextureAtlas;
	import starling.events.Event;
	import starling.display.Sprite;

	/**
	 * @author Jonathan Torres
	 */
	public class LifeforceLarge extends Sprite
	{
		private var _gameElements : TextureAtlas;
		private var _lifeforce : Image;
		
		public function LifeforceLarge()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_gameElements = new TextureAtlas(Assets.getTexture('GameElements'), Assets.getTextureXML('GameElementsXML'));
			
			_lifeforce = new Image(_gameElements.getTexture('lifeforce_large'));
			_lifeforce.smoothing = TextureSmoothing.BILINEAR;
			_lifeforce.x = -_lifeforce.width * 0.5;
			_lifeforce.y = -_lifeforce.height * 0.5;
			addChild(_lifeforce);
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
