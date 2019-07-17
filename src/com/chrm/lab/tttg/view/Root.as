package com.chrm.lab.tttg.view
{
	import com.chrm.ioc.astra.view.ContextView;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	public class Root extends ContextView
	{
		private static const log:ILogger = getLogger( Root );
		
		public function Root()
		{
			super();
			
			log.debug("Root constructed!");
		}
		
//		TODO Why!?
		public function start():void
		{
			
		}
	}
}