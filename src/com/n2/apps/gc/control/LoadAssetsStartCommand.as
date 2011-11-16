package com.n2.apps.gc.control {
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.components.library.events.AssetLoaderEvent;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class LoadAssetsStartCommand extends Command {
		[Inject]
		public var gcModel:GameCatalystModel;
		
		override public function execute():void {
			gcModel.gameObjectsLibrary.initialize();
			gcModel.gameObjectsLibrary.loadAssets();
		}
	}

}