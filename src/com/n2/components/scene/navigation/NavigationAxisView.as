package com.n2.components.scene.navigation {
	import away3d.containers.ObjectContainer3D;
	import away3d.events.MouseEvent3D;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Cone;
	import away3d.primitives.Cylinder;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class NavigationAxisView extends ObjectContainer3D {
		
		public function NavigationAxisView(){
			initializeView();
		}
		
		public function initializeView():void {
			var cmY:ColorMaterial = new ColorMaterial(0x00FF00, 1);
			var cmZ:ColorMaterial = new ColorMaterial(0x0000FF, 1);
			var xArrow:ObjectContainer3D = createArrow(0x0000FF);
			var yArrow:ObjectContainer3D = createArrow(0xFF0000);
			var zArrow:ObjectContainer3D = createArrow(0x00FF00);
			
			xArrow.rotationZ = 270;
			yArrow.rotationY = 0;
			zArrow.rotationX = 270;
			
			zArrow.addEventListener(MouseEvent3D.CLICK, handleArrowPressed);
			
			addChild(xArrow);
			addChild(yArrow);
			addChild(zArrow);
		}
		
		private function handleArrowPressed(e:MouseEvent3D):void {
			trace("[ NavigationAxisView]::handleArrowPressed ");
		}
		
		private function createArrow(color:Number = 0xcccccc):ObjectContainer3D {
			var arrow:ObjectContainer3D = new ObjectContainer3D();
			var cm:ColorMaterial = new ColorMaterial(color, 1);
			var cone:Cone = new Cone(cm, 4, 10, 16);
			var cyl:Cylinder = new Cylinder(cm, 2, 0, 30);
			cyl.x = 0;
			cyl.y = 15;
			cyl.z = 0;
			cone.y = 30;
			
			arrow.addChild(cyl);
			arrow.addChild(cone);
			
			return arrow;
		}
	
	}

}