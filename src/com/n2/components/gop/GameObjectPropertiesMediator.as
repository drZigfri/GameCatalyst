package com.n2.components.gop {
	import away3d.containers.ObjectContainer3D;
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
	public class GameObjectPropertiesMediator extends Mediator {
		[Inject]
		public var view:GameObjectProperties;
		[Inject]
		public var sceneModel:SceneModel;
		
		override public function onRegister():void {
			mapEvents();
			setupInputs();
			
			if(sceneModel.selectedStageObject != null)
				setParameterValues(sceneModel.selectedStageObject.objectRepresentation);
		}
		
		private function mapEvents():void {
			//Listen to sliders and text inputs for parameter change
			for (var i:int = 0; i < view.objectControlPanel.numChildren; i++){
				var child:* = view.objectControlPanel.getChildAt(i);
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
		
		private function handleObjectSelected(e:ObjectSelectionPanelEvent):void {
			setParameterValues(e.gameObject.objectRepresentation);
		}
		
		private function handleRotationChange(e:ObjectControlPanelEvent):void {
			var tp:String = e.targetProperty;
			var tv:Number = e.targetValue;
			var tt:String = e.transformType;
			
			//Update view components
			view.objectControlPanel[tp + "_" + tt + "_Input"].text = tv;
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
		
		private function setParameterValues(object:ObjectContainer3D):void {
			objectControlPanel.x_Position_Input.text = String(object.x);
			objectControlPanel.y_Position_Input.text = String(object.y);
			objectControlPanel.z_Position_Input.text = String(object.z);
			objectControlPanel.x_Rotation_Input.text = String(object.rotationX);
			objectControlPanel.y_Rotation_Input.text = String(object.rotationY);
			objectControlPanel.z_Rotation_Input.text = String(object.rotationZ);
			objectControlPanel.x_Scale_Input.text = String(object.scaleX);
			objectControlPanel.y_Scale_Input.text = String(object.scaleY);
			objectControlPanel.z_Scale_Input.text = String(object.scaleZ);
			objectControlPanel.x_Rotation_Slider.value = object.rotationX;
			objectControlPanel.y_Rotation_Slider.value = object.rotationY;
			objectControlPanel.z_Rotation_Slider.value = object.rotationZ;
			objectControlPanel.x_Scale_Slider.value = object.scaleX;
			objectControlPanel.y_Scale_Slider.value = object.scaleY;
			objectControlPanel.z_Scale_Slider.value = object.scaleZ;
		}
		
		private function get objectControlPanel():ObjectControlPanel {
			return view.objectControlPanel;
		}
	
	}

}