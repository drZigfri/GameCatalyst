package com.n2.common.games.objects {
	import com.n2.common.games.events.GameObjectEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameObjectMediator extends Mediator {
		[Inject]
		public var view:GameObjectMesh;
		
		private var _properties:GameObjectProperties;
		
		override public function onRemove():void {
			super.onRemove();
		}
		
		override public function onRegister():void {
			mapEvents();
		}
		
		private function handleInitializeObjectProperties(e:GameObjectEvent):void {
			_properties = e.gop;
			trace("handleInitializeObjectProperties::_properties: " + _properties);
		}
		
		private function mapEvents():void {
			eventMap.mapListener(view, GameObjectEvent.INITIALIZE_GOP, handleInitializeObjectProperties, GameObjectEvent);
		}
	}

}