package com.jonathantorres.spacecommand.menu
{
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import starling.core.Starling;
	import flash.text.TextFieldType;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	import com.jonathantorres.spacecommand.Assets;
	import com.jonathantorres.spacecommand.ui.SpaceStars;
	import com.jonathantorres.spacecommand.ui.bg.SpaceBackground;
	import com.jonathantorres.spacecommand.utils.GameElements;

	import flash.text.TextField;

	/**
	 * @author Jonathan Torres
	 */
	public class SubmitScore extends Sprite
	{
		private var _ui : TextureAtlas;
		private var _bg : SpaceBackground;
		private var _spaceStars : SpaceStars;
		private var _logo : Image;
		private var _submitScoreTitle : starling.text.TextField;
		private var _writeNameTitle : starling.text.TextField;
		private var _submitButton : Button;
		private var _inputBg : Quad;
		private var _inputName : flash.text.TextField;
		private var _okButton : Button;
		
		public function SubmitScore()
		{
			super();
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
			
			_submitScoreTitle = new starling.text.TextField(300, 50, 'SUBMIT SCORE', Assets.getFont('BlairMD').fontName, 24, 0xFFFFFF);
			_submitScoreTitle.x = stage.stageWidth * 0.5 - _submitScoreTitle.width * 0.5;
			_submitScoreTitle.y = (stage.stageHeight * 0.5 - _submitScoreTitle.height * 0.5) - 40;
			addChild(_submitScoreTitle);
			
			_writeNameTitle = new starling.text.TextField(300, 50, 'WRITE YOUR NAME', Assets.getFont('BlairMD').fontName, 20, 0xe34900);
			_writeNameTitle.x = stage.stageWidth * 0.5 - _writeNameTitle.width * 0.5;
			_writeNameTitle.y = (stage.stageHeight * 0.5 - _writeNameTitle.height * 0.5) + 20;
			_writeNameTitle.hAlign = HAlign.CENTER;
			_writeNameTitle.vAlign = VAlign.TOP;
			addChild(_writeNameTitle);
			
			_inputBg = new Quad(200, 33, 0x2c2c2b);
			_inputBg.x = _writeNameTitle.x - 20;
			_inputBg.y = (_writeNameTitle.y + _inputBg.height) + 20;
			addChild(_inputBg);
			
			_submitButton = new Button(_ui.getTexture('submit_btn_normal'), '', _ui.getTexture('submit_btn_hover'));
			_submitButton.x = (_inputBg.x + _inputBg.width) + 20;
			_submitButton.y = _inputBg.y;
			_submitButton.addEventListener(TouchEvent.TOUCH, onSubmitButtonTouch);
			addChild(_submitButton);
			
			var inputTextFormat : TextFormat = new TextFormat();
			inputTextFormat.align = TextFormatAlign.LEFT;
			inputTextFormat.color = 0xFFFFFF;
			inputTextFormat.font = 'Arial';
			inputTextFormat.bold = true;
			inputTextFormat.size = 20;
			
			_inputName = new flash.text.TextField();
			_inputName.type = TextFieldType.INPUT;
			_inputName.x = _inputBg.x;
			_inputName.y = _inputBg.y;
			_inputName.width = _inputBg.width;
			_inputName.maxChars = 12;
			_inputName.defaultTextFormat = inputTextFormat;
			Starling.current.nativeOverlay.addChild(_inputName);
		}

		private function onSubmitButtonTouch(event : TouchEvent) : void
		{
			var touch : Touch = event.getTouch(stage);
			var target : Button = Button(event.currentTarget);
			
			//click
			if (touch.phase == TouchPhase.ENDED) {
				if (_inputName.text == '') {
					_writeNameTitle.width = 500;
					_writeNameTitle.x = stage.stageWidth * 0.5 - _writeNameTitle.width * 0.5;
					_writeNameTitle.text = 'PLEASE, WRITE YOUR NAME';
				} else {
					removeChild(_inputBg);
					removeChild(_submitButton);
					Starling.current.nativeOverlay.removeChild(_inputName);
					
					_writeNameTitle.width = 500;
					_writeNameTitle.x = stage.stageWidth * 0.5 - _writeNameTitle.width * 0.5;
					_writeNameTitle.text = 'your score has been submitted!';
					trace('score submitted! :)');
					
					_okButton = new Button(_ui.getTexture('ok_btn_normal'), '', _ui.getTexture('ok_btn_over'));
					_okButton.x = (stage.stageWidth * 0.5) - (_okButton.width * 0.5);
					_okButton.y = (_writeNameTitle.y + _writeNameTitle.height) + 10;
					_okButton.addEventListener(TouchEvent.TOUCH, onOkButtonTouch);
					addChild(_okButton);
				}
			}
			
			//hover
			else if (touch.phase == TouchPhase.HOVER) {
				target.upState = _ui.getTexture('submit_btn_hover');
			}

			//out
			if (!event.interactsWith(target)) {
				target.upState = _ui.getTexture('submit_btn_normal');
			}
		}

		private function onOkButtonTouch(event : TouchEvent) : void
		{
			var touch : Touch = event.getTouch(stage);
			var target : Button = Button(event.currentTarget);
			
			//click
			if (touch.phase == TouchPhase.ENDED) {
				removeChild(_submitScoreTitle);
				removeChild(_writeNameTitle);
				removeChild(_okButton);
				
				var mainMenu : MainMenu = new MainMenu();
				addChild(mainMenu);
			}
			
			//hover
			else if (touch.phase == TouchPhase.HOVER) {
				target.upState = _ui.getTexture('ok_btn_over');
			}

			//out
			if (!event.interactsWith(target)) {
				target.upState = _ui.getTexture('ok_btn_normal');
			}
		}
		
		public function removeLogo() : void
		{
			removeChild(_logo);
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
