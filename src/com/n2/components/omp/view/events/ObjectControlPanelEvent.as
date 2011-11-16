package com.n2.components.omp.view.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ObjectControlPanelEvent extends Event {
		//Event types
		public static var UPDATE_OBJECT_PARAMETERS:String = "Event_UpdateObjectParameters";
		
		//Transformation types
		public static var TRANSFORM_OBJECT_POSITION:String = "Position";
		public static var TRANSFORM_OBJECT_ROTATION:String = "Rotation";
		public static var TRANSFORM_OBJECT_SCALE:String = "Scale";
		
		//Event properties
		private var _targetProperty:String;
		private var _transformType:String;
		private var _targetValue:Number;
		
		public function ObjectControlPanelEvent(type:String, tp:String = null, tv:Number = 0, tt:String = null){
			super(type);
			_targetProperty = tp;
			_targetValue = tv;
			_transformType = tt;
		}
		
		public function get targetValue():Number {
			return _targetValue;
		}
		
		public function get targetProperty():String {
			return _targetProperty;
		}
		
		public function get transformType():String {
			return _transformType;
		}
	
	}

}