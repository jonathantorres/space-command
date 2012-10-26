package com.jonathantorres.spacecommand
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	import com.jonathantorres.spacecommand.menu.MainMenu;

	/**
	 * @author Jonathan Torres
	 */
	public class SpaceCommand extends Sprite
	{
		private var _bg : Image;
		private var _logo : Image;
		private var _mainMenu : MainMenu;
		private var _logoTween : Tween;
		
		public function SpaceCommand()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
		}
		
		private function init() : void
		{
			_bg = new Image(Assets.getTexture('MainMenuBG'));
			addChild(_bg);
			
			_logo = new Image(Assets.getTexture('MainLogo'));
			_logo.pivotX = _logo.width * 0.5;
			_logo.pivotY = _logo.height * 0.5;
			_logo.alpha = 0;
			_logo.x = stage.stageWidth * 0.5;
			_logo.y = 85;
			addChild(_logo);
			
			_logoTween = new Tween(_logo, 1);
			_logoTween.fadeTo(1);
			Starling.juggler.add(_logoTween);
			
			_mainMenu = new MainMenu();
			addChild(_mainMenu);
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
