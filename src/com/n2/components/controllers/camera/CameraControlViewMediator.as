package com.n2.components.controllers.camera {
	import alternativa.gui.event.SliderEvent;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import com.n2.apps.catalyst.model.services.camera.events.CameraControlEvent;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class CameraControlViewMediator extends Mediator {
		[Inject]
		public var view:CameraControlView;
		[Inject]
		public var model:IGameCatalystModel;
		
		override public function onRemove():void {
			super.onRemove();
		}
		
		override public function onRegister():void {
			view.initializePanel(model);
			mapEvents();
		}
		
		private function mapEvents():void {
			eventMap.mapListener(view.btnLockOn, MouseEvent.CLICK, handleLockOnClick, MouseEvent);
			eventMap.mapListener(view.sldDistance, SliderEvent.CHANGE_POSITION, handleDistanceChange, SliderEvent);
		}
		
		private function handleLockOnClick(e:MouseEvent):void {
			//TODO: handleLockOnClick
			dispatch(new CameraControlEvent(CameraControlEvent.SET_LOCK_ON_OBJECT, e.target.checked));
		}
		
		private function handleDistanceChange(e:SliderEvent):void {
			dispatch(new CameraControlEvent(CameraControlEvent.SET_DISTANCE_FROM_OBJECT, e.pos * 100));
		}
	}

}