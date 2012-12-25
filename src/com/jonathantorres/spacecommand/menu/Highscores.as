package com.jonathantorres.spacecommand.menu
{
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	import com.jonathantorres.spacecommand.Assets;
	import com.jonathantorres.spacecommand.utils.GameElements;

	/**
	 * @author Jonathan Torres
	 */
	public class Highscores extends Sprite
	{
		private var _backToMainMenu : Button;
		private var _ui : TextureAtlas;
		private var _highscoresTitle : TextField;
		private var _XMLLoader : URLLoader;
		
		public function Highscores()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			// Get assets
			_ui = GameElements.ui;
			
			// Titles
			_highscoresTitle = new TextField(250, 50, 'HIGHSCORES', Assets.getFont('BlairMD').fontName, 24, 0xFFFFFF);
			_highscoresTitle.x = stage.stageWidth * 0.5 - _highscoresTitle.width * 0.5;
			_highscoresTitle.y = (stage.stageHeight * 0.5 - _highscoresTitle.height * 0.5) - 50;
			_highscoresTitle.alpha = 0;
			addChild(_highscoresTitle);
			
			_backToMainMenu = new Button(_ui.getTexture('mainmenu_btn_normal'), '', _ui.getTexture('mainmenu_btn_over'));
			_backToMainMenu.x = 10;
			_backToMainMenu.y = (stage.stageHeight - _backToMainMenu.height) - 20;
			_backToMainMenu.alpha = 0;
			_backToMainMenu.addEventListener(TouchEvent.TOUCH, onBackToMainTouch);
			addChild(_backToMainMenu);
			
			// Get XML
			_XMLLoader = new URLLoader(new URLRequest('highscores.xml'));
			_XMLLoader.addEventListener(flash.events.Event.COMPLETE, onXMLComplete);
			
			// Animation of titles
			var backToMainTween : Tween = new Tween(_backToMainMenu, 0.5);
			backToMainTween.delay = 0.2;
			backToMainTween.fadeTo(1);
			Starling.juggler.add(backToMainTween);
			
			var highscoresTitleTween : Tween = new Tween(_highscoresTitle, 0.5);
			highscoresTitleTween.fadeTo(1);
			Starling.juggler.add(highscoresTitleTween);
		}

		private function onXMLComplete(event : flash.events.Event) : void
		{
			var xml : XML = XML(_XMLLoader.data);
			var xmlList : XMLList = xml.score;
			
			// Add highscores
			for (var i : int = 0; i < xmlList.length(); i++) {
				var nameText : TextField = new TextField(150, 30, String(i + 1) + '. ' + xmlList[i].username, Assets.getFont('BlairMD').fontName, 11, 0xFFFFFF);
				nameText.x = _highscoresTitle.x + 15;
				nameText.y = (_highscoresTitle.y + _highscoresTitle.height) + i * (nameText.height / 1.6);
				nameText.hAlign = HAlign.LEFT;
				nameText.vAlign = VAlign.TOP;
				addChild(nameText);
				
				var scoreText : TextField = new TextField(60, 30, xmlList[i].score, Assets.getFont('BlairMD').fontName, 11, 0xe34900);
				scoreText.x = nameText.x + 160;
				scoreText.y = nameText.y;
				scoreText.hAlign = HAlign.RIGHT;
				scoreText.vAlign = VAlign.TOP;
				addChild(scoreText);
			}
		}

		private function onBackToMainTouch(event : TouchEvent) : void
		{
			var touch : Touch = event.getTouch(stage);
			var target : Button = Button(event.currentTarget);
			var parentSprite : Sprite = Sprite(this.parent);

			//click
			if (touch.phase == TouchPhase.ENDED) {
				var fadeOutTween : Tween = new Tween(this, 0.4);
				fadeOutTween.fadeTo(0);
				fadeOutTween.onComplete = function() : void {
					remove();
					parentSprite.addChild(new MainMenu(false));
				};
				
				Starling.juggler.add(fadeOutTween);
			}
			
			//hover
			else if (touch.phase == TouchPhase.HOVER) {
				target.upState = _ui.getTexture('mainmenu_btn_over');
			}

			//out
			if (!event.interactsWith(target)) {
				target.upState = _ui.getTexture('mainmenu_btn_normal');
			}
		}
		
		private function remove() : void
		{
			this.parent.removeChild(this);
		}

		private function onAddedToStage(event : starling.events.Event) : void
		{
			init();
		}
	}
}
