package com.jonathantorres.spacecommand.ui.bg
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	/**
	 * @author Jonathan Torres
	 */
	public class GameBackground extends Sprite
	{
		private var _bg1 : Image;
		private var _bg2 : Image;
		private var _speed : Number = 5.0;
		
		protected var texture : Texture;
		
		public function GameBackground()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init() : void
		{
			_bg1 = new Image(texture);
			addChild(_bg1);
			
			_bg2 = new Image(texture);
			_bg2.x = _bg2.width;
			addChild(_bg2);
		}
		
		public function animate() : void
		{
			_bg1.x -= _speed;
			_bg2.x -= _speed;
			
			if (_bg1.x <= -(_bg1.width)) _bg1.x = _bg2.width;
			if (_bg2.x <= -(_bg2.width)) _bg2.x = _bg2.width;
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
