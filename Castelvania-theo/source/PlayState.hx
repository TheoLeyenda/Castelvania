package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class PlayState extends FlxState
{
	private var player:Jugador;
	private var plataforma:FlxSprite;
	
	override public function create():Void
	{
		super.create();
		
		player = new Jugador(FlxG.width / 2, 100);
		
		plataforma = new FlxSprite(10,220);
		plataforma.makeGraphic(246,32);
		plataforma.immovable = true;
		add(plataforma);
		add(player);
		FlxG.camera.follow(player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(plataforma, player);
	}
}