package states.editors;

import openfl.net.FileReference;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import haxe.Json;
import backend.ui.PsychUIEventHandler.PsychUIEvent;
import backend.ui.PsychUIBox;
import backend.ui.PsychUIInputText;
import backend.ui.PsychUIButton;
import states.editors.content.Prompt;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import paths.Paths;

class MidsongEditorState extends MusicBeatState implements PsychUIEvent
{
	var tip:Array<String> = [
		"Press Shift to select an event.",
		"Press Escape to exit."
	];

	var emptyString:String = "(Empty!)";

	var text:Array<String> = [""];
	var stepStart:Array<Int> = [0];
	var stepEnd:Array<Int> = [0];
	var fadeStepStart:Array<Int> = [0];
	var fadeStepEnd:Array<Int> = [0];
	var fadeTime:Array<Float> = [0.1];

	var dialogue:Array<Dynamic> = [];
	var fade:Array<Dynamic> = [];

	var box:PsychUIBox = new PsychUIBox(FlxG.width-300, FlxG.height-300, 300, 300, ["Dialogue Settings", "Fade Settings"]);
	var box2:PsychUIBox = new PsychUIBox(FlxG.width-300, 300, 300, 300, ["Song Settings"]);
	var textInput:PsychUIInputText = new PsychUIInputText(FlxG.width-300, FlxG.height-290, 100, "");
	var songInput:PsychUIInputText = new PsychUIInputText(FlxG.width-300, 20, 100, "");
	var currentText:FlxText = new FlxText(0, 0, FlxG.width, "(Empty!)");
	var reloadSongButton:PsychUIButton = new PsychUIButton(FlxG.width-300, 40, "Reload Song", null, 80, 20);
	var saveButton:PsychUIButton = new PsychUIButton(FlxG.width-300, FlxG.height-200, "Save JSON", null, 80, 20);
	var loadButton:PsychUIButton = new PsychUIButton(FlxG.width-300, FlxG.height-180, "Load JSON", null, 80, 22);
	
	var newEventButton:PsychUIButton = new PsychUIButton(FlxG.width-300, FlxG.height-180, "New Event", null, 80, 24);
	
	//General variables

	var songPlaying:Boolean = false;

	override function create() {
		FlxG.camera.bgColor = FlxColor.fromHSL(0, 0, 0.5);
		add(box);
		add(box2);
		add(textInput);
		add(songInput);
		add(saveButton);
		add(loadButton);
		add(newEventButton);
		add(reloadSongButton);
		currentText.setFormat("assets/fonts/vcr.ttf", 32, FlxColor.WHITE, "center");
		currentText.screenCenter(XY);
		currentText.color = FlxColor.RED;
		add(currentText);
		FlxG.mouse.visible = true;
	}

	override function update() {
		if(FlxG.keys.justPressed.ESCAPE) {
			MusicBeatState.switchState(new states.editors.MasterEditorMenu());
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		if(FlxG.key.justPressed.SPACE) {

		}

		if(FlxG.key.justPressed.SHIFT) {
			
		}
	}

	public function UIEvent(id:String, sender:Dynamic) {
		if(id == PsychUIInputText.CHANGE_EVENT && (sender is PsychUIInputText)) {
			if (sender == textInput) {
				if (textInput.text.length > 0) {
					currentText.text = textInput.text;
					currentText.color = FlxColor.WHITE;
				}
				else {
					currentText.text = emptyString;
					currentText.color = FlxColor.RED;
				}
			}
		}
		if(id == PsychUIButton.CLICK_EVENT && (sender is PsychUIButton)) {
			if (sender == reloadSongButton) {
				trace("Clicked reload!");
			}
			if (sender == saveButton) {
				trace("Save clicked, dialogue saved: " + currentText.text + "At step: 0");
				for (i in 0...text.length) {
					dialogue.push({
						text: text[i],
						startStep: stepStart[i],
						endStep: stepEnd[i]
					});
				}

				for (i in 0...fadeStepStart.length) {
					fade.push({
						startStep: fadeStepStart[i],
						endStep: fadeStepEnd[i],
						fadeTime: fadeTime[i]
					});
				}

				var midsongData = {
					dialogue: dialogue,
					fade: fade
				};

				var jsonStr = Json.stringify(midsongData, "\t");
				var fileRef = new FileReference();
				fileRef.save(jsonStr, "midsong.json");
			}
		}
	}
}
