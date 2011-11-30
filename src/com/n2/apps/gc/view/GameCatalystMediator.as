package com.n2.apps.gc.view {
	import alternativa.gui.base.GUIobject;
	import com.n2.apps.gc.events.ContextEventGC;
	import com.n2.apps.gc.events.GCComponentEvent;
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.apps.gc.model.services.loader.ComponentLoader;
	import com.n2.apps.gc.model.services.loader.events.ComponentLoaderEvent;
	import com.n2.components.gop.GameObjectProperties;
	import com.n2.components.ol.ObjectsLibrary;
	import flash.display.Sprite;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalystMediator extends Mediator {
		[Inject]
		public var view:GameCatalystView;
		[Inject]
		public var model:GameCatalystModel;
		[Inject]
		public var loader:ComponentLoader;
		
		public function GameCatalystMediator(){
		}
		
		override public function onRegister():void {
			mapEvents();
		}
		
		private function mapEvents():void {
			eventMap.mapListener(eventDispatcher, GCComponentEvent.CREATE_COMPONENT, handleCreateComponent, GCComponentEvent);
		}
		
		private function handleCreateComponent(e:GCComponentEvent):void {
			var comp:GUIobject;
			var componentType:String = e.componentType;
			
			if (!componentExists(componentType)) {
				var compClass:Class = getComponentTypeClass(componentType);
				comp = new compClass();
				
				switch (componentType){
					case 'GameObjectProperties': 
						comp.x = 10;
						comp.y = 10;
						break;
					case 'ObjectsLibrary': 
						comp.x = 200;
						comp.y = 10;
						break;
					default: 
						break;
				}
				
				if (comp != null){
					view.componentContainer.addChild(comp);
				}
			} else {
				removeComponent(componentType);
			}
		}
		
		private function componentExists(type:String):Boolean {
			var compClass:Class = getComponentTypeClass(type);
			var compContainer:Sprite = view.componentContainer;
			
			for (var i:int = 0; i < compContainer.numChildren; i++){
				var child:* = compContainer.getChildAt(i);
				if (child is compClass)
					return true;
			}
			
			return false;
		}
		
		private function removeComponent(type:String):void {
			var compClass:Class = getComponentTypeClass(type);
			var compContainer:Sprite = view.componentContainer;
			
			for (var i:int = 0; i < compContainer.numChildren; i++){
				var child:* = compContainer.getChildAt(i);
				if (child is compClass)
					compContainer.removeChild(child);
			}
		}
		
		private function getComponentTypeClass(type:String):Class {
			var compClass:Class;
			
			switch (type){
				case 'GameObjectProperties': 
					compClass = GameObjectProperties;
					break;
				case 'ObjectsLibrary': 
					compClass = ObjectsLibrary;
					break;
				default: 
					break;
			}
			
			return compClass;
		}
	}

}