package com.jonathantorres.spacecommand
{
	import starling.core.Starling;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * @author Jonathan Torres
	 */
	[SWF(frameRate="60", width="980", height="440", backgroundColor="#000000")]
	public class Main extends Sprite
	{
		private var _starling : Starling;
		
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_starling = new Starling(SpaceCommand, stage);
			//_starling.showStats = true;
			_starling.start();
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
