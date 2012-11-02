package com.jonathantorres.spacecommand.ui
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	import com.jonathantorres.spacecommand.Assets;

	/**
	 * @author Jonathan Torres
	 */
	public class Lifebar extends Sprite
	{
		private var _blackBG : Quad;
		private var _lifeDisplay : Quad;
		private var _lifeText : TextField;

		private var _totalLife : Number = 200;
		
		public function Lifebar()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_blackBG = new Quad(290, 42, 0x000000);
			_blackBG.alpha = 0.7;
			addChild(_blackBG);
			
			_lifeText = new TextField(50, 20, 'LIFE', Assets.getFont('OCRAStd').fontName, 15, 0xFFFFFF);
			_lifeText.vAlign = VAlign.TOP;
			_lifeText.hAlign = HAlign.LEFT;
			_lifeText.x = 10;
			_lifeText.y = (_blackBG.height * 0.5) - (_lifeText.height * 0.5);
			addChild(_lifeText);
			
			_lifeDisplay = new Quad(totalLife, 10, 0xe34900);
			_lifeDisplay.x = _lifeText.width + 20;
			_lifeDisplay.y = _lifeText.y + 3;
			addChild(_lifeDisplay);
		}
		
		public function increaseLife(amount : Number) : void
		{
			_totalLife += amount;

			if (_totalLife < 200) {
				updateLifebar();
			} else if (_totalLife >= 200) {
				_totalLife = 200;
				updateLifebar();
			}
		}

		public function decreaseLife(amount : Number) : void
		{
			_totalLife -= amount;

			if (_totalLife <= 0) {
				_totalLife = 0;
				updateLifebar();
			} else {
				updateLifebar();
			}
		}

		private function updateLifebar() : void
		{
			_lifeDisplay.width = _totalLife;
		}
		
		private function onAddedToStage(event : Event) : void
		{
			init();
		}

		/*
		 * Getters and setters 
		 */
		public function get totalLife() : Number
		{
			return _totalLife;
		}

		public function set totalLife(totalLife : Number) : void
		{
			_totalLife = totalLife;
		}
	}
}
