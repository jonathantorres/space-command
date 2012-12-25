package com.jonathantorres.spacecommand.menu
{
	import com.jonathantorres.spacecommand.levels.Level1;
	import starling.events.TouchPhase;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.display.Button;
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.display.Image;
	import com.jonathantorres.spacecommand.ui.SpaceStars;
	import com.jonathantorres.spacecommand.ui.bg.SpaceBackground;
	import starling.utils.VAlign;
	import starling.utils.HAlign;
	import starling.textures.TextureAtlas;
	import com.jonathantorres.spacecommand.utils.GameElements;
	import com.jonathantorres.spacecommand.Assets;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.display.Sprite;

	/**
	 * @author Jonathan Torres
	 */
	public class GameOver extends Sprite
	{
		private var _gameoverTitle : TextField;
		private var _ui : TextureAtlas;
		private var _gameScore : TextField;
		private var _score : Number;
		private var _bg : SpaceBackground;
		private var _spaceStars : SpaceStars;
		private var _logo : Image;
		private var _submitScoreButton : Button;
		private var _restartGameButton : Button;
		
		public function GameOver(score : Number)
		{
			super();
			_score = score;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_ui = GameElements.ui;
			
			_bg = new SpaceBackground();
			addChild(_bg);
			
			_spaceStars = new SpaceStars();
			addChild(_spaceStars);
			
			_logo = new Image(Assets.getTexture('MainLogo'));
			_logo.pivotX = _logo.width * 0.5;
			_logo.pivotY = _logo.height * 0.5;
			_logo.x = stage.stageWidth * 0.5;
			_logo.y = 85;
			addChild(_logo);
			
			_gameoverTitle = new TextField(250, 50, 'GAME OVER', Assets.getFont('BlairMD').fontName, 24, 0xFFFFFF);
			_gameoverTitle.x = stage.stageWidth * 0.5 - _gameoverTitle.width * 0.5;
			_gameoverTitle.y = (stage.stageHeight * 0.5 - _gameoverTitle.height * 0.5) - 50;
			addChild(_gameoverTitle);
			
			_gameScore = new TextField(500, 50, 'YOUR SCORE: ' + String(_score), Assets.getFont('BlairMD').fontName, 20, 0xe34900);
			_gameScore.x = stage.stageWidth * 0.5 - _gameScore.width * 0.5;
			_gameScore.y = (stage.stageHeight * 0.5 - _gameScore.height * 0.5) + 10;
			_gameScore.hAlign = HAlign.CENTER;
			_gameScore.vAlign = VAlign.TOP;
			_gameScore.alpha = 0;
			addChild(_gameScore);
			
			_submitScoreButton = new Button(_ui.getTexture('submitscore_btn_normal'), '', _ui.getTexture('submitscore_btn_hover'));
			_submitScoreButton.x = stage.stageWidth * 0.5 - _submitScoreButton.width * 0.5;
			_submitScoreButton.y = _gameScore.y + (_submitScoreButton.height + 15);
			_submitScoreButton.alpha = 0;
			_submitScoreButton.addEventListener(TouchEvent.TOUCH, onButtonTouch);
			addChild(_submitScoreButton);
			
			_restartGameButton = new Button(_ui.getTexture('restart_btn_normal'), '', _ui.getTexture('restart_btn_over'));
			_restartGameButton.x = stage.stageWidth * 0.5 - _restartGameButton.width * 0.5;
			_restartGameButton.y = _submitScoreButton.y + (_restartGameButton.height + 15);
			_restartGameButton.alpha = 0;
			_restartGameButton.addEventListener(TouchEvent.TOUCH, onButtonTouch);
			addChild(_restartGameButton);
			
			var gameScoreAnim : Tween = new Tween(_gameScore, 1);
			gameScoreAnim.fadeTo(1);
			Starling.juggler.add(gameScoreAnim);
			
			var submitScoreBtnAnim : Tween = new Tween(_submitScoreButton, 1);
			submitScoreBtnAnim.delay = 0.4;
			submitScoreBtnAnim.fadeTo(1);
			Starling.juggler.add(submitScoreBtnAnim);
			
			var restartGameBtnAnim : Tween = new Tween(_restartGameButton, 1);
			restartGameBtnAnim.delay = 0.8;
			restartGameBtnAnim.fadeTo(1);
			Starling.juggler.add(restartGameBtnAnim);
		}

		private function onButtonTouch(event : TouchEvent) : void
		{
			var touch : Touch = event.getTouch(stage);
			var target : Button = Button(event.currentTarget);
			var parentSprite : Sprite = Sprite(this.parent);
			
			//click
			if (touch.phase == TouchPhase.ENDED) {
				if (target == _submitScoreButton) {
					parentSprite.removeChild(this);
					parentSprite.addChild(new SubmitScore(_score));
				}
				
				if (target == _restartGameButton) {
					parentSprite.removeChild(this);
					parentSprite.addChild(new Level1());
				}
			}
			
			//hover
			else if (touch.phase == TouchPhase.HOVER) {
				if (target == _submitScoreButton) 
					target.upState = _ui.getTexture('submitscore_btn_hover');
				
				if (target == _restartGameButton)
					target.upState = _ui.getTexture('restart_btn_over');
			}

			//out
			if (!event.interactsWith(target)) {
				if (target == _submitScoreButton) 
					target.upState = _ui.getTexture('submitscore_btn_normal');
				
				if (target == _restartGameButton)
					target.upState = _ui.getTexture('restart_btn_normal');
			}
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
