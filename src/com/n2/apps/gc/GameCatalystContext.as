package com.n2.apps.gc {
	import com.n2.apps.gc.control.AddResourcesClassesCommand;
	import com.n2.apps.gc.control.LoadComponentsConfigCommand;
	import com.n2.apps.gc.control.ParseLibraryConfigCommand;
	import com.n2.apps.gc.events.ContextEventGC;
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.apps.gc.model.services.library.GameObjectsLibrary;
	import com.n2.apps.gc.model.services.loader.ComponentLoader;
	import com.n2.apps.gc.model.services.loader.events.ComponentLoaderEvent;
	import com.n2.apps.gc.model.services.loader.queue.LoaderQueue;
	import com.n2.apps.gc.view.GameCatalystMediator;
	import com.n2.apps.gc.view.GameCatalystView;
	import com.n2.components.omp.model.OMPModel;
	import com.n2.components.omp.ObjectsManipulationPanel;
	import com.n2.components.omp.view.OMPMediator;
	import com.n2.components.scene.model.SceneModel;
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
			
			initializeView();
			
			super.startup();
		}
		
		private function initializeView():void {
			GameCatalyst(contextView).initializeView();
		}
		
		private function mapEvents():void {
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadComponentsConfigCommand, ContextEvent, true);
			commandMap.mapEvent(ComponentLoaderEvent.COMPONENTS_LOADED, AddResourcesClassesCommand, ComponentLoaderEvent, true);
			commandMap.mapEvent(ComponentLoaderEvent.COMPONENTS_LOADED, ParseLibraryConfigCommand, ComponentLoaderEvent, true);
		}
		
		private function mapModels():void {
			injector.mapSingleton(LoaderQueue);
			injector.mapSingleton(GameCatalystModel);
			injector.mapSingleton(SceneModel);
			injector.mapSingleton(GameObjectsLibrary);
			injector.mapSingleton(ComponentLoader);
			//TODO: Make sure we need OMPModel otherwise remove
			injector.mapSingleton(OMPModel);
		}
		
		private function mapViews():void {
			mediatorMap.mapView(GameCatalystView, GameCatalystMediator);
			mediatorMap.mapView(ObjectsManipulationPanel, OMPMediator);
			mediatorMap.mapView(SceneView, SceneMediator);
		}
	}

}