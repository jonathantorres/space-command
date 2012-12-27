package com.jonathantorres.spacecommand
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import com.jonathantorres.spacecommand.utils.GameElements;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	import com.jonathantorres.spacecommand.menu.MainMenu;
	import com.jonathantorres.spacecommand.ui.SpaceStars;
	import com.jonathantorres.spacecommand.ui.bg.SpaceBackground;


	/**
	 * @author Jonathan Torres
	 */
	public class SpaceCommand extends Sprite
	{
		private var _bg : SpaceBackground;
		private var _logo : Image;
		private var _mainMenu : MainMenu;
		private var _logoTween : Tween;
		private var _credits : TextField;
		private var _spaceStars : SpaceStars;
		private var _bgAudio : Sound;
		
		public static var bgAudioChannel : SoundChannel;
		
		public function SpaceCommand()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
		}
		
		private function init() : void
		{
			Assets.prepareSounds();
			GameElements.init();
			
			_bgAudio = Assets.getSound('BackgroundMusic');
			bgAudioChannel = _bgAudio.play(0, int.MAX_VALUE);
			
			_bg = new SpaceBackground();
			addChild(_bg);
			
			_spaceStars = new SpaceStars();
			addChild(_spaceStars);
			
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
			
			_credits = new TextField(500, 25, 'Designed & Developed by Jonathan Torres', 'Helvetica', 12, 0x666666);
			_credits.x = (stage.stageWidth * 0.5) - (_credits.width * 0.5);
			_credits.y = stage.stageHeight - _credits.height;
			addChild(_credits);
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
		
		/*
		 * Getters and setters 
		 */
		public function get bg() : SpaceBackground
		{
			return _bg;
		}

		public function set bg(bg : SpaceBackground) : void
		{
			_bg = bg;
		}

		public function get logo() : Image
		{
			return _logo;
		}

		public function set logo(logo : Image) : void
		{
			_logo = logo;
		}

		public function get spaceStars() : SpaceStars
		{
			return _spaceStars;
		}

		public function set spaceStars(spaceStars : SpaceStars) : void
		{
			_spaceStars = spaceStars;
		}
	}
}
