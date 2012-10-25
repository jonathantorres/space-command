package com.jonathantorres.spacecommand
{
	import starling.textures.Texture;

	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.text.Font;
	import flash.utils.Dictionary;
	
	/**
	 * @author Jonathan Torres
	 */
	 
	public class Assets 
	{
		// Main Menu Logo
		[Embed(source="../../../../assets/textures/logo.png")]
		public static const MainLogo : Class;
		
		// UI
		[Embed(source="../../../../assets/textures/ui.png")]
		public static const UI : Class;
		
		// UI XML
		[Embed(source="../../../../assets/textures/ui.xml", mimeType="application/octet-stream")]
		public static const UIXML : Class;
		
		// Game Sprites
		[Embed(source="../../../../assets/textures/game_elements.png")]
		public static const GameElements : Class;
		
		// Game Sprites XML
		[Embed(source="../../../../assets/textures/game_elements.xml", mimeType="application/octet-stream")]
		public static const GameElementsXML : Class;
		
		/*
		 * All Game Backgrounds ------------------------------------------------------
		 */
		// Main Menu Bg
		[Embed(source="../../../../assets/textures/main_menu_bg.jpg")]
		public static const MainMenuBG : Class;
		
		// Bg1
		[Embed(source="../../../../assets/textures/bg1.jpg")]
		public static const BG1 : Class;
		
		// Bg2
		[Embed(source="../../../../assets/textures/bg2.jpg")]
		public static const BG2 : Class;
		
		// Bg3
		[Embed(source="../../../../assets/textures/bg3.jpg")]
		public static const BG3 : Class;
		
		private static var _textureAssets : Dictionary = new Dictionary();
		private static var _xmlAssets : Dictionary = new Dictionary();
		private static var _soundAssets : Dictionary = new Dictionary();
	
		public function Assets() { }
		
		/*
		 * Get single texture
		 */
		public static function getTexture(name : String) : Texture
		{	
			if (_textureAssets[name] == undefined) {
				var bitmap : Bitmap = Bitmap(new Assets[name]());
				_textureAssets[name] = Texture.fromBitmap(bitmap);
			}

			return _textureAssets[name];
		}
		
		/*
		 * Get XML of texture atlas
		 */
		public static function getTextureXML(name : String) : XML
		{
			if (_xmlAssets[name] == undefined) {
				_xmlAssets[name] = XML(new Assets[name]());
			}

			return _xmlAssets[name];
		}
		
		/*
		 * Get a single sound
		 */
		public static function getSound(name : String) : Sound
		{
			var sound : Sound = Sound(_soundAssets[name]);
			return sound;
		}
		
		/*
		 * Get a single font
		 */
		public static function getFont(name : String) : Font
		{
			var font : Font = new Assets[name]();
			return font;
		}
	}
}
