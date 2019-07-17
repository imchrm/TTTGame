package
{
	import com.chrm.lab.tttg.INativeStageable;
	import com.chrm.preloader.Preloader;
	import com.chrm.preloader.ProgressBar;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	/**
	 *  This is two-framed application (Flex style).
	 * 
	 *  A simple and light 'first main' TTTGame class with Preloader and ProgressBar will compile into first (lightweight) frame.
	 *  This class doesn't contain app logic, libs, assets, datas, embedings etc. just preloader for them.
	 * 
	 *  For building two-framed app you must add compiler instruction:'-frame appFrame com.chrm.lab.tttg.App'. Enjoy.
	 *  com.chrm.lab.tttg.App - is 'second main' class for second heavyweight application frame with all realisation.
	 * 
	 *  Very usefull for Web and Mobile buildings.
	 * 
	 * 	@author chrm
	 */
	
	[SWF(width="320", height="480", frameRate="30", backgroundColor="#471700")]
	
	public class TTTGame extends Preloader
	{
//		String name of 'second aka App main' Class of Application with all imports, embedings etc. see on top.
		private static const APP_CLASS_NAME:String = "com.chrm.lab.tttg.App";
		
		static public var progressBar:ProgressBar;
		
		public function TTTGame()
		{
			super();
			
			if(!stage)
				addEventListener(Event.ADDED_TO_STAGE, this_ADDED_TO_STAGE);
			else
				init();
		}
		protected function this_ADDED_TO_STAGE(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, this_ADDED_TO_STAGE);
			init();
		}
		private function init():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
//			TODO create AspectScreenUtil class
//			Positionig and scale Progress Bar as like Starling. Look comments in App class.
//			*Fixed* coordinate system of 320x480. Look comments in App class.
			const fW:int = 320;
			const fH:int = 480;
			var sW:int = stage.fullScreenWidth;
			var sH:int = stage.fullScreenHeight;
//			display aspect
			var dspAsp:Number = sW / sH;
//			fixed aspect
			var fxAsp:Number = fW / fH;

			var k:Number = 0;//	fitted coefficient
			var fsW:int = sW;// fitted width
			var fsH:int = sH;// fitted height
			var mrg:int;// fitted screen margin top or left
			if(dspAsp < fxAsp)
			{
//				fit by width
				k = sW / fW;
				fsH = fH * k;
				mrg = (sH - fsH) >> 1;
			}
			else
			{
//				fit by height
				k = sH / fH;
				fsW = fW * k;
				mrg = (sW - fsW) >> 1;
			}
			const pbW:int = 175;
			const pbH:int = 20;
			var pbWidth:int = fsW / fW * pbW;
			var pbHeight:int = fsH / fH * pbH;
			progressBar = new ProgressBar(pbWidth, pbHeight);
//			center
			progressBar.x = (sW - pbWidth) >> 1;
			progressBar.y = (sH - pbHeight) >> 1;
			this.addChild(progressBar);
			
			start();
		}
		
		override protected function updateProgress(val:Number):void
		{
			// filling only first a half of progress bar, a second half might then fill in App when load assets
			progressBar.ratio = val * 0.5;
		}
		override protected function complete():void
		{
			super.complete();
			
			dispose();
			
			addAppClassByNameToStage(APP_CLASS_NAME);
		}
		
		private function dispose():void
		{
			progressBar.ratio = 0.5;
//			Removed in App
//			this.removeChild( progressBar );
//			progressBar = null;
		}
		
		public function addAppClassByNameToStage( val:String ):void
		{
			var MainClass:Class = getDefinitionByName(val) as Class;
			
			if (MainClass == null)
				throw new Error("There is not [" + val + "] class!");
			
//			If Main Class is Sprite or MovieClip
//			var main:DisplayObject = new MainClass() as DisplayObject;
			
//			For best practice App Main implements IStageable interface
			var main:INativeStageable = new MainClass() as INativeStageable;
			if (main == null)
				throw new Error("The [" + val + "] class must be a INativeStageable!");
//				throw new Error("The [" + val + "] class must be a Sprite or MovieClip!");
			
//			If Main Class is Sprite or MovieClip
//			this.addChild(main);
			
//			Because Main App Class is not extends any Display List Class just add flash display stage
			main.nativeStage = stage;
		}
	}
}