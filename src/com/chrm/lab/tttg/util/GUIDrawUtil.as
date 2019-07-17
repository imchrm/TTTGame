package com.chrm.lab.tttg.util
{
	import com.chrm.lab.tttg.Constants;
	import com.chrm.starling.display.util.StarlingDisplayObjectConverter;
	
	import flash.display.Graphics;
	
	import starling.display.Button;
	import starling.textures.Texture;

	public class GUIDrawUtil
	{
//		TODO Create universal Class without dependence of App functional
		public function GUIDrawUtil()
		{
		}
		private static function drawFlashButtonSimpleSprite(isUp:Boolean=true, width:uint=128, height:uint=32):flash.display.Sprite
		{
			var dt:uint = 2;
			var ddt:uint = dt << 1;
			
			var fsprt:flash.display.Sprite = new flash.display.Sprite();
			var g:Graphics = fsprt.graphics;
			g.beginFill(0x000000);
			g.drawRect(0,0, width, height);
			g.endFill();
			g.beginFill(isUp ? 0xffab33 : 0x8d4300);
			g.drawRect(dt,dt, width - ddt, height - ddt);
			g.endFill();
			
			return fsprt;
		}
		public static function createSimpleStarlingButton(label:String, txtrUp:Texture, txtrDown:Texture):Button
		{
			var but:Button = new Button(txtrUp, label, txtrDown);
			but.textFormat.font = "Ubuntu";
			but.textFormat.color = 0xffffff;
			but.textFormat.size = 16;
			
			return but;
		}
		public static function createButtonTexture(isUp:Boolean=true):Texture
		{
			var fsprt:flash.display.Sprite = GUIDrawUtil.drawFlashButtonSimpleSprite(isUp, Constants.MENU_BUT_WIDTH, Constants.MENU_BUT_HEIGHT);
			var txtr:Texture = StarlingDisplayObjectConverter.convertFlashDisplayObjectToTexture( fsprt );
			
			return txtr;
		}
	}
}