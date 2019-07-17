package com.chrm.lab.tttg.controller
{
	import com.chrm.ioc.astra.controller.Cmd;
	import com.chrm.lab.tttg.event.GameEvent;
	import com.chrm.lab.tttg.model.GameModel;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	import starling.events.EventDispatcher;
	
	public class GetNextSmartMoveCmd extends Cmd
	{
		private static const log:ILogger = getLogger( GetNextSmartMoveCmd );
		
		public function GetNextSmartMoveCmd(val0:EventDispatcher)
		{
			super(val0);
			
		}
		override public function execute(...param):void
		{
			log.debug( "execute tile:{0}",[event.data] );
			
//			TODO Create Smart strategy mooves code ;)
		}
	}
}