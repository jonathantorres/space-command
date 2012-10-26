package com.jonathantorres.spacecommand.menu
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.Assets;

	/**
	 * @author Jonathan Torres
	 */
	public class Highscores extends Sprite
	{
		private var _backToMainMenu : Button;
		private var _ui : TextureAtlas;
		
		public function Highscores()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_ui = new TextureAtlas(Assets.getTexture('UI'), Assets.getTextureXML('UIXML'));
			
			var txt : TextField = new TextField(200, 35, 'HIGHSCORES', 'Arial', 24, 0xFFFFFF);
			txt.x = stage.stageWidth * 0.5 - txt.width * 0.5;
			txt.y = stage.stageHeight * 0.5 - txt.height * 0.5;
			txt.alpha = 0;
			addChild(txt);
			
			_backToMainMenu = new Button(_ui.getTexture('mainmenu_btn_normal'), '', _ui.getTexture('mainmenu_btn_over'));
			_backToMainMenu.x = 10;
			_backToMainMenu.y = (stage.stageHeight - _backToMainMenu.height) - 20;
			_backToMainMenu.alpha = 0;
			_backToMainMenu.addEventListener(TouchEvent.TOUCH, onBackToMainTouch);
			addChild(_backToMainMenu);
			
			var txtTween : Tween = new Tween(txt, 1);
			txtTween.fadeTo(1);
			Starling.juggler.add(txtTween);
			
			var backToMainTween : Tween = new Tween(_backToMainMenu, 1);
			backToMainTween.delay = 0.5;
			backToMainTween.fadeTo(1);
			Starling.juggler.add(backToMainTween);
		}

		private function onBackToMainTouch(event : TouchEvent) : void
		{
			var touch : Touch = event.getTouch(stage);
			var target : Button = Button(event.currentTarget);
			var parentSprite : Sprite = Sprite(this.parent);

			//click
			if (touch.phase == 'ended') {
				var fadeOutTween : Tween = new Tween(this, 0.7);
				fadeOutTween.fadeTo(0);
				fadeOutTween.onComplete = function() : void {
					remove();
					parentSprite.addChild(new MainMenu());
				};
				
				Starling.juggler.add(fadeOutTween);
			}
			
			//hover
			else if (touch.phase == 'hover') {
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
