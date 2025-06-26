package states.stages;

import states.stages.objects.*;

class Eyesky extends BaseStage
{
	var bg:BGSprite = new BGSprite('optombi bg', -2216, -1031, .85, .85);
	override function create()
	{
		//bg.shader = new Wavy();
		bg.scale.set(2, 2);
		bg.updateHitbox();
		add(bg);
		game.defaultCamZoom = .45;
	}

	override function createPost() {
		boyfriend.setPosition(770, 100);
		dad.setPosition(-375, -145);
		gf.setPosition(400, 130);

	}

}