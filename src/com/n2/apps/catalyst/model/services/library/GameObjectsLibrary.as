package com.n2.apps.catalyst.model.services.library {
	import com.n2.apps.catalyst.events.XMLParserEvent;
	import com.n2.apps.catalyst.model.interfaces.ICatalystService;
	import com.n2.apps.catalyst.model.interfaces.IGameObjectsLibrary;
	import com.n2.common.games.objects.GameObjectMesh;
	import com.n2.common.games.objects.GameObjectProperties;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameObjectsLibrary extends Actor implements ICatalystService, IGameObjectsLibrary {
		private var _objectPrototypes:Vector.<GameObjectMesh>
		
		public function GameObjectsLibrary(){
		}
		
		/* INTERFACE com.n2.apps.catalyst.model.interfaces.ICatalystService */
		
		public function initialize():void {
			mapEvents();
		}
		
		/* */
		
		private function mapEvents():void {
			eventMap.mapListener(eventDispatcher, XMLParserEvent.OBJECT_DEFINITIONS_PARSED, handleObjectsDefinitionsParsed, XMLParserEvent);
		}
		
		private function handleObjectsDefinitionsParsed(e:XMLParserEvent):void {
			trace("------------handleObjectsDefinitionsParsed");
			var obj:Object = e.value as Object;
			for (var s:String in obj){
				var go:GameObjectMesh = createGameObject(obj[s]);
			}
		}
		
		private function createGameObject(obj:Object):GameObjectMesh {
			var gom:GameObjectMesh = new GameObjectMesh();
			var gop:GameObjectProperties = new GameObjectProperties(obj);
			gom.setupGameObject(gop);
			
			return gom;
		}
	
	}

}