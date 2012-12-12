package com.jonathantorres.spacecommand.objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.utils.GameElements;

	/**
	 * @author Jonathan Torres
	 */
	public class Star extends Sprite
	{
		private var _gameElements : TextureAtlas;
		private var _starImage : Image;
		
		public function Star()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_gameElements = GameElements.gameElements;
			_starImage = new Image(_gameElements.getTexture('big_star'));
			addChild(_starImage);
		}

		private function onAddedToStage(event : Event) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
	}
}
