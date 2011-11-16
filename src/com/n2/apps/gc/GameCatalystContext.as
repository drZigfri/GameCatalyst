package com.n2.apps.gc {
	import com.n2.apps.gc.control.LoadAssetsStartCommand;
	import com.n2.apps.gc.events.ContextEventGC;
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.apps.gc.view.GameCatalystMediator;
	import com.n2.apps.gc.view.GameCatalystView;
	import com.n2.components.library.GameObjectsLibrary;
	import com.n2.components.library.interfaces.IGameObjectsLibrary;
	import com.n2.components.omp.model.OMPModel;
	import com.n2.components.omp.ObjectsManipulationPanel;
	import com.n2.components.omp.view.OMPMediator;
	import com.n2.components.scene.SceneMediator;
	import com.n2.components.scene.SceneView;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalystContext extends Context {
		
		public function GameCatalystContext(contextView:flash.display.DisplayObjectContainer = null, autoStartup:Boolean = true){
			super(contextView, autoStartup);
		}
		
		override public function startup():void {
			mapModels();
			mapViews();
			mapEvents();
			
			super.startup();
			
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP_COMPLETE));
		}
		
		private function mapEvents():void {
			//commandMap.mapEvent(ContextEventGC.VIEW_INITIALIZATION_END, LoadAssetsStartCommand, ContextEventGC);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadAssetsStartCommand, ContextEvent, true);
		}
		
		private function mapModels():void {
			injector.mapSingleton(GameCatalystModel);
			injector.mapSingleton(OMPModel);
			injector.mapSingletonOf(IGameObjectsLibrary, GameObjectsLibrary);
		}
		
		private function mapViews():void {
			mediatorMap.mapView(GameCatalystView, GameCatalystMediator);
			mediatorMap.mapView(ObjectsManipulationPanel, OMPMediator);
			mediatorMap.mapView(SceneView, SceneMediator);
		}
	}

}