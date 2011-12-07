package com.n2.apps.catalyst.control {
	import com.n2.apps.catalyst.model.interfaces.ICatalystService;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class InitializeServicesCommand extends Command {
		[Inject]
		public var model:IGameCatalystModel;
		
		override public function execute():void {
			ICatalystService(model).initialize();
			ICatalystService(model.scene).initialize();
			ICatalystService(model.gameAssetsLibrary).initialize();
			ICatalystService(model.gameObjectsLibrary).initialize();
			ICatalystService(model.cameraControlModel).initialize();
			ICatalystService(model.catalystConfig).initialize();
		}
	
	}

}