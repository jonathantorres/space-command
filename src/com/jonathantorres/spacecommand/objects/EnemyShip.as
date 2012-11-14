package com.jonathantorres.spacecommand.objects
{
	import com.jonathantorres.spacecommand.levels.Level;
	import com.jonathantorres.spacecommand.consts.LaserColors;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import com.jonathantorres.spacecommand.Assets;
	import com.jonathantorres.spacecommand.consts.EnemyShipColors;
	import com.jonathantorres.spacecommand.consts.EnemyTypes;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Jonathan Torres
	 */
	public class EnemyShip extends Sprite
	{
		private var _type : String;
		private var _color : String;
		private var _vx : Number = 0.0;
		private var _vy : Number = 0.0;
		private var _speed : Number = 0.01;

		private var _ship : Image;
		private var _parent : Level;
		private var _gameElements : TextureAtlas;
		private var _shootTimer : Timer;

		public var scoreValue : uint = 50;
		public var damage : uint = 15;
		
		public function EnemyShip(type : String, color : String)
		{
			super();
			_type = type;
			_color = color;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function init() : void
		{
			_gameElements = new TextureAtlas(Assets.getTexture('GameElements'), Assets.getTextureXML('GameElementsXML'));
			
			switch(_color) {
				case EnemyShipColors.BLUE : 
					_ship = new Image(getBlueTexture(_type));		
					break;
					
				case EnemyShipColors.GRAY : 
					_ship = new Image(getGrayTexture(_type));		
					break;
					
				case EnemyShipColors.GREEN : 
					_ship = new Image(getGreenTexture(_type));		
					break;
					
				case EnemyShipColors.RED : 
					_ship = new Image(getRedTexture(_type));		
					break;
					
				case EnemyShipColors.CHARCOAL : 
					_ship = new Image(getCharcoalTexture(_type));		
					break;
					
				case EnemyShipColors.SILVER : 
					_ship = new Image(getSilverTexture(_type));		
					break;
					
				case EnemyShipColors.BROWN : 
					_ship = new Image(getBrownTexture(_type));		
					break;
			}

			_ship.x = 0;
			_ship.y = -(_ship.height * 0.5);
			addChild(_ship);

			_shootTimer = new Timer((Math.random() * 2000) + 1000);
			_shootTimer.addEventListener(TimerEvent.TIMER, onShootTimer);
			_shootTimer.start();
			
			_parent = Level(this.parent);
		}
		
		public function animate() : void
		{
			_vx += _speed;
			_vy += (_speed / 10);

			this.x -= _vx;
			this.y += _vy;
		}
		
		public function shoot() : void
		{
			var laserColor : String;
			
			switch(_color) {
				case EnemyShipColors.BLUE : 
				case EnemyShipColors.SILVER : 
					laserColor = LaserColors.BLUE;		
					break;
					
				case EnemyShipColors.GRAY : 
				case EnemyShipColors.CHARCOAL : 
					laserColor = LaserColors.AEON;	
					break;
					
				case EnemyShipColors.GREEN : 
					laserColor = LaserColors.GREEN;	
					break;
					
				case EnemyShipColors.RED : 
				case EnemyShipColors.BROWN :
					laserColor = LaserColors.RED;	
					break;
			}
			
			var laser : Laser = new Laser(laserColor);
			laser.x = this.x - 5;
			laser.y = this.y - 3;
			laser.damage = damage;
			_parent.addChild(laser);
			_parent.lasers.push(laser);
		}
		
		private function onShootTimer(event : TimerEvent) : void
		{
			shoot();
		}

		private function getBlueTexture(type : String) : Texture
		{
			var texture : Texture;
			
			switch(type) {
				case EnemyTypes.ENEMY_TYPE1 :
					texture = _gameElements.getTexture('enemy_type_1_blue');
					break;
					
				case EnemyTypes.ENEMY_TYPE3 :
					texture = _gameElements.getTexture('enemy_type_3_blue');
					break;
					
				default :
					throw new Error('Enemy Texture does not exist!');
					break;
			}
			
			return texture;
		}
		
		private function getGrayTexture(type : String) : Texture
		{
			var texture : Texture;
			
			switch(type) {
				case EnemyTypes.ENEMY_TYPE1 :
					texture = _gameElements.getTexture('enemy_type_1_gray');
					break;
					
				case EnemyTypes.ENEMY_TYPE2 :
					texture = _gameElements.getTexture('enemy_type_2_gray');
					break;
					
				case EnemyTypes.ENEMY_TYPE4 :
					texture = _gameElements.getTexture('enemy_type_4_gray');
					break;
					
				case EnemyTypes.ENEMY_TYPE5 :
					texture = _gameElements.getTexture('enemy_type_5_gray');
					break;
					
				default :
					throw new Error('Enemy Texture does not exist!');
					break;
			}
			
			return texture;
		}
		
		private function getGreenTexture(type : String) : Texture
		{
			var texture : Texture;
			
			switch(type) {
				case EnemyTypes.ENEMY_TYPE1 :
					texture = _gameElements.getTexture('enemy_type_1_green');
					break;
					
				case EnemyTypes.ENEMY_TYPE4 :
					texture = _gameElements.getTexture('enemy_type_4_green');
					break;
					
				default :
					throw new Error('Enemy Texture does not exist!');
					break;
			}
			
			return texture;
		}
		
		private function getRedTexture(type : String) : Texture
		{
			var texture : Texture;
			
			switch(type) {
				case EnemyTypes.ENEMY_TYPE1 :
					texture = _gameElements.getTexture('enemy_type_1_red');
					break;
					
				case EnemyTypes.ENEMY_TYPE3 :
					texture = _gameElements.getTexture('enemy_type_3_red');
					break;
					
				default :
					throw new Error('Enemy Texture does not exist!');
					break;
			}
			
			return texture;
		}
		
		private function getCharcoalTexture(type : String) : Texture
		{
			var texture : Texture;
			
			if (_type == EnemyTypes.ENEMY_TYPE2) {
				texture = _gameElements.getTexture('enemy_type_2_charcoal');
			} else {
				throw new Error('Enemy Texture does not exist!');
			}
			
			return texture;
		}
		
		private function getSilverTexture(type : String) : Texture
		{
			var texture : Texture;
			
			if (_type == EnemyTypes.ENEMY_TYPE3) {
				texture = _gameElements.getTexture('enemy_type_3_silver');
			} else {
				throw new Error('Enemy Texture does not exist!');
			}
			
			return texture;
		}
		
		private function getBrownTexture(type : String) : Texture
		{
			var texture : Texture;
			
			switch(type) {
				case EnemyTypes.ENEMY_TYPE4 :
					texture = _gameElements.getTexture('enemy_type_4_brown');
					break;
					
				case EnemyTypes.ENEMY_TYPE5 :
					texture = _gameElements.getTexture('enemy_type_5_brown');
					break;
					
				default :
					throw new Error('Enemy Texture does not exist!');
					break;
			}
			
			return texture;
		}
		
		private function onRemovedFromStage(event : Event) : void
		{
			_shootTimer.stop();
			_shootTimer.removeEventListener(TimerEvent.TIMER, onShootTimer);
			_shootTimer = null;
		}

		private function onAddedToStage(event : Event) : void
		{
			init();
		}
	}
}
