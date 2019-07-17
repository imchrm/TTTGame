package com.chrm.lab.tttg.model
{
	public class GameModel
	{
		private static var _instance:GameModel;
		
		
		public function GameModel(val:SingletonPreventer)
		{
			if(val == null)
				throw new Error ("Model is a singleton class, use 'Model.$()' instead");
		}

		public static function _():void
		{

		}
		public static function $():GameModel
		{
			if ( _instance == null )
				_instance = new GameModel( new SingletonPreventer() );
			return _instance;
		}
		
		public function setTTMove(val0:int, val1:int):void
		{
			gameFields[val0] = val1;
		}
		
		public function initialize():void
		{
			gameFields = new <int>[0,0,0, 0,0,0, 0,0,0];// 0 - field is empty
			
			lines = new <Vector.<int>>[];
			lines.push(new <int>[0,1,2]);
			lines.push(new <int>[0,3,6]);
			lines.push(new <int>[6,7,8]);
			lines.push(new <int>[2,5,8]);
			lines.push(new <int>[3,4,5]);
			lines.push(new <int>[1,4,7]);
			lines.push(new <int>[0,4,8]);
			lines.push(new <int>[2,4,6]);
		}
		
		public var lines:Vector.<Vector.<int>>;
		
		public var currentHumanFieldType:int;// 1 - is tic 'X', 2 - is tac 'O' 
		
		/**
		 * Who first moved: if 0 - first move do computer, 1 - human
		 */
		public var first:int;
		
		public var gameFields:Vector.<int>;
		
		public function setTicMove(val:int):void
		{
			setTTMove(val, 1);
		}
		public function setTacMove(val:int):void
		{
			setTTMove(val, 2);
		}
		/**
		 * Set in serial position unit tic 'X' 1 or tac 'O' 2
		 * 
		 * @param val0 - serial position
		 * @param val1 - type of unit
		 */
		public function setGameField(val0:int, val1:int):void
		{
			gameFields[val0] = val1;
		}
	}
}
final class SingletonPreventer{}