package com.jonathantorres.spacecommand.menu
{
	import starling.events.TouchPhase;
	import starling.display.Image;
	import starling.animation.Transitions;
	import com.jonathantorres.spacecommand.SpaceCommand;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.Assets;
	import com.jonathantorres.spacecommand.levels.Level;

	/**
	 * @author Jonathan Torres
	 */
	public class MainMenu extends Sprite
	{
		private var _menuItemsNames : Array;
		private var _menuItems : Array;
		private var _menu : Sprite;
		private var _ui : TextureAtlas;
		private var _withDelay : Boolean;
		
		public function MainMenu(withDelay : Boolean = true)
		{
			super();
			_withDelay = withDelay;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function init() : void
		{
			_ui = new TextureAtlas(Assets.getTexture('UI'), Assets.getTextureXML('UIXML'));
			
			_menuItemsNames = new Array(
					{ upState : 'play_btn_normal', overState : 'play_btn_over', sprite : Level }, 
					{ upState : 'options_btn_normal', overState : 'options_btn_over', sprite : Options }, 
					{ upState : 'highscores_btn_normal', overState : 'highscores_btn_over', sprite : Highscores }
			);

			_menuItems = new Array();

			_menu = new Sprite();
			_menu.x = stage.stageWidth * 0.5;
			_menu.y = 180;
			addChild(_menu);
			
			for (var i : int = 0; i < _menuItemsNames.length; i++) {
				var menuButton : Button = new Button(_ui.getTexture(_menuItemsNames[i].upState), '', _ui.getTexture(_menuItemsNames[i].overState));
				menuButton.x = -125;
				menuButton.y = i * (menuButton.height + 20);
				menuButton.alpha = 0;
				menuButton.name = String(i);
				menuButton.addEventListener(TouchEvent.TOUCH, onMenuButtonTouch);
				
				var menuButtonTween : Tween = new Tween(menuButton, 1, Transitions.EASE_OUT);
				menuButtonTween.delay = _withDelay ? 0.4 + (i * 0.3) : (i * 0.3);
				menuButtonTween.animate('x', -(menuButton.width * 0.5));
				menuButtonTween.fadeTo(1);
				Starling.juggler.add(menuButtonTween);

				_menuItems.push(menuButton);
				_menu.addChild(menuButton);
			}
		}
		
		private function onMenuButtonTouch(event : TouchEvent) : void
		{
			var touch : Touch = event.getTouch(stage);
			var target : Button = Button(event.currentTarget);
			var parentSprite : Sprite = Sprite(this.parent);

			//click
			if (touch.phase == TouchPhase.ENDED) {
				var fadeOutTween : Tween = new Tween(_menu, 0.4);
				fadeOutTween.fadeTo(0);
				fadeOutTween.onComplete = function() : void {
					if (_menuItemsNames[int(target.name)].upState == 'play_btn_normal') {
						playGame(parentSprite);
					} else {
						remove();
					
						for (var j : int = 0; j < _menuItems.length; j++) {
							if (target.name == _menuItems[j].name) {
								var menuToAdd : Sprite = new _menuItemsNames[j].sprite;
								parentSprite.addChild(menuToAdd);
							}
						}
					}
				};
				
				Starling.juggler.add(fadeOutTween);
			}
			
			//hover
			else if (touch.phase == TouchPhase.HOVER) {
				target.upState = _ui.getTexture(_menuItemsNames[int(target.name)].overState);
			}

			//out
			if (!event.interactsWith(target)) {
				target.upState = _ui.getTexture(_menuItemsNames[int(target.name)].upState);
			}
		}
		
		private function playGame(parentSprite : Sprite) : void
		{
			var logo : Image = SpaceCommand(parentSprite).logo;
			var mainBG : Image = SpaceCommand(parentSprite).bg;
			
			var logoTween : Tween = new Tween(logo, 0.4);
			logoTween.fadeTo(0);
			Starling.juggler.add(logoTween);
			
			var mainBGTween : Tween = new Tween(mainBG, 0.4);
			mainBGTween.delay = 0.2;
			mainBGTween.fadeTo(0);
			mainBGTween.onComplete = function() : void {
				parentSprite.removeChild(logo);
				parentSprite.removeChild(mainBG);
				remove();
				parentSprite.addChild(new Level());
			};
			
			Starling.juggler.add(mainBGTween);
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
