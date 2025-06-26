package states.stages;

import states.stages.objects.*;
import stuff.VsDaveShaders;
import backend.Conductor;

class Redsky extends BaseStage
{
	var bg:BGSprite = new BGSprite('redsky/redsky', -700, -200, .85, .85);

	override function create()
	{
		FlxG.camera.zoom = .45;
		bg.scale.set(2, 2);
		bg.updateHitbox(); 
		add(bg);
		voidShader(bg);
	}

	override function createPost()
	{
		boyfriend.setPosition(770, 100);
		dad.setPosition(-375, -145);
		gf.setPosition(400, 130);
	}

	override function update(elapsed:Float)
	{
		var shad = cast(bg.shader, GlitchShader);
		shad.uTime.value[0] += elapsed;
	}

	function voidShader(background:BGSprite)
	{
		var testshader:GlitchEffect = new GlitchEffect();
		testshader.waveAmplitude = 0.1;
		testshader.waveFrequency = 5;
		testshader.waveSpeed = 2;
		
		background.shader = testshader.shader;
	}
}
