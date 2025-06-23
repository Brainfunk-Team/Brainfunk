package states.stages;

import states.stages.objects.*;
import shaders.Wavy;
import backend.Conductor;

class Eyesky extends BaseStage
{
	var bg:BGSprite = new BGSprite('optombi bg', -2216, -1031, .85, .85);
	override function create()
	{
		bg.shader = new Wavy();
		bg.shader.data.uTime = { value: [0.0] };
		bg.shader.data.uWaveAmplitude = { value: [0.01] };
		bg.shader.data.uSpeed = { value: [2.0] };
		bg.shader.data.uFrequency = { value: [5.0] };
		bg.scale.set(5, 5);
		bg.updateHitbox();
		add(bg);
		game.defaultCamZoom = .45;
	}

	override function createPost() {
		boyfriend.setPosition(770, 100);
		dad.setPosition(-375, -145);
		gf.setPosition(400, 130);

	}

	override function update(elapsed:Float)
    {
        super.update(elapsed);

        var time = Conductor.songPosition / 1000;
        bg.shader.data.uTime.value = [time];
		bg.shader.data.uWaveAmplitude.value = [0.01];
		bg.shader.data.uSpeed.value = [2.0];
		bg.shader.data.uFrequency.value = [5.0];

    }

}