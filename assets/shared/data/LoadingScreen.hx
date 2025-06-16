function onCreate()
{
	game.stateChangeDelay = 0; //Force loading screen to stay for atleast 3 seconds, remove this once you're done working on your loading screen unless you're using it for something else.

	var bg = new FlxSprite().makeGraphic(1, 1, 0xFFCAFF4D);
	bg.scale.set(FlxG.width, FlxG.height);
	bg.updateHitbox();
	bg.screenCenter();
	addBehindBar(bg);

	funkay = new FlxSprite(0, 0).loadGraphic(Paths.image('backyard-full'));
	funkay.antialiasing = ClientPrefs.data.antialiasing;
	funkay.setGraphicSize(0, FlxG.height);
	funkay.updateHitbox();
	addBehindBar(funkay);
}

function onUpdate(elapsed:Float)
{
	//do something here every frame
}