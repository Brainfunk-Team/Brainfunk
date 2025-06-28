//Brainy's, don't touch this yet it's not finished.


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
import backend.Paths;

class MidsongEditorState extends MusicBeatState implements PsychUIEvent
{
    var tip:String =    "Press Shift to select an event.\n" +
                        "Press Escape to exit."
    var tipText:FlxText;
    var emptyString:String = "(Empty!)";
    var text:Array<String> = [""];
    var stepStart:Array<Int> = [0];
    var stepEnd:Array<Int> = [0];
    var fadeStepStart:Array<Int> = [0];
    var fadeStepEnd:Array<Int> = [0];
    var fadeTime:Array<Float> = [0.1];
    var dialogue:Array<Dynamic> = [];
    var fade:Array<Dynamic> = [];
    var box:PsychUIBox;
    var box2:PsychUIBox;
    var textInput:PsychUIInputText;
    var songInput:PsychUIInputText;
    var currentText:FlxText;
    var reloadSongButton:PsychUIButton;
    var saveButton:PsychUIButton;
    var loadButton:PsychUIButton;
    var newEventButton:PsychUIButton;
    var songPlaying:Bool = false;

    var playhead:FlxSprite;

    var events:Array<FlxSprite> = new Array<FlxSprite>();
    var eventsData:Array<Array<Float>> = new Array<Array<Float>>;

    var curEvent:Int;

    override function create():Void
    {
        super.create();
        FlxG.camera.bgColor = FlxColor.fromHSL(0,0,0.5);

        box = new PsychUIBox(FlxG.width-300, FlxG.height-300, 300, 300, ["Dialogue Settings","Fade Settings"]);
        box2 = new PsychUIBox(FlxG.width-300, 300,       300, 300, ["Song Settings"]);
        textInput = new PsychUIInputText(FlxG.width-300, FlxG.height-290, 100, "");
        songInput = new PsychUIInputText(FlxG.width-300, 20,             100, "");
        reloadSongButton = new PsychUIButton(FlxG.width-300, 40,   "Reload Song", null, 80, 20);
        saveButton       = new PsychUIButton(FlxG.width-300, FlxG.height-200, "Save JSON", null, 80, 20);
        loadButton       = new PsychUIButton(FlxG.width-300, FlxG.height-180, "Load JSON", null, 80, 22);
        newEventButton   = new PsychUIButton(FlxG.width-300, FlxG.height-160, "New Event", null, 80, 24);

        currentText = new FlxText(0, 0, FlxG.width, emptyString);
        currentText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.RED, "center");
        currentText.screenCenter(XY);

        tipText = new FlxText(0, 0, FlxG.width, tip);
        tipText.x = 0
        tipText.y = FlxG.Height
        tipText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.RED, "left");
    
        playhead = new FlxSprite(FlxG.width/2, FlxG.height-128);
        playhead.loadGraphic(Paths.getSharedPath("images/editors/playhead.png"));

        add(box);
        add(box2);
        add(textInput);
        add(songInput);
        add(saveButton);
        add(loadButton);
        add(newEventButton);
        add(reloadSongButton);
        add(currentText);
        add(playhead);

        FlxG.mouse.visible = true;
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE) {
            MusicBeatState.switchState(new states.editors.MasterEditorMenu());
            FlxG.sound.playMusic(Paths.music("freakyMenu"));
        }
        if (FlxG.keys.justPressed.SPACE) { }
        if (FlxG.keys.justPressed.SHIFT) { }
    }

    function createEvent(type:Float, step:Float, length:Int, data:Float):Int //Returns event index
    {
        events.push(new FlxSprite(0, 128));
        eventsData.push([type, step, length, data]);
        events[events.length-1].loadGraphic(Paths.getSharedPath("images/editors/midsongDialogueEditor"));
        add(events[events.length-1]);
        return events.length-1;
    }

    function saveFile(name:String):Void
    {
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
        
        var midsongData = { dialogue: dialogue, fade: fade };
        var jsonStr:String = Json.stringify(midsongData, "\t");
        var fileRef:FileReference = new FileReference();
        fileRef.save(jsonStr, name);
    }

    function loadFile():String
    {
        //WORK IN PROGRESS, MAKE SURE IT RETURNS A STRING

        return null;
    }

    public function UIEvent(id:String, sender:Dynamic):Void
    {
        if (id == PsychUIInputText.CHANGE_EVENT && sender == textInput) {
            if (textInput.text.length > 0) {
                currentText.text = textInput.text;
                currentText.color = FlxColor.WHITE;
            } else {
                currentText.text = emptyString;
                currentText.color = FlxColor.RED;
            }
        }

        if (id == PsychUIButton.CLICK_EVENT) {
            if (sender == reloadSongButton) {
                trace("Clicked reload!");
            }
            if (sender == saveButton) {
                saveFile("midsong.json");
            }
            if (sender == loadButton) {
                var curDataString:String = loadFile();
            }
            if (sender == newEventButton) {
                curEvent = createEvent(0, 0, 0, 0);
            }
        }
    }
}
