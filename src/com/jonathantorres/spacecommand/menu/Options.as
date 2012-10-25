package com.jonathantorres.spacecommand.menu
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	/**
	 * @author Jonathan Torres
	 */
	public class Options extends Sprite
	{
		public function Options()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			var txt : TextField = new TextField(200, 35, 'OPTIONS', 'Arial', 24, 0xFFFFFF);
			txt.x = stage.stageWidth * 0.5;
			txt.y = stage.stageHeight * 0.5;
			addChild(txt);
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
