package com.n2.components.navigation {
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class NavigationAxisMediator extends Mediator {
		[Inject]
		public var view:NavigationAxisView;
		
		public function NavigationAxisMediator(){
		}
		
		override public function onRegister():void {
			
		}
	
	}

}