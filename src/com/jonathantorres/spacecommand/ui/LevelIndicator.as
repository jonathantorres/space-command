package com.jonathantorres.spacecommand.ui
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	import com.jonathantorres.spacecommand.Assets;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Jonathan Torres
	 */
	public class LevelIndicator extends Sprite
	{
		private var _levelNumber : Number;
		private var _levelText : TextField;
		private var _readyText : TextField;
		private var _removeIndicator : Timer;
		private var _parent : Sprite;
		private var _this : LevelIndicator;
		
		public function LevelIndicator(levelNumber : Number)
		{
			super();
			_levelNumber = levelNumber;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_parent = Sprite(this.parent);
			_this = this;
			
			_levelText = new TextField(200, 40, 'Level ' + String(_levelNumber), Assets.getFont('BlairMD').fontName, 34, 0xFFFFFF);
			_levelText.vAlign = VAlign.TOP;
			_levelText.hAlign = HAlign.LEFT;
			_levelText.x = -_levelText.width * 0.5;
			_levelText.y = -_levelText.height * 0.5;
			_levelText.alpha = 0;
			addChild(_levelText);
			
			_readyText = new TextField(90, 20, 'ready?', Assets.getFont('BlairMD').fontName, 14, 0xe34900);
			_readyText.vAlign = VAlign.TOP;
			_readyText.hAlign = HAlign.LEFT;
			_readyText.x = _levelText.x + 45;
			_readyText.y = _levelText.y + 40;
			_readyText.alpha = 0;
			addChild(_readyText);
			
			_removeIndicator = new Timer(2000, 1);
			_removeIndicator.addEventListener(TimerEvent.TIMER_COMPLETE, onRemoveIndicatorTimerComplete);
			
			var levelTextTween : Tween = new Tween(_levelText, 0.6);
			levelTextTween.fadeTo(1);
			Starling.juggler.add(levelTextTween);
			
			var readyTextTween : Tween = new Tween(_readyText, 0.6);
			readyTextTween.delay = 0.4;
			readyTextTween.fadeTo(1);
			Starling.juggler.add(readyTextTween);
			
			readyTextTween.onComplete = function() : void {
				_removeIndicator.start();
			};
		}

		private function onRemoveIndicatorTimerComplete(event : TimerEvent) : void
		{
			var levelTextTween : Tween = new Tween(_levelText, 0.6);
			levelTextTween.fadeTo(0);
			Starling.juggler.add(levelTextTween);
			
			var readyTextTween : Tween = new Tween(_readyText, 0.6);
			readyTextTween.delay = 0.4;
			readyTextTween.fadeTo(0);
			Starling.juggler.add(readyTextTween);
			
			readyTextTween.onComplete = function() : void {
				_parent.removeChild(_this);
			};
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
