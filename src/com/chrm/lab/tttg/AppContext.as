package com.chrm.lab.tttg
{
	import com.chrm.ioc.astra.StarlingContext;
	import com.chrm.lab.tttg.controller.InitGameCmd;
	import com.chrm.lab.tttg.controller.GetNextStupidMoveCmd;
	import com.chrm.lab.tttg.event.GameEvent;
	import com.chrm.lab.tttg.view.Game;
	import com.chrm.lab.tttg.view.GameMediator;
	import com.chrm.lab.tttg.view.Menu;
	import com.chrm.lab.tttg.view.MenuMediator;
	import com.chrm.lab.tttg.view.Root;
	import com.chrm.lab.tttg.view.RootMediator;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;

	
	public class AppContext extends StarlingContext
	{
		private static const log:ILogger = getLogger( AppContext );
		
		public function AppContext()
		{
			super();
		}
		override protected function initialize():void
		{
			log.debug( "initialize" );
			
			mapMediator(Root, RootMediator);
			mapMediator(Menu, MenuMediator);
			mapMediator(Game, GameMediator);
			
			mapCommand(GameEvent.INIT_GAME_PRLG, GameEvent, InitGameCmd);
			mapCommand(GameEvent.HUMAN_MOVED_TO, GameEvent, GetNextStupidMoveCmd);
			
			afterInitialize();
		}
		
		private function afterInitialize():void
		{
//			contextView.addChild( new Menu());
		}
		
	}
}