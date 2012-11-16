package com.jonathantorres.spacecommand.ui
{
	import com.jonathantorres.spacecommand.levels.Level;
	import starling.utils.deg2rad;
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.Assets;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Jonathan Torres
	 */
	public class SpaceStars extends Sprite
	{
		private var _gameElements : TextureAtlas;
		private var _stars : Array;
		private var _starsTimer : Timer;
		private var _speed : Number = 0.5;
		private var _starsDelay : Number = 2000;
		
		public function SpaceStars()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function init() : void
		{
			_gameElements = new TextureAtlas(Assets.getTexture('GameElements'), Assets.getTextureXML('GameElementsXML'));
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
				var star : Image = Image(_stars[i]);
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
		
		private function remove(star : Image, index : Number) : void
		{
			removeChild(star);
			_stars.splice(index, 1);
		}

		private function starsTimerTick(event : TimerEvent) : void
		{
			var star : Image = new Image(_gameElements.getTexture('big_star'));
			star.alpha = 0;
			star.pivotX = star.width * 0.5;
			star.pivotY = star.height * 0.5;
			star.x = Math.random() * stage.stageWidth;
			star.y = Math.random() * stage.stageHeight;
			star.rotation = deg2rad(Math.floor(Math.random() * 360));
			addChild(star);
			
			_stars.push(star);
			
			var fadeIn : Tween = new Tween(star, 0.7);
			fadeIn.fadeTo(0.7);
			Starling.juggler.add(fadeIn);
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
