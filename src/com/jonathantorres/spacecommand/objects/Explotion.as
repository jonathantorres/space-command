package com.jonathantorres.spacecommand.objects
{
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
		private var _parent : Sprite;
		private var _explotion : PDParticleSystem;
		private var _x : Number;
		private var _y : Number;
		
		public function Explotion(x : Number, y : Number)
		{
			super();
			_x = x;
			_y = y;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_parent = Sprite(this.parent);
			
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
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
