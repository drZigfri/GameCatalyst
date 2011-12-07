package com.n2.components.gop {
	import away3d.containers.ObjectContainer3D;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import com.n2.components.gop.events.ObjectControlPanelEvent;
	import com.n2.components.ol.events.ObjectSelectionPanelEvent;
	import com.n2.components.omp.view.ocp.ObjectControlPanel;
	import com.n2.components.scene.model.SceneModel;
	import fl.controls.Button;
	import fl.controls.Label;
	import fl.controls.Slider;
	import fl.controls.TextInput;
	import fl.events.SliderEvent;
	import flash.events.Event;
	import flash.text.TextFormat;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameObjectPropertiesViewMediator extends Mediator {
		[Inject]
		public var view:GameObjectPropertiesView;
		[Inject]
		public var catalystModel:IGameCatalystModel;
		
		override public function onRegister():void {
			setupInputs();
			mapEvents();
			
			if(catalystModel.scene.selectedStageObject != null)
				view.updatePanelControls(catalystModel.scene.selectedStageObject);
		}
		
		private function mapEvents():void {
			//Listen to sliders and text inputs for parameter change
			for (var i:int = 0; i < objectControlPanel.numChildren; i++){
				var child:* = objectControlPanel.getChildAt(i);
				if (child is TextInput)
					eventMap.mapListener(child, Event.CHANGE, handleObjectParameterChange);
				else if (child is Slider){
					eventMap.mapListener(child, SliderEvent.CHANGE, handleObjectParameterChange);
					eventMap.mapListener(child, SliderEvent.THUMB_DRAG, handleObjectParameterChange);
				}
			}
			
			eventMap.mapListener(eventDispatcher, ObjectSelectionPanelEvent.OBJECT_SELECTED, handleObjectSelected, ObjectSelectionPanelEvent);
			eventMap.mapListener(eventDispatcher, ObjectControlPanelEvent.UPDATE_OBJECT_PARAMETERS, handleRotationChange, ObjectControlPanelEvent);
		}
		/**
		 * Updates control panel controls
		 */
		private function handleObjectSelected(e:ObjectSelectionPanelEvent):void {
			//TODO: Handling of wider range of properties change
			view.updatePanelControls(catalystModel.scene.selectedStageObject);
		}
		
		private function handleRotationChange(e:ObjectControlPanelEvent):void {
			var tp:String = e.targetProperty;
			var tv:Number = e.targetValue;
			var tt:String = e.transformType;
			
			//Update view components
			objectControlPanel[tp + "_" + tt + "_Input"].text = tv;
			if (tt.indexOf(ObjectControlPanelEvent.TRANSFORM_OBJECT_ROTATION) >= 0)
				view.objectControlPanel[tp + "_" + tt + "_Slider"].value = tv;
		}
		
		private function handleObjectParameterChange(e:Event):void {
			var tgt:* = e.currentTarget;
			var targetValue:Number;
			var property:String = tgt.name.split("_")[0] as String;
			var transformType:String = tgt.name.split("_")[1] as String;
			if (tgt is Slider){
				targetValue = tgt.value;
			} else if (tgt is TextInput)
				targetValue = Number(tgt.text);
			
			dispatch(new ObjectControlPanelEvent(ObjectControlPanelEvent.UPDATE_OBJECT_PARAMETERS, property, targetValue, transformType));
		}
		
		private function setupInputs():void {
			var tf:TextFormat = new TextFormat("Lucida Console", 10, 0x000000, false);
			//Go through child objects and set text format if it's a TextInput, Label or a Button type child
			for (var i:Number = 0; i < view.objectControlPanel.numChildren; i++){
				var child:* = view.objectControlPanel.getChildAt(i);
				if ((child is TextInput) || (child is Label) || (child is Button)){
					child.setStyle("textFormat", tf);
				} else if (child is Slider){
					child.value = 0;
				}
			}
		}
		
		private function get objectControlPanel():ObjectControlPanel {
			return view.objectControlPanel;
		}
	
	}

}