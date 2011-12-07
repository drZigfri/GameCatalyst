package com.n2.components.gol {
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameObjectsLibraryViewMediator extends Mediator {
		[Inject]
		public var view:GameObjectsLibraryView;
		[Inject]
		public var catalystModel:IGameCatalystModel;
		
		override public function onRemove():void {
			super.onRemove();
		}
		
		override public function onRegister():void {
			view.initializePanel(catalystModel);
		}
	}
}