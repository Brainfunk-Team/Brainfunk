package debug;

import flixel.FlxG;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.Font;
import openfl.system.System;

/**
    The FPS class provides an easy-to-use monitor to display
    the current frame rate of an OpenFL project
**/
@:font("assets/fonts/vcr.ttf") // adjust path if needed
class VCRFont extends Font {}

class FPSCounter extends TextField
{
    /**
        The current frame rate, expressed using frames-per-second
    **/
    public var currentFPS(default, null):Int;
    public var totalFPS(default, null):Int;
    public var i(default, null):Int;

    /**
        The current memory usage (WARNING: this is NOT your total program memory usage, rather it shows the garbage collector memory)
    **/
    public var memoryMegas(get, never):Float;

	public var maxMemory(default, null):Float;
    public var averageFPS(default, null):Float;

     @:noCompletion private var AVFPS:Array<Int>;

    @:noCompletion private var times:Array<Float>;

    public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
    {
        super();

        Font.registerFont(VCRFont);

        this.x = x;
        this.y = y;

        currentFPS = 0;
        totalFPS = 0;
        selectable = false;
        mouseEnabled = false;
        defaultTextFormat = new TextFormat("vcr.ttf", 14, color); // font name here
        autoSize = LEFT;
        multiline = true;
        text = "FPS: ";
		maxMemory = 0.0;
        averageFPS = 0.0;
        AVFPS = [];
        times = [];
        i = 0;
    }

    var deltaTimeout:Float = 0.0;

    // Event Handlers
    private override function __enterFrame(deltaTime:Float):Void
    {
        final now:Float = haxe.Timer.stamp() * 1000;
        times.push(now);
        while (times[0] < now - 1000) times.shift();
        // prevents the overlay from updating every frame, why would you need to anyways @crowplexus
        if (deltaTimeout < 50) {
            deltaTimeout += deltaTime;
            return;
        }
        currentFPS = times.length < FlxG.updateFramerate ? times.length : FlxG.updateFramerate; 
        AVFPS.push(currentFPS);
        totalFPS = 0;
        i = 0;
        for (v in AVFPS) {
            totalFPS = totalFPS + v;
            i = i + 1;
        }
        averageFPS = totalFPS/i;
        updateText();
        deltaTimeout = 0.0;
    }

    public dynamic function updateText():Void { // so people can override it in hscript
		if (memoryMegas > maxMemory)
			maxMemory = memoryMegas;
        text = 'FPS: ${currentFPS}/60'
        + '\nAverage FPS: ${Math.fround(averageFPS * 100) / 100}'
        + '\nMemory: ${flixel.util.FlxStringUtil.formatBytes(memoryMegas)}/${flixel.util.FlxStringUtil.formatBytes(maxMemory)}';

        textColor = 0xFFFFFFFF;
        if (currentFPS < FlxG.drawFramerate * 0.5)
            textColor = 0xFFFF0000;
    }

    inline function get_memoryMegas():Float
        return cpp.vm.Gc.memInfo64(cpp.vm.Gc.MEM_INFO_USAGE);
}
