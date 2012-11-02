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
	public class LevelNumber extends Sprite
	{
		private var _blackBG : Quad;
		private var _levelTitle : TextField;
		private var _gameLevelText : TextField;
		
		private var _gameLevel : uint;
		
		public function LevelNumber(level : uint)
		{
			super();
			_gameLevel = level;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_blackBG = new Quad(120, 42, 0x000000);
			_blackBG.alpha = 0.7;
			addChild(_blackBG);
			
			_levelTitle = new TextField(60, 20, 'LEVEL', Assets.getFont('OCRAStd').fontName, 15, 0xFFFFFF);
			_levelTitle.vAlign = VAlign.TOP;
			_levelTitle.hAlign = HAlign.LEFT;
			_levelTitle.x = 10;
			_levelTitle.y = (_blackBG.height * 0.5) - (_levelTitle.height * 0.5);
			addChild(_levelTitle);
			
			_gameLevelText = new TextField(30, 20, String(_gameLevel), Assets.getFont('OCRAStd').fontName, 15, 0xe34900);
			_gameLevelText.x = _levelTitle.width + 10;
			_gameLevelText.y = _levelTitle.y;
			addChild(_gameLevelText);
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}

		/*
		 * Getters and setters 
		 */
		public function get gameLevel() : uint
		{
			return _gameLevel;
		}

		public function set gameLevel(gameLevel : uint) : void
		{
			_gameLevel = gameLevel;
		}
	}
}
