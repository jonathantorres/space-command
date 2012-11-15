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
	public class Score extends Sprite
	{
		private var _blackBG : Quad;
		private var _scoreTitle : TextField;
		private var _gameScore : TextField;

		private var _score : Number;
		
		public function Score(score : Number)
		{
			super();
			_score = score;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_blackBG = new Quad(240, 42, 0x000000);
			_blackBG.alpha = 0.7;
			addChild(_blackBG);
			
			_scoreTitle = new TextField(60, 20, 'SCORE', Assets.getFont('OCRAStd').fontName, 15, 0xFFFFFF);
			_scoreTitle.vAlign = VAlign.TOP;
			_scoreTitle.hAlign = HAlign.LEFT;
			_scoreTitle.x = 10;
			_scoreTitle.y = (_blackBG.height * 0.5) - (_scoreTitle.height * 0.5);
			addChild(_scoreTitle);

			_gameScore = new TextField(80, 20, String(_score), Assets.getFont('OCRAStd').fontName, 15, 0xe34900);
			_gameScore.vAlign = VAlign.TOP;
			_gameScore.hAlign = HAlign.LEFT;
			_gameScore.x = _scoreTitle.width + 20;
			_gameScore.y = (_blackBG.height * 0.5) - (_gameScore.height * 0.5);
			addChild(_gameScore);
		}
		
		public function updateScore(score : Number) : void
		{
			_gameScore.text = '' + score;
		}

		public function sumScore(score : Number) : void
		{
			_score += score;
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
