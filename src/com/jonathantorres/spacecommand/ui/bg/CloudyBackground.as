package com.jonathantorres.spacecommand.ui.bg
{
	import com.jonathantorres.spacecommand.Assets;

	/**
	 * @author Jonathan Torres
	 */
	public class CloudyBackground extends GameBackground
	{
		
		public function CloudyBackground()
		{
			super();
		}
		
		override protected function init() : void
		{
			texture = Assets.getTexture('BG3');
			super.init();
		}
	}
}
