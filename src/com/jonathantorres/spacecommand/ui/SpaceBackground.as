package com.jonathantorres.spacecommand.ui
{
	import com.jonathantorres.spacecommand.levels.Level;
	import com.jonathantorres.spacecommand.Assets;
	import starling.display.Image;
	import starling.events.Event;
	import starling.display.Sprite;

	/**
	 * @author Jonathan Torres
	 */
	public class SpaceBackground extends Sprite
	{
		private var _bg1 : Image;
		private var _bg2 : Image;
		private var _speed : Number = 5.0;
		
		public function SpaceBackground()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function init() : void
		{
			_bg1 = new Image(Assets.getTexture('MainMenuBG'));
			addChild(_bg1);
			
			_bg2 = new Image(Assets.getTexture('MainMenuBG'));
			_bg2.x = stage.stageWidth;
			addChild(_bg2);
			
			if (!(this.parent is Level)) this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function animate() : void
		{
			_bg1.x -= _speed;
			_bg2.x -= _speed;
			
			if (_bg1.x == -(stage.stageWidth)) _bg1.x = stage.stageWidth;
			if (_bg2.x == -(stage.stageWidth)) _bg2.x = stage.stageWidth;
		}

		private function onEnterFrame(event : Event) : void
		{
			animate();
		}

		private function onRemovedFromStage(event : Event) : void
		{
			if (!(this.parent is Level)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
