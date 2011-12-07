package com.n2.common.games.events {
	import com.n2.common.games.objects.GameObjectProperties;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameObjectEvent extends Event {
		public static const INITIALIZE_GOP:String = "initializeGop";
		private var _gop:GameObjectProperties;
		
		/**
		 * 
		 * @param	type - Event type
		 * @param	gop - Game object properties
		 */
		public function GameObjectEvent(type:String, gop:GameObjectProperties){
			super(type);
		}
		
		/**
		 * Returns game object properties
		 */
		public function get gop():GameObjectProperties {
			return _gop;
		}
	
	}

}