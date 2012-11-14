package com.jonathantorres.spacecommand.menu
{
	import starling.text.TextField;
	import starling.events.Event;
	import starling.display.Sprite;

	/**
	 * @author Jonathan Torres
	 */
	public class GameOver extends Sprite
	{
		public function GameOver()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			var txt : TextField = new TextField(200, 35, 'GAME OVER', 'Arial', 24, 0xFFFFFF);
			txt.x = stage.stageWidth * 0.5 - txt.width * 0.5;
			txt.y = stage.stageHeight * 0.5 - txt.height * 0.5;
			addChild(txt);
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
