package 
{
	import away3d.containers.View3D;
	import away3d.events.MouseEvent3D;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Cube;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Away3d_SimpleFix extends Sprite
	{
		public function Away3d_SimpleFix()
		{
			var view:View3D = new View3D({
				x: stage.stageWidth  / 2,
				y: stage.stageHeight / 2,
				camera: {
					z: -1000
				}
			});
			
			var plane:Cube = new Cube({
				width: 100,
				height: 100
			});
			
			view.scene.addChild(plane);
			
			plane.addEventListener(MouseEvent3D.MOUSE_DOWN, function(event:MouseEvent3D):void {
				trace("clikc");
			});
			
			addEventListener(Event.ENTER_FRAME, function(event:Event):void {
				plane.rotationX += 2;
				plane.rotationY += 2;
				plane.rotationZ += 2;
				
				view.render();
			});
			
			addChild(view);
		}
	}
}