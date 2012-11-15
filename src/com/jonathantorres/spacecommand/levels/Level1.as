package com.jonathantorres.spacecommand.levels
{
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;

	/**
	 * @author Jonathan Torres
	 */
	public class Level1 extends Level
	{
		public function Level1()
		{
			super();
		}
		
		override protected function init() : void
		{
			this.x = stage.stageWidth;
			
			super.init();
			
			gameScore = 0;
			gameLevel = 1;
			
			addUI();
			initLasers();
			initEnemies();
			initHealthbars();
			initAsteroids();
			initLifeforces();
			
			var startTween : Tween = new Tween(this, 0.7, Transitions.EASE_OUT);
			startTween.animate('x', 0);
			Starling.juggler.add(startTween);
		}
	}
}
