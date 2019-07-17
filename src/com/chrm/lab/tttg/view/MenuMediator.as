package com.chrm.lab.tttg.view
{
	import com.chrm.ioc.astra.mediator.Mediator;
	import com.chrm.lab.tttg.Constants;
	import com.chrm.lab.tttg.event.AppEvent;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	import starling.display.Button;
	import starling.events.Event;
	
	public class MenuMediator extends Mediator
	{
		private static const log:ILogger = getLogger( MenuMediator );
		
		private var _vMenu:Menu;
		
		
		public function MenuMediator()
		{
			super();
		}
		override public function initialize():void
		{
			log.debug("initialize");
			
			_vMenu = view as Menu;
			
			addButtonsListeners();
		}
		
		private function addButtonsListeners():void
		{
			var c:int = _vMenu.menuButs.length;
			for(var i:int = 0; i < c; i++)
			{
				_vMenu.menuButs[i].addEventListener(Event.TRIGGERED, menuBut_TRIGGERED);
			}
		}		
		
		protected function menuBut_TRIGGERED(evt:Event):void
		{
			var b:Button = evt.currentTarget as Button;
			if(b.name == Constants.MENU_BUT_LABELS[0])
			{
				dispatchEvent( new AppEvent(AppEvent.START_GAME) );
			}
			else
			{
//				blah-blah
			}
		}
		override public function dispose():void
		{
			log.debug("dispose");
			for(var i:int = 0; i < _vMenu.menuButs.length; i++)
			{
				_vMenu.menuButs[i].removeEventListener(Event.TRIGGERED, menuBut_TRIGGERED);
			}
			_vMenu = null;
		}
	}
}