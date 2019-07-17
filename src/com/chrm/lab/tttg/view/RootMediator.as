package com.chrm.lab.tttg.view
{
	import com.chrm.ioc.astra.mediator.Mediator;
	import com.chrm.lab.tttg.event.AppEvent;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	
	public class RootMediator extends Mediator
	{
		private static const log:ILogger = getLogger( RootMediator );
		
		private var _activeScene:Sprite;
		private var _vRoot:Root;
		
		public function RootMediator()
		{
			super();
		}
		override public function initialize():void
		{
			log.debug("initialize");
			_vRoot = view as Root;
			
			addContextListener( AppEvent.START_GAME, context_START_GAME);
			addContextListener( AppEvent.GAME_OVER, context_GAME_OVER);
			addContextListener( AppEvent.GAME_EXIT, context_GAME_EXIT);
			
			showSceene(Menu);
		}
		
		private function context_GAME_EXIT(evt:AppEvent):void
		{
			log.debug("context_GAME_EXIT");
			showSceene(Menu);
		}
		
		private function context_GAME_OVER(evt:AppEvent):void
		{
			log.debug("context_GAME_OVER");
			showSceene(Menu);
		}
		
		private function context_START_GAME(evt:AppEvent):void
		{
			log.debug("context_START_GAME");
			showSceene(Game);
		}
		
		private function showSceene(val:Class):void
		{
			if(_activeScene)
				_activeScene.removeFromParent(true);
			_activeScene = new val();
			_vRoot.addChild( _activeScene );
		}
		
		override public function dispose():void
		{
			log.debug("dispose");
		}
		
		
	}
}