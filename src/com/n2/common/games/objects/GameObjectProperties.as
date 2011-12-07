package com.n2.common.games.objects {
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameObjectProperties extends Actor {
		//TODO: Check if definition property is needed, if not remove
		private var _properties:Object;
		
		public function GameObjectProperties(desc:Object = null){
			parseDescriptor(desc);
		}
		
		private function parseDescriptor(desc:Object):void {
			_properties = createObject(desc);
		}
		
		private function createObject(obj:Object):Object {
			var gameObject:Object = {};
			var objID:String = obj.id;
			var objName:String = obj.name;
			gameObject.id = objID;
			gameObject.name = objName;
			
			for (var s:String in obj){
				var property:*;
				trace("item.type: " + s);
				if (s == "category"){
					//property = createObject(prop);
				} else {
					//property = createProperty(prop, gameObject);
				}
				//gameObject[prop.attribute("id")] = property;
			}
			//
			return gameObject;
		}
		
		private function createProperty(prop:XML, obj:Object):* {
			var property:Object = {};
			var propType:String = prop.attribute("type");
			property.id = prop.attribute("id");
			property.name = prop.attribute("name");
			property.type = propType;
			
			switch (propType){
				case "string": 
					break;
				case "number": 
					property.minValue = prop.attribute("minValue");
					property.maxValue = prop.attribute("maxValue");
					break;
				case "shape": 
				case "gameObject": 
					property.index = prop.attribute("index");
					break;
				default: 
					break;
			}
			
			return property;
		}
		
		public function getPropertyByID(id:String):*{
			//TODO: Split id by "." to get proper property
			return null;
		}
	}

}