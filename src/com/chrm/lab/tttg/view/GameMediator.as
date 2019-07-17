package com.chrm.lab.tttg.view
{
	import com.chrm.ioc.astra.mediator.Mediator;
	import com.chrm.lab.tttg.event.AppEvent;
	import com.chrm.lab.tttg.event.GameEvent;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class GameMediator extends Mediator
	{
		private static const log:ILogger = getLogger( GameMediator );
		
		private var _vGame:Game;
		
		private var _isMoveAllowed:Boolean = false;
		
		public function GameMediator()
		{
			super();
		}
		
		/** ------------------------------------------------
		 * 					L I F E
		 ------------------------------------------------ */
		override public function initialize():void
		{
			log.debug("initialize");
			_vGame = view as Game;
			
			addTilesListeners(_vGame);
			_vGame.backBut.addEventListener(Event.TRIGGERED, backBut_TRIGGERED);
			
			addContextListener( GameEvent.INIT_GAME_EPLG, context_INIT_GAME_EPLG);
			addContextListener( GameEvent.AI_MOVED_TO, context_AI_MOVED_TO);
			addContextListener( GameEvent.GAME_HUMAN_WIN, context_GAME_HUMAN_WIN);
			addContextListener( GameEvent.GAME_AI_WIN, context_GAME_AI_WIN);
			addContextListener( GameEvent.GAME_END, context_GAME_END);
			
//			Init GameModel and Who to do first move
			dispatchEvent( new GameEvent( GameEvent.INIT_GAME_PRLG ) );
		}
		
		private function context_GAME_HUMAN_WIN(evt:GameEvent):void
		{
			var p:Vector.<int> = evt.data as Vector.<int>;
			
		}
		private function context_GAME_AI_WIN(evt:GameEvent):void
		{
			var p:Vector.<int> = evt.data as Vector.<int>;
		}
		
		override public function dispose():void
		{
			log.debug("dispose");
			_vGame.backBut.removeEventListeners(Event.TRIGGERED);
			var c:int = _vGame.tiles.length;
			for(var i:int = 0; i < c; i++)
			{
				_vGame.tiles[i].removeEventListeners(Event.TRIGGERED);
			}
			_vGame = null;
		}
		/** ------------------------------------------------
		 * 					H A N D L E R S
		    ------------------------------------------------ */
		private function context_GAME_END(evt:GameEvent):void
		{
			endGame(evt.data as String);
		}
		private function context_INIT_GAME_EPLG(evt:GameEvent):void
		{
			log.debug("INIT_GAME_EPLG");
			var f:int = evt.data as int;
			makeFirstMove( f )
		}
		
		private function context_AI_MOVED_TO(evt:GameEvent):void
		{
			log.debug("SET_TILE_EPLG data:{0}", [evt.data]);
			var n:int = evt.data as int;
			moveAITo( n );
		}
		
		private function backBut_TRIGGERED(evt:Event):void
		{
			dispatchEvent( new AppEvent(AppEvent.GAME_EXIT) );
		}
		
		private function tile_TRIGGERED(evt:Event):void
		{
			if(_isMoveAllowed)
			{
				var doc:DisplayObject = evt.currentTarget as DisplayObject;
				log.debug("Tile TRIGGERED name:{0}",[doc.name]);
				moveHumanTo( int(doc.name.split("_")[1]) );
			}
		}
		/** ------------------------------------------------
		 * 					P R I V A T E S
		 ------------------------------------------------ */
		private function moveHumanTo(val:int):void
		{
			_vGame.setTicPosition( val );
			if(_isMoveAllowed)
				_isMoveAllowed = false;
			fireHumanMovedTo( val );
		}
		private function moveAITo(val:int):void
		{
			if(!_isMoveAllowed)
				_isMoveAllowed = true;
			showYourMoveInfo();
			_vGame.setTacPosition( val );
		}
		private function endGame(val:String):void
		{
			showInfo( val );
			_isMoveAllowed = false
		}
		private function makeFirstMove(val:int):void
		{
			if(val == 0)
				fireHumanMovedTo( -1 )// first move for Computer. Look GameModel comment
			else
			{
				showYourMoveInfo();
				if(!_isMoveAllowed)
					_isMoveAllowed = true;
			}
		}
		private function showYourMoveInfo():void
		{
			showInfo("Your move!");
		}
		private function showInfo(val:String):void
		{
			_vGame.infoTF.text = val;
		}
		private function addTilesListeners(val:Game):void
		{
			var c:int = val.tiles.length;
			for(var i:int = 0; i < c; i++)
			{
				var but:Button = val.tiles[i];
				//				log.debug("name:{0}",[but.name]);
				but.addEventListener(Event.TRIGGERED, tile_TRIGGERED);
			}
		}
		private function fireHumanMovedTo(val:int=-1):void
		{
			dispatchEvent( new GameEvent(GameEvent.HUMAN_MOVED_TO, false, val) );
		}

		
		
	}
}