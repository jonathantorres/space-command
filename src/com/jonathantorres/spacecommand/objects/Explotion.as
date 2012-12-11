package com.jonathantorres.spacecommand.objects
{
	import com.jonathantorres.spacecommand.levels.Level;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;

	import com.jonathantorres.spacecommand.Assets;

	/**
	 * @author Jonathan Torres
	 */
	public class Explotion extends Sprite
	{
		private var _parent : Level;
		private var _explotion : PDParticleSystem;
		private var _x : Number;
		private var _y : Number;
		
		public function Explotion()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_parent = Level(this.parent);
		}
		
		public function explode(x : Number, y : Number) : void
		{
			_x = x;
			_y = y;
			this.x = _x;
			this.y = _y;
			
			_explotion = new PDParticleSystem(Assets.getTextureXML('ExplotionParticle'), Assets.getTexture('Explotion'));
			_explotion.x = -(_explotion.width * 0.5);
			_explotion.y = -(_explotion.height * 0.5);
			_explotion.start(0.1);
			_explotion.addEventListener(Event.COMPLETE, onParticleCompleted);
			addChild(_explotion);
			
			Starling.juggler.add(_explotion);
		}

		private function onParticleCompleted(event : Event) : void
		{
			_parent.removeChild(this);
			_parent.explotionsPool.returnSprite(this);
		}

		private function onAddedToStage(event : Event) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
	}
}
