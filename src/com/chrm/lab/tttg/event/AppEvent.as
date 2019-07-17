package com.chrm.lab.tttg.event
{
	import starling.events.Event;
	
	public class AppEvent extends Event
	{
		public static const START_GAME:String = "START_GAME";
		
		public static const GAME_OVER:String = "GAME_OVER";
		
		public static const GAME_EXIT:String = "GAME_EXIT";
		
		public function AppEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}