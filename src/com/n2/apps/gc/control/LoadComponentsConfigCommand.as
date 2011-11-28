package com.n2.apps.gc.control {
	import com.n2.apps.gc.model.services.loader.ComponentLoader;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class LoadComponentsConfigCommand extends Command {
		[Inject]
		public var loader:ComponentLoader;
		
		override public function execute():void {
			loader.loadConfig();
		}
	}

}