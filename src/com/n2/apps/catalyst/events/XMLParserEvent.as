package com.n2.apps.catalyst.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class XMLParserEvent extends Event {
		public static const OBJECT_DEFINITIONS_PARSED:String = "objectDefinitionsParsed";
		public static const ASSETS_DESCRIPTOR_PARSED:String = "assetsDescriptorParsed";
		
		private var _value:*;
		
		public function XMLParserEvent(type:String, val:*){
			super(type);
			_value = val;
		}
		
		public function get value():* {
			return _value;
		}
	
	}

}