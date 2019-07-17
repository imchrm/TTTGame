package com.chrm.lab.tttg.view
{
	import com.chrm.ioc.astra.view.ContextView;
	import com.chrm.lab.tttg.App;
	import com.chrm.lab.tttg.Constants;
	import com.chrm.lab.tttg.util.GUIDrawUtil;
	
	import flash.geom.Point;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	
	public class Game extends ContextView
	{
		private static const log:ILogger = getLogger( Game );
		
		public var tiles:Vector.<Button>;
		public var infoTF:TextField;
		public var backBut:Button;
		public var isFireMoveEvent:Boolean;
		
		public function Game()
		{
			super();
			
			log.debug("Game constructed!");
		}
		/** ------------------------------------------------
		 * 					P R I V A T E S
		 ------------------------------------------------ */
		private function createTilesField(val0:DisplayObjectContainer, val1:Vector.<Button>):void
		{
			var k:int = 3;
			var indent:int = Constants.TILE_INDENT;
			var tileS:int = Constants.TILE_SIZE;
			var mrgLeft:int = (Constants.FIXED_STAGE_WIDTH - k * tileS - indent * ( k - 1)) >> 1;
			var mrgTop:int = (Constants.FIXED_STAGE_HEIGHT - k * tileS - indent * ( k - 1)) >> 1;
			var c:int = 9;
			for(var i:int = 0; i < c; i++)
			{
				var xi:int = i % k;
				var yi:int = Math.floor( i / k );
				var dxi:int = xi * indent;
				var dyi:int = yi * indent;
//				var img:Image = this.addChild(new Image(App.assets.getTexture("tile_0"))) as Image;
				
				var txtrUp:Texture = App.assets.getTexture(Constants.TXTR_NAME + "_0");
				var txtrDown:Texture = App.assets.getTexture(Constants.TXTR_NAME + "_4");
				var txtrOver:Texture = App.assets.getTexture(Constants.TXTR_NAME + "_3");
				var but:Button = new Button(txtrUp, "", txtrDown, txtrOver);
				but.width = Constants.TILE_SIZE;
				but.height = Constants.TILE_SIZE;
				
				but.x = mrgLeft + (xi * tileS) + dxi;
				but.y = mrgTop + (yi * tileS) + dyi;
				// calculate x, y position 
				but.name = "tile_" + i.toString();
				
				val1.push( but );
				
				val0.addChild( but );
			}
			
		}
		private function createButtonBack(val0:DisplayObjectContainer):Button
		{
			var txtrUp:Texture = GUIDrawUtil.createButtonTexture();
			var txtrDown:Texture = GUIDrawUtil.createButtonTexture(false);
			
			return GUIDrawUtil.createSimpleStarlingButton("Back", txtrUp, txtrDown);
		}
		private function createInfoTF(val:DisplayObjectContainer):void
		{
			var textFieldHeight:int = 60;
			var mrgTop:int = 20;
			
			infoTF = new TextField( Constants.FIXED_STAGE_WIDTH, textFieldHeight, "" );
			infoTF.format = new TextFormat("Ubuntu", 16, 0xffffff)
			infoTF.x = 0;
			infoTF.y = mrgTop;
			infoTF.wordWrap = true;
//			infoTF.border = true;
//			infoTF.text = "Hello brother, how are you doing?\nHey man, what the fuck?"
			val.addChild(infoTF);
		}
		
		private function getTileName(val:int):String
		{
			return "tile_" + val.toString();
		}
		private function setTTPosition(val:int, val1:Boolean=true):void
		{
			var s:String;
			if(val1)
				s = Constants.TXTR_NAME + "_1";
			else
				s = Constants.TXTR_NAME + "_2";
			var tileName:String = getTileName(val);
			var doc:DisplayObject = this.getChildByName( tileName );
			var img:Image = new Image(App.assets.getTexture( s ));
			img.x = doc.x;
			img.y = doc.y;
			this.removeChild( doc );
			this.addChild( img );
		}
		/** ------------------------------------------------
		 * 					L I F E
		 ------------------------------------------------ */
		override protected function initialize():void
		{
			tiles = new <Button>[];
		}
		override protected function draw():void
		{
			createInfoTF(this);
			createTilesField(this, tiles);
			backBut = createButtonBack(this);
			
			backBut.pivotX = backBut.width >> 1;
			backBut.pivotY = backBut.height >> 1;
			
			backBut.x = Constants.FIXED_STAGE_WIDTH >> 1;
			backBut.y = Constants.FIXED_STAGE_HEIGHT - backBut.height - 20;
			
			this.addChild( backBut );
		}
		override public function dispose():void
		{
			;
		}
		/** ------------------------------------------------
		 * 					P U B L I C S
		 ------------------------------------------------ */
		/**
		 * Set Tic 'X' in Position
		 * 
		 * @param val - is serial number of Position [0:8]
		 */
		public function setTicPosition(val:int):void
		{
			setTTPosition(val, true);
		}
		
		/**
		 * Set Tac 'O' in Position
		 * 
		 * @param val - is serial number of Position [0:8]
		 */
		public function setTacPosition(val:int):void
		{
			setTTPosition(val, false);
		}

	}
}