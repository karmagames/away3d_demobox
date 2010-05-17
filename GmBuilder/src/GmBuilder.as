/*

Building Grid Core example in Away3d

Demonstrates:

Plane in scenes added in a grid format
mouse over highlights grid
mouse click build a cube
Code by Ann burkett
caughtthinking@gmail.com

*/

package 
{
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.core.render.Renderer;
	import away3d.core.utils.Color;
	import away3d.core.utils.Init;
	import away3d.events.MouseEvent3D;
	import away3d.materials.*;
	import away3d.primitives.*;
	
	import flash.display.*;
	import flash.events.*;
	
	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW", width="800", height="600")]
	
	public class GmBuilder extends Sprite
	{
		//engine variables
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var view:View3D;
		
		//signature variables
		private var Signature:Sprite;
		private var SignatureBitmap:Bitmap;
		
		//material objects
		private var material:ColorMaterial;
		private var material2:ColorMaterial;
		private var material3:ColorMaterial;
		
		
		//scene objects
		private var plane:Plane;
		private var trident:Trident;
		private var planecontainer:ObjectContainer3D;
		
		//grid
		private var grid:Array;
		//public var gridItemContainer:Array;
		public var rows:int = 7;
		public var cols:int = 7;
		public var gridUnitWidth:int = 50;
		public var gridUnitHeight:int = 50;
		public var gridUnitDepth:int = 50;
		
		
		/**
		 * Constructor
		 */
		public function GmBuilder() 
		{
			init();
		}
		
		/**
		 * Global initialise function
		 */
		private function init():void
		{
			initEngine();
			initMaterials();
			initObjects();
			initListeners();
		}
		
		/**
		 * Initialise the engine
		 */
		private function initEngine():void
		{
			scene = new Scene3D();
			
			//camera = new Camera3D({z:-1000});
			camera = new Camera3D();
			camera.z = -1000;
			
			
			//view = new View3D({scene:scene, camera:camera});
			view = new View3D();
			view.scene = scene;
			view.camera = camera;
			//view.renderer = Renderer.CORRECT_Z_ORDER;
			
			addChild(view);
			
		}
		
		/**
		 * Initialise the materials
		 */
		private function initMaterials():void
		{
			material = new ColorMaterial(0xCC0000);
			material2 = new ColorMaterial(0x00CC00);
			material3 = new ColorMaterial(0x0000CC);
		}
		
		/**
		 * Initialise the scene objects
		 */
		private function initObjects():void
		{
			trident = new Trident(200,true);
			scene.addChild(trident);
			planecontainer = new ObjectContainer3D();
			
			var i:int;
			var j:int;
			
			grid = new Array(rows);
			//gridItemContainer = new Array(rows);
			
			for (i = 0; i < rows; i++) {
				grid[i] = new Array(cols);
				for(j = 0; j < cols; j++) {
					var plane:Plane = new Plane({
						material: material,
						width: gridUnitWidth,
						height: gridUnitHeight,
						yUp: false,
						bothsides: true,
						x: (i * gridUnitWidth) - ((gridUnitWidth * rows)/2) + gridUnitWidth/2,
						y: (j * gridUnitHeight) - ((gridUnitHeight * cols)/2) + gridUnitWidth/2
					});
					
					plane.addEventListener(MouseEvent3D.MOUSE_DOWN, (function(p:Plane):Function {
						return function(event:MouseEvent3D):void {
							p.material = material3;
							
							//insert cube on click break this out later as a function
							var tempcube:Cube = new Cube({
								height: gridUnitHeight,
								width: gridUnitWidth,
								depth: gridUnitDepth,
								z: p.z - gridUnitDepth/2,
								x: p.x,
								y: p.y
							});
							//scene.addChild(tempcube);
							planecontainer.addChild(tempcube);
							//scene.addChild(planecontainer);
							
						};
					})(plane));
					
					//show color changes on 
					plane.addEventListener(MouseEvent3D.MOUSE_OVER, (function(p:Plane):Function {
						return function(event:MouseEvent3D):void {
							p.material = material2;
							
						};
					})(plane));
					
					plane.addEventListener(MouseEvent3D.MOUSE_OUT, (function(p:Plane):Function {
						return function(event:MouseEvent3D):void {
							p.material = material;
						};
					})(plane));
					
					grid[i][j] = plane;
					//scene.addChild(plane);
					planecontainer.addChild(plane);
					planecontainer.rotationX = -60;
					//planecontainer.rotationY = -45;
				}
			}
			
			scene.addChild(planecontainer);
		}
		
		
		/**
		 * Initialise the listeners
		 */
		private function initListeners():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
			
		}
		
		/**
		 * Navigation and render loop
		 */
		private function onEnterFrame( e:Event ):void
		{
			//planecontainer.rotationX += 2;
			
			view.render();
		}
		
		/**
		 * stage listener for resize events
		 */
		private function onResize(event:Event = null):void
		{
			view.x = stage.stageWidth / 2;
			view.y = stage.stageHeight / 2;
		}
		
		
	}
}
