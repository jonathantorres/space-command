package com.jonathantorres.spacecommand.menu
{
	import starling.events.Event;
	import starling.display.Sprite;

	/**
	 * @author Jonathan Torres
	 */
	public class SubmitScore extends Sprite
	{
		public function SubmitScore()
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
