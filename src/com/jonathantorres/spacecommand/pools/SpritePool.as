package com.jonathantorres.spacecommand.pools
{
	import starling.display.DisplayObject;
	
	/**
	 * @author Jonathan Torres
	 */
	public class SpritePool
	{
		private var _pool : Array;
		private var _counter : int;
		
		public function SpritePool(type : Class, length : int) 
		{
			_pool = new Array();
			_counter = length;
			
			var i : int = _counter;
			
			while(--i > -1) {
				_pool[i] = new type();
			}
		}
		
		public function getSprite() : DisplayObject
		{
			if (_counter > 0) {
				return _pool[--_counter];
			} else {
				throw new Error('Pool is empty!');
			}
		}
		
		public function returnSprite(sprite : DisplayObject) : void
		{
			_pool[_counter++] = sprite;
		}
	}
}
