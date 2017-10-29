package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Theo leyenda
 */
class Obstaculo1 extends FlxSprite 
{
	private var contador:Int = 0;
	private var CONST:Int = 100;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		getContador();
		movimiento();
	}
	public function movimiento():Void
	{
		contador++;
		if (contador <=CONST)
		{
			x = x + 1;
		}
		if (contador >CONST)
		{
			x = x -1;
		}
		if (contador == CONST*2)
		{
			contador = 0;
		}
	}
	public function getContador():Int
	{
		return contador;
	}
	
}