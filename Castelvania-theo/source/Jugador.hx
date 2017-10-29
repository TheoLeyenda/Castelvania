package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author Theo Leyenda
 */
enum Estado{
	QUIETO;
	CORRE;
	SALTA;
}

class Jugador extends FlxSprite 
{
	private var state:Estado = Estado.QUIETO;
	private var habilitarA:Bool = false;
	private var habilitarD:Bool = false;
	private var Pinia:Trompada;
	private var habilitarTimer:Bool = false;
	private var tiempoPinia:Int = 15;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		Pinia = new Trompada(x, y);
		Pinia.kill();
		
		
		loadGraphic(AssetPaths.jugador__png, true, 32, 32);
		
		setFacingFlip(FlxObject.LEFT, true, false);//el segundo parametro dice si volteo X y el segundo si volteo Y (true lo voltea false no lo voltea)
		//voltea: cambia el signo.
		//para setear que mire para la izquierda;
		setFacingFlip(FlxObject.RIGHT, false, false);//el segundo parametro dice si volteo X y el segundo si volteo Y (true lo voltea false no lo voltea)
		//voltea: cambia el signo.h 
		// para setear que mire para la derecha;
		
		acceleration.y = 1500;
	}
	override public function update(elapsed:Float):Void
	{
		maquinaStado();
		Golpear();
		if (isTouching(FlxObject.FLOOR))
		{
			habilitarA = true;
			habilitarD = true;
		}
		super.update(elapsed);
	}
	public function maquinaStado():Void
	{
		switch(state)
		{
			case Estado.QUIETO:
				if (isTouching(FlxObject.FLOOR))
				{
					salto();
					movimientoHorizontal();
				}
				if (velocity.y != 0)
				{
					state = Estado.SALTA;
				}
				if (velocity.x != 0)
				{
					state = Estado.CORRE;
				}
			case Estado.SALTA:
				if (velocity.y == 0)
				{
					state = Estado.QUIETO;
				}
				if (habilitarA && habilitarD)
				{
					state = Estado.CORRE;
				}
			case Estado.CORRE:
				if (isTouching(FlxObject.FLOOR))
				{
					salto();
					movimientoHorizontal();
				}
				if (velocity.y != 0)
				{
					state = Estado.SALTA;
				}
				else if (velocity.x == 0)
				{
					state = Estado.QUIETO;
				}
		}
	}

	public function salto():Void
	{
		if (FlxG.keys.justPressed.W && isTouching(FlxObject.FLOOR))
		{
			if (facing == FlxObject.RIGHT)
			{
				habilitarA = false;
				velocity.x = 40;
				velocity.y = velocity.y -400;
			}
			else
			{
				habilitarD = false;
				velocity.x = -40;
				velocity.y = velocity.y -400;
			}
			state = Estado.SALTA;
		}
	}
	
	public function movimientoHorizontal():Void
	{
		velocity.x = 0;
		
		if (FlxG.keys.pressed.D && habilitarD)
		{
			velocity.x = velocity.x +300;
		}
		if (FlxG.keys.pressed.A && habilitarA)
		{
			velocity.x = velocity.x -300;
		}
		if (isTouching(FlxObject.FLOOR) && velocity.y == 0)
		{
			if (velocity.x != 0)
			{
				if (velocity.x > 0)
				{
					facing = FlxObject.RIGHT;
				}
				if (velocity.x < 0)
				{
					facing = FlxObject.LEFT;
				}
				else
				{
					//animacion quieto
				}
			}
		}
	}
	public function Golpear():Void
	{
		if (FlxG.keys.pressed.L)
		{
			Pinia.reset(x+width/2, y+(height*0.4));
			Pinia.makeGraphic(3, 3, 0xffff00ff);
			Pinia.velocity.x = 100;
			FlxG.state.add(Pinia);
			habilitarTimer = true;
		}
		if (habilitarTimer)
		{
			tiempoPinia = tiempoPinia - 1;
		}
		if (tiempoPinia == 0)
		{
			habilitarTimer = false;
			tiempoPinia = 15;
			Pinia.kill();
		}
	}
}
	
	