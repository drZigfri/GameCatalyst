package com.n2.apps.catalyst.control {
	import com.n2.apps.catalyst.events.XMLParserEvent;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import com.n2.apps.catalyst.model.services.loader.ComponentLoader;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ParseGameObjectsDefinitionsCommand extends Command {
		[Inject]
		public var loader:ComponentLoader;
		[Inject]
		public var model:IGameCatalystModel;
		
		override public function execute():void {
			var gopXML:XML = new XML(loader.getLoadedObjectByID("game_objects_prototypes"));
			var oList:XMLList = gopXML.child("objects");
			var gameObjects:Object = {};
			
			for each (var item:XML in oList){
				var gamObjectsList:XMLList = item.child("gameObject");
				
				for each (var go:XML in gamObjectsList){
					var gameObject:Object = createObject(go);
					gameObjects[go.attribute("id")] = gameObject;
				}
			}
		
			dispatch(new XMLParserEvent(XMLParserEvent.OBJECT_DEFINITIONS_PARSED, gameObjects));
		}
		
		private function createObject(objXML:XML):Object {
			var gameObject:Object = {};
			var properties:XMLList = objXML.child("property");
			var objType:String = objXML.attribute("type");
			
			gameObject.id = objXML.attribute("id");
			gameObject.type = objType;
			gameObject.name = objXML.attribute("name");
			
			for each (var prop:XML in properties){
				var property:*;
				var propType:String = prop.attribute("type");
				
				if (propType == "category") {
					property = createObject(prop);
				} else {
					property = createProperty(prop, gameObject);
				}
				gameObject[prop.attribute("id")] = property;
			}
			
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
					property.value = String(prop.attribute("value"));
					break;
					
				case "number":
					property.minValue = Number(prop.attribute("minValue"));
					property.maxValue = Number(prop.attribute("maxValue"));
					property.value = Number(prop.attribute("value"));
					break;
					
				case "shape":
				case "gameObject":
					property.index = String(prop.attribute("index"));
					property.value = String(prop.attribute("value"));
					break;
					
				default: 
					break;
			}
			
			return property;
		}
	
	}

}