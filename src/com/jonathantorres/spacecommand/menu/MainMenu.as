package com.jonathantorres.spacecommand.menu
{
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
		
		public function MainMenu()
		{
			super();
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
				menuButton.x = -(menuButton.width * 0.5);
				menuButton.y = i * (menuButton.height + 20);
				menuButton.name = String(i);
				menuButton.addEventListener(TouchEvent.TOUCH, onMenuButtonTouch);

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
			if (touch.phase == 'ended') {
				parentSprite.removeChild(this);
				
				for (var j : int = 0; j < _menuItems.length; j++) {
					if (target.name == _menuItems[j].name) {
						var menuToAdd : Sprite = new _menuItemsNames[j].sprite;
						parentSprite.addChild(menuToAdd);
					}
				}
			}
			
			//hover
			else if (touch.phase == 'hover') {
				target.upState = _ui.getTexture(_menuItemsNames[int(target.name)].overState);
			}

			//out
			if (!event.interactsWith(target)) {
				target.upState = _ui.getTexture(_menuItemsNames[int(target.name)].upState);
			}
		}
		
		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
