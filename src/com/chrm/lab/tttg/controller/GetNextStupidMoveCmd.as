package com.chrm.lab.tttg.controller
{
	import com.chrm.ioc.astra.controller.Cmd;
	import com.chrm.lab.tttg.event.GameEvent;
	import com.chrm.lab.tttg.model.GameModel;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	import starling.events.EventDispatcher;
	
	public class GetNextStupidMoveCmd extends Cmd
	{
		private static const log:ILogger = getLogger( GetNextStupidMoveCmd );
		
		public function GetNextStupidMoveCmd(val0:EventDispatcher)
		{
			super(val0);
		}
		override public function execute(...param):void
		{
			
//			TODO Optimize game move code!!!
			log.debug( "\nHuman move to:{0}",[event.data] );
			
			var gfs:Vector.<int> = GameModel.$().gameFields;
			
//			Set Human move
			var pos:int = event.data as int;
//			Is first move do Human?
			if(pos != -1)
				gfs[pos] = 1;// Human moves
			
			var p:Vector.<int> = findLineVector( 1 );// find human lines
			if( p )
			{
				dispatchEvent( new GameEvent(GameEvent.GAME_HUMAN_WIN, false, p));
				dispatchEvent( new GameEvent(GameEvent.GAME_END, false, "Congrats! You win!"));
				return;
			}
			
//			Find empty fields
			var emptyFieldNums:Vector.<int> = new <int>[];
			var c:int = gfs.length;
			for(var i:int = 0; i < c; i++)
			{
				if(gfs[i] == 0)
					emptyFieldNums.push( i );
			}
			
			var mes:String;
//			remaining fields\tiles
			var rm:int = emptyFieldNums.length;
			if(rm == 0)
			{
				mes = "Who win?";
				dispatchEvent( new GameEvent(GameEvent.GAME_END, false, mes));
			}
			else
			{
				var pr:int = findPairMove( gfs, 2 );// find empty pair position for AI
				if( pr == -1 )
				{
					pr = findPairMove( gfs, 1 );// find empty pair position for Human
					if( pr == -1 )
					{
//						AI Move
						var n:int = Math.round( Math.random() * (rm - 1) );
//						AI position
						pr = emptyFieldNums[n];
					}
				}
					
				log.debug("AI move to:{0} {1}",[pr]);
				
				pos = pr;
				
				gfs[pos] = 2;
				
				p = findLineVector( 2 );// find computer lines
				
				dispatchEvent( new GameEvent(GameEvent.AI_MOVED_TO, false, pos));
				if(p)
				{
					dispatchEvent( new GameEvent(GameEvent.GAME_AI_WIN, false, p));
					dispatchEvent( new GameEvent(GameEvent.GAME_END, false, "You loser!\nBua-ha-ha!"));
					return;
				}
				
//				Is last move?
				if(rm == 1)
				{
					mes = "Who win?";
					dispatchEvent( new GameEvent(GameEvent.GAME_END, false, mes));
				}
			}
		}
//		Find line Vector
//		val is type of setted field 1 - X, 2 - O;
		private function findLineVector(val:int):Vector.<int>
		{
			var r:Vector.<int>;
			var f:Vector.<int> = GameModel.$().gameFields;
			
			var l:Vector.<Vector.<int>> = GameModel.$().lines;
			var c:int = l.length;
			for(var i:int = 0; i < c; i++)
			{
				var p:Vector.<int> = l[i];
				var isLine:Boolean = true;
				var k:int = p.length;
				for(var j:int = 0; j < k; j++)
				{
					
					isLine = isLine && ( f[p[j]] == val );
					if(!isLine)
						break;// next line
				}
				if(isLine)
				{
					r = p;
					break;// line finded
				}
			}
			return r;
		}
		
//		Find Pair Move
//		val is type of finded pair, field 1 - X, 2 - O;
		private function findPairMove(val0:Vector.<int>, val:int):int
		{
			var r:int = -1;
			var f:Vector.<int> = val0;
			
			var l:Vector.<Vector.<int>> = GameModel.$().lines;
			var c:int = l.length;
			for(var i:int = 0; i < c; i++)
			{
				var p:Vector.<int> = l[i];
				var pr:int = -1;
				var sum:int = 0;
				var k:int = p.length;
				for(var j:int = 0; j < k; j++)
				{
					var fNum:int = p[j];
					if(f[fNum] == 0)
					{
						if(pr == -1)
						{
							pr = fNum;// set move position
						}
						else
						{
							pr = -1;
							break;
						}
					}
					sum += f[p[j]];
				}
				if( sum == 2 && val == 1 && pr != -1)
				{
					r = pr;
					break;// pair finded
				}
				else if(sum == 4 && val == 2 && pr != -1)
				{
					r = pr;
					break;// pair finded
				}
			}
			
			return r;
		}
	}
}