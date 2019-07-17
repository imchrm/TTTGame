package com.chrm.lab.tttg.event
{
	import starling.events.Event;
	
	public class GameEvent extends Event
	{
		public static const INIT_GAME_PRLG:String = "INIT_GAME_PRLG";// Prolog Event to Context
		public static const INIT_GAME_EPLG:String = "INIT_GAME_EPLG";// Epilog Event from Context
		
		public static const HUMAN_MOVED_TO:String = "HUMAN_MOVED_TO";
		public static const AI_MOVED_TO:String = "AI_MOVED_TO";
		
		public static const GAME_HUMAN_WIN:String = "GAME_HUMAN_WIN";
		public static const GAME_AI_WIN:String = "GAME_AI_WIN";
		public static const GAME_END:String = "GAME_END";
		
		public function GameEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}