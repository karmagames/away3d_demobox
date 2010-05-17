package
{
	import away3d.containers.View3D;
	import away3d.core.render.Renderer;
	import away3d.events.MouseEvent3D;
	import away3d.events.Object3DEvent;
	import away3d.primitives.Cube;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Away3D_Test extends View3D
	{
		public function Away3D_Test()
		{
			super({
				x: stage.stageWidth  / 2,
				y: stage.stageHeight / 2,
				renderer: Renderer.BASIC,
				camera: {
					z: -1000
				}
			});
			
			var cube:Cube = new Cube();
			
			scene.addChild(cube);
			
			addEventListener(Event.ENTER_FRAME, function(event:Event):void {
				cube.rotationX += 1;
				cube.rotationY += 1;
				cube.rotationZ += 1;
				
				render();
			});
						
			/* 
			 * This fires when the cube is clicked.
			 * All properties, aside from sceneX and sceneY, are either null, NaN or false.
			 */
			addEventListener(MouseEvent3D.MOUSE_DOWN, function(event:MouseEvent3D):void {
				trace("Clicked somewhere else on the view");
			});
			
			/*
			* This event never fires.
			* I would expect this to fire before the view receives the event (event propagation)
			*/
			cube.addEventListener(MouseEvent3D.MOUSE_DOWN, function(event:MouseEvent3D):void {
				trace("Clicked directly on cube");
			});
			
			/*
			 * Assuming I am "doing it wrong" and I should not use events, 
			 * reading the docs again leads to this method, this doesn't fire as well.
			 */
			cube.addOnMouseDown(function(event:MouseEvent3D):void {
				trace("Clicked directly on cube [addOnMouseDown]");
			});
			
			/*
			 * Maybe the scene throws the events?
			 * The scene is the parent of the cube, so  it might be responsible for dispatching events.
			 * This does not fire too.
			 */
			scene.addEventListener(MouseEvent3D.MOUSE_DOWN, function(event:MouseEvent3D):void {
				trace("Clicked somewhere on the scene");
			});
			
			/* 
			 * If the camera actually dispatches them, it makes NO sense!
			 * Good thing this one doesn't work...
			 */
			camera.addEventListener(MouseEvent3D.MOUSE_DOWN, function(event:MouseEvent3D):void {
				trace("Clicked anywhere on the... camera?");
			});

				// Just in case I'm going insane and this is not the default value
			cube.mouseEnabled = true;
		}
	}
}