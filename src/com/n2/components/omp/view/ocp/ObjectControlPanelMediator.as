package com.n2.components.omp.view.ocp {
	import com.n2.components.omp.model.OMPModel;
	import com.n2.components.omp.view.events.ObjectControlPanelEvent;
	import com.n2.components.omp.view.ocp.ObjectControlPanel;
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
	public class ObjectControlPanelMediator extends Mediator {
		[Inject]
		public var view:ObjectControlPanel;
		[Inject]
		public var ompModel:OMPModel;
		
		public function ObjectControlPanelMediator(){
		}
		
		override public function onRegister():void {
			mapEvents();
			setupInputs();
		}
		
		private function mapEvents():void {
			//Listen to sliders and text inputs for parameter change
			for (var i:int = 0; i < view.numChildren; i++){
				var child:* = view.getChildAt(i);
				if (child is TextInput)
					eventMap.mapListener(child, Event.CHANGE, handleObjectParameterChange);
				else if (child is Slider){
					eventMap.mapListener(child, SliderEvent.CHANGE, handleObjectParameterChange);
					eventMap.mapListener(child, SliderEvent.THUMB_DRAG, handleObjectParameterChange);
				}
			}
			
			eventMap.mapListener(eventDispatcher, ObjectControlPanelEvent.UPDATE_OBJECT_PARAMETERS, handleRotationChange, ObjectControlPanelEvent);
		}
		
		private function handleRotationChange(e:ObjectControlPanelEvent):void {
			var tp:String = e.targetProperty;
			var tv:Number = e.targetValue;
			var tt:String = e.transformType;
			
			//Update view components
			view[tp + "_" + tt + "_Input"].text = tv;
			if (tt.indexOf(ObjectControlPanelEvent.TRANSFORM_OBJECT_ROTATION) >= 0)
				view[tp + "_" + tt + "_Slider"].value = tv;
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
			for (var i:Number = 0; i < view.numChildren; i++){
				var child:* = view.getChildAt(i);
				if ((child is TextInput) || (child is Label) || (child is Button)){
					child.setStyle("textFormat", tf);
				} else if (child is Slider){
					child.value = 0;
				}
			}
		}
	}

}