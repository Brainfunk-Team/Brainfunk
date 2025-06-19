package options;

class BrainfunkSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = Language.getPhrase('gameplay_menu', 'Gameplay Settings');
		title = "Brainfunk Settings"; //Will remove this if I end up added localization, for now, this mod is English only.
		rpcTitle = 'Brainfunk Settings Menu'; //for Discord Rich Presence

		//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
		var option:Option = new Option('An Option', //Name
			'This option does something. We haven\'t figured out what, though.', //Description
			'test', //Save data variable name
			BOOL); //Variable type
		addOption(option);

		super();
	}

	function onChangeHitsoundVolume()
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.data.hitsoundVolume);

	function onChangeAutoPause()
		FlxG.autoPause = ClientPrefs.data.autoPause;
}
