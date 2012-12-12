package com.jonathantorres.spacecommand.utils
{
	import com.jonathantorres.spacecommand.Assets;
	import starling.textures.TextureAtlas;
	/**
	 * @author Jonathan Torres
	 */
	public class GameElements
	{
		public static var gameElements : TextureAtlas;
		public static var ui : TextureAtlas;
		
		public function GameElements() {}
		
		public static function init() : void
		{
			gameElements = new TextureAtlas(Assets.getTexture('GameElements'), Assets.getTextureXML('GameElementsXML'));
			ui = new TextureAtlas(Assets.getTexture('UI'), Assets.getTextureXML('UIXML'));
		}
	}
}
