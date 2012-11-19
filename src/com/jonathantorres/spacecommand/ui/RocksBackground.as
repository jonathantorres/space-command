package com.jonathantorres.spacecommand.ui
{
	import com.jonathantorres.spacecommand.Assets;

	/**
	 * @author Jonathan Torres
	 */
	public class RocksBackground extends GameBackground
	{
		
		public function RocksBackground()
		{
			super();
		}
		
		override protected function init() : void
		{
			texture = Assets.getTexture('BG1');
			super.init();
		}
	}
}
