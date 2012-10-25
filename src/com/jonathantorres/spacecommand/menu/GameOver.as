package com.jonathantorres.spacecommand.menu
{
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
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
