package com.n2.components.omp.view {
	import com.n2.apps.gc.model.services.library.events.LibraryEvent;
	import com.n2.components.omp.ObjectsManipulationPanel;
	import com.n2.components.omp.view.ocp.ObjectControlPanel;
	import com.n2.components.omp.view.ocp.ObjectControlPanelMediator;
	import com.n2.components.omp.view.osl.ObjectSelectionPanel;
	import com.n2.components.omp.view.osl.ObjectSelectionPanelMediator;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class OMPMediator extends Mediator {
		[Inject]
		public var view:ObjectsManipulationPanel;
		
		public function OMPMediator(){
		}
		
		override public function onRegister():void {
			//Map views
			mediatorMap.mapView(ObjectControlPanel, ObjectControlPanelMediator);
			mediatorMap.mapView(ObjectSelectionPanel, ObjectSelectionPanelMediator);
		}
	
	}

}