package com.chrm.lab.tttg.view
{
	import com.chrm.ioc.astra.view.ContextView;
	import com.chrm.lab.tttg.Constants;
	import com.chrm.lab.tttg.util.GUIDrawUtil;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	
	public class Menu extends ContextView
	{
		private static const log:ILogger = getLogger( Menu );
		
		public var menuButs:Vector.<Button>;
		
		public function Menu()
		{
			super();
			
			log.debug("Menu constructed!");
		}
		
		private function createMenu(val:DisplayObjectContainer):void
		{
//			TODO Create more buttons
			
			var dx:int = Constants.FIXED_STAGE_WIDTH >> 1;
			var dy:int = Constants.FIXED_STAGE_HEIGHT >> 1;
			var txtrUp:Texture = GUIDrawUtil.createButtonTexture();
			var txtrDown:Texture = GUIDrawUtil.createButtonTexture(false);
			var menuBut:Button;
			var lb:String = Constants.MENU_BUT_LABELS[0];
			menuBut = GUIDrawUtil.createSimpleStarlingButton(lb, txtrUp, txtrDown);
			
			menuBut.name = lb;
			
			menuBut.pivotX = menuBut.width >> 1;
			menuBut.pivotY = menuBut.height >> 1;
			menuBut.x = dx;
			menuBut.y = dy;
			
			menuButs.push( menuBut );
			
			val.addChild( menuBut );
		}
//		Initialize properties here
		override protected function initialize():void
		{
			menuButs = new <Button>[];
		}
//		Draw and Create children here, commit properties, measure and layout
		override protected function draw():void
		{
			var textField:TextField = new TextField(250, 50, "Tic-Tac Toe");
			textField.format = new TextFormat("Desyrel", BitmapFont.NATIVE_SIZE, 0xffffff);
			textField.x = (Constants.FIXED_STAGE_WIDTH - textField.width) / 2;
			textField.y = 50;
			this.addChild(textField);
			
			createMenu(this);
		}
		override public function dispose():void
		{
			menuButs = null;
		}
	}
}