package com.n2.apps.catalyst.events {
	import com.n2.apps.catalyst.model.GameCatalystModel;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ContextEventGC extends Event {
		
		public function ContextEventGC(type:String){
			super(type);
		}
		
		override public function clone():Event {
			return new ContextEventGC(type);
		}
	}

}