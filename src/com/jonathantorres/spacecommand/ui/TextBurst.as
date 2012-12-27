package com.jonathantorres.spacecommand.ui
{
	import com.jonathantorres.spacecommand.levels.Level;
	import starling.animation.Transitions;
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
	public class TextBurst extends Sprite
	{
		private var _word : String;
		private var _txt : TextField;
		private var _x : Number;
		private var _y : Number;
		private var _parent : Level;
		private var _removeTimer : Timer;
		private var _this : TextBurst;
		
		public function TextBurst()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_this = this;
			_parent = Level(_this.parent);
			
			_txt = new TextField(150, 20, '', Assets.getFont('BlairMD').fontName, 9, 0xFFFFFF);
			_txt.vAlign = VAlign.TOP;
			_txt.hAlign = HAlign.LEFT;
			_txt.pivotX = _txt.width * 0.5;
			_txt.pivotY = _txt.height * 0.5;
			addChild(_txt);
		}
		
		public function show(word : String, x : Number, y : Number) : void
		{
			_word = word;
			_x = x;
			_y = y;
			
			_this.x = _x;
			_this.y = _y;
			
			_txt.text = _word;
			_txt.scaleX = _txt.scaleY = 0;
			
			_removeTimer = new Timer(200, 1);
			_removeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onRemoveTimerComplete);
			
			var scaleTween : Tween = new Tween(_txt, 0.2, Transitions.EASE_IN_OUT);
			scaleTween.animate('scaleX', 1);
			scaleTween.animate('scaleY', 1);
			Starling.juggler.add(scaleTween);
			
			scaleTween.onComplete = function() : void {
				_removeTimer.start();
			};
		}

		private function onRemoveTimerComplete(event : TimerEvent) : void
		{
			_removeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onRemoveTimerComplete);
			
			var scaleTween : Tween = new Tween(_txt, 0.2, Transitions.EASE_IN_OUT);
			scaleTween.animate('scaleX', 0);
			scaleTween.animate('scaleY', 0);
			scaleTween.animate('alpha', 0);
			Starling.juggler.add(scaleTween);
			
			scaleTween.onComplete = function() : void {
				_parent.removeChild(_this);
				_parent.textBurstsPool.returnSprite(_this);
			};
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
