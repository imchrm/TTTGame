package com.chrm.lab.tttg
{
	import starling.errors.AbstractClassError;

	public class Constants
	{
		public function Constants()
		{
			throw new AbstractClassError();
		}
		
		public static const FIXED_STAGE_WIDTH:int  = 320;
		public static const FIXED_STAGE_HEIGHT:int = 480;
		
		public static const MENU_BUT_LABELS:Vector.<String> = new <String>["Play"];
		public static const MENU_BUT_WIDTH:int = 128;
		public static const MENU_BUT_HEIGHT:int = 32;

//		Name of Texture in ttt.xml atlas
		public static const TXTR_NAME:String = "txtr";
		
		public static const TILE_INDENT:int = 4;
		public static const TILE_SIZE:int = 100;
	}
}