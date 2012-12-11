package com.jonathantorres.spacecommand.ui
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.deg2rad;

	import com.jonathantorres.spacecommand.levels.Level;
	import com.jonathantorres.spacecommand.objects.Star;
	import com.jonathantorres.spacecommand.pools.SpritePool;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Jonathan Torres
	 */
	public class SpaceStars extends Sprite
	{
		private var _stars : Array;
		private var _starsTimer : Timer;
		private var _starsPool : SpritePool;
		private var _speed : Number = 0.5;
		private var _starsDelay : Number = 2000;
		private var _fadeIn : Tween;
		
		public function SpaceStars()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function init() : void
		{
			_starsPool = new SpritePool(Star, 20);
			_stars = new Array();
			_starsTimer = new Timer(_starsDelay);
			_starsTimer.addEventListener(TimerEvent.TIMER, starsTimerTick);
			_starsTimer.start();
			
			if (!(this.parent is Level)) this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event : Event) : void
		{
			animateStars();
		}
		
		public function animateStars() : void
		{
			for (var i : int = _stars.length - 1; i >= 0; i--) {
				var star : Star = Star(_stars[i]);
				var angle : Number = star.rotation;
				star.x = star.x + _speed * Math.cos(angle);
				star.y = star.y + _speed * Math.sin(angle);
				
				if (star.x > stage.stageWidth + (star.width * 0.5)) {
					remove(star, i);
				} else if (star.x < -(star.width * 0.5)) {
					remove(star, i);
				}
				
				if (star.y > stage.stageHeight + (star.height * 0.5)) {
					remove(star, i);
				} else if (star.y < -(star.height * 0.5)) {
					remove(star, i);
				}
			}
		}
		
		private function remove(star : Star, index : Number) : void
		{
			removeChild(star);
			_starsPool.returnSprite(star);
			_stars.splice(index, 1);
		}

		private function starsTimerTick(event : TimerEvent) : void
		{
			var star : Star = Star(_starsPool.getSprite());
			star.alpha = 0;
			star.pivotX = star.width * 0.5;
			star.pivotY = star.height * 0.5;
			star.x = Math.random() * stage.stageWidth;
			star.y = Math.random() * stage.stageHeight;
			star.rotation = deg2rad(Math.floor(Math.random() * 360));
			addChild(star);
			
			_stars.push(star);
			
			_fadeIn = new Tween(star, 0.7);
			_fadeIn.fadeTo(0.7);
			Starling.juggler.add(_fadeIn);
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
		
		private function onRemovedFromStage(event : Event) : void
		{
			if (!(this.parent is Level)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_starsTimer.stop();
			_starsTimer.removeEventListener(TimerEvent.TIMER, starsTimerTick);
			_starsTimer = null;
		}
	}
}
