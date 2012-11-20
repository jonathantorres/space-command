package com.jonathantorres.spacecommand.ui.bg
{
	import com.jonathantorres.spacecommand.Assets;

	/**
	 * @author Jonathan Torres
	 */
	public class RedRocksBackground extends GameBackground
	{
		
		public function RedRocksBackground()
		{
			super();
		}
		
		override protected function init() : void
		{
			texture = Assets.getTexture('BG2');
			super.init();
		}
	}
}
