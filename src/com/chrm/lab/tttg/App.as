package com.chrm.lab.tttg
{
	import com.chrm.ioc.astra.IStarlingDispalyContext;
	import com.chrm.lab.tttg.test.TTest;
	import com.chrm.lab.tttg.view.Root;
	import com.chrm.preloader.ProgressBar;
	
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.utils.setTimeout;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.LOGGER_FACTORY;
	import org.as3commons.logging.api.getLogger;
	import org.as3commons.logging.setup.SimpleTargetSetup;
	import org.as3commons.logging.setup.target.TraceTarget;
	import org.as3commons.logging.util.SWFInfo;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.StringUtil;
	import starling.utils.SystemUtil;
	
	public class App implements INativeStageable
	{
		private static const log: ILogger = getLogger( App );
		
//		flash display Stage
		private var _nativeStage:Stage;
		private var _starling:Starling;
		private var _progressBar:ProgressBar;
		
		public static var scaleFactor:int;
		public static var assets:AssetManager;
		
		public function App()
		{
//			TODO Create universal Application super class
		}
				
		private function init():void
		{
			SWFInfo.init( this.nativeStage );
//			LOGGER_FACTORY.setup = new SimpleTargetSetup( new SOSTarget("{time} {logLevel} - {name} - {message}", 
//				new SOSGateway("192.168.1.168")) );
			LOGGER_FACTORY.setup = new SimpleTargetSetup( 
				new TraceTarget( "{time} {logLevel} - {shortName} - {message}") );
			
			var tt:TTest = new TTest();
			
			
//			stage.color = 0x000000;
			
//			TODO Incapsulate into ScreeConfig class (aspect, optimal resolution etc.)
			
//			Develop the game in a *fixed* coordinate system of 320x480. The game might
//			then run on a device with a different resolution; for that case, we zoom the
//			viewPort to the optimal size for any display and load the optimal textures.
			
			var stageSize:Rectangle  = new Rectangle(0, 0, Constants.FIXED_STAGE_WIDTH, Constants.FIXED_STAGE_HEIGHT);
			var screenSize:Rectangle = new Rectangle(0, 0, nativeStage.fullScreenWidth, nativeStage.fullScreenHeight);
			var viewPort:Rectangle = RectangleUtil.fit(stageSize, screenSize, ScaleMode.SHOW_ALL);
			App.scaleFactor = viewPort.width < Constants.FIXED_STAGE_HEIGHT ? 1 : 2; // midway between 320 and 640
			
//			TODO Incapsulate into StarlingConfig class
			
			Starling.multitouchEnabled = true; // useful on mobile devices
			
			_starling = new Starling(Root, nativeStage, viewPort, null, "auto", "auto");
			_starling.stage.stageWidth    = Constants.FIXED_STAGE_WIDTH;  // <- same size on all devices!
			_starling.stage.stageHeight   = Constants.FIXED_STAGE_HEIGHT; // <- same size on all devices!
			_starling.enableErrorChecking = Capabilities.isDebugger;
			
			_starling.addEventListener(Event.ROOT_CREATED, starling_ROOT_CREATED);
			
			_starling.start();
			initProgressBar();
		}
		
		private function initProgressBar():void
		{
			_progressBar = new ProgressBar(175, 20);
			_progressBar.x = (Constants.FIXED_STAGE_WIDTH - _progressBar.width) >> 1;
			_progressBar.y =  (Constants.FIXED_STAGE_HEIGHT - _progressBar.height) >> 1;
			_starling.nativeOverlay.addChild(_progressBar);
			// Prevent from to show the progress bar in original (no scale) size. Starling error.
			_progressBar.visible = false;
			nativeStage.addEventListener( flash.events.Event.ENTER_FRAME, function(evt:flash.events.Event):void
			{
				(evt.currentTarget as IEventDispatcher).removeEventListener( evt.type, arguments.callee);
				// show Progress bar in scaled size
				_progressBar.visible = true;
				// Remove TTTGame progress bar
				TTTGame.progressBar.parent.removeChild( TTTGame.progressBar );
				TTTGame.progressBar = null;
			})
		}
		
		protected function starling_ROOT_CREATED(evt:Event):void
		{
			(evt.currentTarget as EventDispatcher).removeEventListener( evt.type, arguments.callee );
			
//			createAppContext(Starling.current.root as DisplayObjectContainer);
			
			loadAssets(scaleFactor, onCreateAppContext);
		}
		
		private function loadAssets(scaleFactor:int, onComplete:Function):void
		{
			var appDir:File = File.applicationDirectory;
			var assets:AssetManager = new AssetManager(scaleFactor);
			
			assets.verbose = Capabilities.isDebugger;
			assets.enqueue(
				appDir.resolvePath(StringUtil.format("fonts/{0}x",    scaleFactor)),
				appDir.resolvePath(StringUtil.format("textures/{0}x", scaleFactor))
			);
			
			assets.loadQueue(function(ratio:Number):void
			{
				// filling only second a half of progress bar
				_progressBar.ratio = 0.5 + ratio * 0.5;
				if (ratio == 1)
				{
					onComplete(assets);
				}
			});
		}
		private function onCreateAppContext(assets:AssetManager):void
		{
			App.assets = assets;
			createAppContext(Starling.current.root as DisplayObjectContainer);
			
			// now would be a good time for a clean-up
			System.pauseForGCIfCollectionImminent(0);
			System.gc();
			
			setTimeout(removeElements, 150); // delay to make 100% sure there's no flickering.
		}
		
		private function removeElements():void
		{
			if (_progressBar)
			{
				_starling.nativeOverlay.removeChild(_progressBar);
				_progressBar = null;
			}
		}
		private function createAppContext(val:DisplayObjectContainer):void
		{
			var context:IStarlingDispalyContext = new AppContext();
			context.contextView =  val;
		}
		
		
		
		/**
		 * 
		 * 		Flash display Stage
		 * 
		 */
//		
		public function set nativeStage(val:Stage):void
		{
			if(val)
			{
				_nativeStage = val;
				init();
			}
		}
		public function get nativeStage():Stage
		{
			return _nativeStage;
		}
	}
}