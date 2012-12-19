package com.jonathantorres.spacecommand.menu
{
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
	import com.jonathantorres.spacecommand.utils.MouseMode;
	import com.jonathantorres.spacecommand.utils.SoundManager;

	/**
	 * @author Jonathan Torres
	 */
	public class Options extends Sprite
	{
		private var _backToMainMenu : Button;
		private var _ui : TextureAtlas;
		private var _optionsTitle : TextField;
		private var _optionsTitles : Array;
		private var _buttons : Array;
		
		public function Options()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			// Get assets
			_ui = GameElements.ui;
			_optionsTitles = new Array('Sound fx', 'bg music', 'mouse mode');
			_buttons = new Array();
			
			// Titles
			_optionsTitle = new TextField(200, 35, 'OPTIONS', Assets.getFont('BlairMD').fontName, 24, 0xFFFFFF);
			_optionsTitle.x = stage.stageWidth * 0.5 - _optionsTitle.width * 0.5;
			_optionsTitle.y = (stage.stageHeight * 0.5 - _optionsTitle.height * 0.5) - 50;
			_optionsTitle.alpha = 0;
			addChild(_optionsTitle);
			
			_backToMainMenu = new Button(_ui.getTexture('mainmenu_btn_normal'), '', _ui.getTexture('mainmenu_btn_over'));
			_backToMainMenu.x = 10;
			_backToMainMenu.y = (stage.stageHeight - _backToMainMenu.height) - 20;
			_backToMainMenu.alpha = 0;
			_backToMainMenu.addEventListener(TouchEvent.TOUCH, onBackToMainTouch);
			addChild(_backToMainMenu);
			
			// Animation of titles
			var backToMainTween : Tween = new Tween(_backToMainMenu, 0.5);
			backToMainTween.delay = 0.2;
			backToMainTween.fadeTo(1);
			Starling.juggler.add(backToMainTween);
			
			var optionsTitleTween : Tween = new Tween(_optionsTitle, 0.5);
			optionsTitleTween.fadeTo(1);
			Starling.juggler.add(optionsTitleTween);
			optionsTitleTween.onComplete = function() : void {
				// Add options texts and ON-OFF buttons
				for (var i : int = 0; i < _optionsTitles.length; i++) {
					var itemTitle : TextField = new TextField(200, 35, _optionsTitles[i], Assets.getFont('BlairMD').fontName, 22, 0xFFFFFF);
					itemTitle.x = _optionsTitle.x - 60;
					itemTitle.y = (_optionsTitle.y + 70) + i * (itemTitle.height + 15);
					itemTitle.hAlign = HAlign.RIGHT;
					itemTitle.vAlign = VAlign.TOP;
					itemTitle.alpha = 0;
					addChild(itemTitle);
					
					var onOffButton : Button = new Button(_ui.getTexture('on_btn_normal'));
					onOffButton.x = (itemTitle.x + itemTitle.width) + 20;
					onOffButton.y = itemTitle.y;
					onOffButton.name = _optionsTitles[i];
					onOffButton.alpha = 0;
					_buttons.push(onOffButton);
					onOffButton.addEventListener(TouchEvent.TOUCH, onOffButtonTouched);
					addChild(onOffButton);
					
					var itemTween : Tween = new Tween(itemTitle, 0.6);
					itemTween.fadeTo(1);
					Starling.juggler.add(itemTween);
					
					var buttonTween : Tween = new Tween(onOffButton, 0.6);
					buttonTween.fadeTo(1);
					Starling.juggler.add(buttonTween);
				}
				
				// Set initial state SFX
				if (SoundManager.sfxOn)
					setButtonState('Sound fx', 'ON');
				else
					setButtonState('Sound fx', 'OFF');
					
				// Set initial state BG music
				if (SoundManager.bgMusicOn)
					setButtonState('bg music', 'ON');
				else
					setButtonState('bg music', 'OFF');
					
				// Set initial state mouse mode
				if (MouseMode.mouseMode)
					setButtonState('mouse mode', 'ON');
				else
					setButtonState('mouse mode', 'OFF');
			};
		}

		private function onOffButtonTouched(event : TouchEvent) : void
		{
			var touch : Touch = event.getTouch(stage);
			var target : Button = Button(event.currentTarget);
			
			//click
			if (touch.phase == TouchPhase.ENDED) {
				switch (target.name) {
					case 'Sound fx' :
						switchSFXMode();
						break;
						
					case 'bg music' :
						switchBGMusic();
						break;
						
					case 'mouse mode' :
						switchMouseMode();
						break;
				}
			}
		}

		private function switchSFXMode() : void
		{
			if (SoundManager.sfxOn) {
				setButtonState('Sound fx', 'OFF');
				SoundManager.sfxOn = false;
			}
			else {
				setButtonState('Sound fx', 'ON');
				SoundManager.sfxOn = true;
			}
		}
		
		private function switchBGMusic() : void
		{
			if (SoundManager.bgMusicOn) {
				setButtonState('bg music', 'OFF');
				SoundManager.bgMusicOn = false;
			}
			else {
				setButtonState('bg music', 'ON');
				SoundManager.bgMusicOn = true;
			}
		}
		
		private function switchMouseMode() : void
		{
			if (MouseMode.mouseMode) {
				setButtonState('mouse mode', 'OFF');
				MouseMode.mouseMode = false;
			}
			else {
				setButtonState('mouse mode', 'ON');
				MouseMode.mouseMode = true;
			}
		}
		
		private function setButtonState(type : String, state : String) : void
		{
			for (var i : int = 0; i < _buttons.length; i++) {
				if (_buttons[i].name == type) {
					if (state == 'ON')
						_buttons[i].upState = _ui.getTexture('on_btn_normal');
					else if (state == 'OFF')
						_buttons[i].upState = _ui.getTexture('off_btn_active');
				}
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

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
