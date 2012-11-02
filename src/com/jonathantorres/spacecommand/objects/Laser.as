package com.jonathantorres.spacecommand.objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.Assets;
	import com.jonathantorres.spacecommand.consts.LaserColors;

	/**
	 * @author Jonathan Torres
	 */
	public class Laser extends Sprite
	{
		private var _laser : Image;
		private var _ax : Number = 2.0;
		private var _vx : Number = 0.0;
		private var _speed : Number = 0.005;
		private var _color : String;
		private var _gameElements : TextureAtlas;
		
		public function Laser(color : String)
		{
			super();
			_color = color;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init() : void
		{
			_gameElements = new TextureAtlas(Assets.getTexture('GameElements'), Assets.getTextureXML('GameElementsXML'));
			
			switch(_color) {
				case LaserColors.PLAYER :
					_laser = new Image(_gameElements.getTexture('laser_player'));
					break;

				case LaserColors.RED :
					_laser = new Image(_gameElements.getTexture('laser_enemy_red'));
					break;

				case LaserColors.GREEN :
					_laser = new Image(_gameElements.getTexture('laser_enemy_green'));
					break;

				case LaserColors.BLUE :
					_laser = new Image(_gameElements.getTexture('laser_enemy_blue'));
					break;
					
				case LaserColors.AEON :
					_laser = new Image(_gameElements.getTexture('laser_enemy_aeon'));
					break;
			}
			
			addChild(_laser);
		}
		
		public function animate(direction : String) : void
		{
			_ax += _speed;
			_vx += _ax;

			if (direction == 'right') {
				this.x += _vx;
			} else if (direction == 'left') {
				this.x -= _vx;
			}
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
