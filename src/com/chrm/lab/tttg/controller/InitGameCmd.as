package com.chrm.lab.tttg.controller
{
	import com.chrm.ioc.astra.controller.Cmd;
	import com.chrm.lab.tttg.event.GameEvent;
	import com.chrm.lab.tttg.model.GameModel;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	import starling.events.EventDispatcher;
	
	public class InitGameCmd extends Cmd
	{
		private static const log:ILogger = getLogger( InitGameCmd );
		
		public function InitGameCmd(val0:EventDispatcher)
		{
			super(val0);
		}
		override public function execute(...param):void
		{
			log.debug( "execute tile:{0}",[event.data] );
			
//			Who do first move 0 - computer, 1 - human
			var n:int = Math.round( Math.random() );
			
//			if(!GameModel.$().gameField)
			GameModel.$().initialize();
			GameModel.$().first = n;
			
			dispatchEvent( new GameEvent(GameEvent.INIT_GAME_EPLG, false, n));
		}
	}
}