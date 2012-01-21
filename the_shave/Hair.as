package the_shave {
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.utils.getTimer;
  import flash.utils.Timer;
  
  public class Hair extends Sprite {
    private static var OFF_SCREEN_THRESHOLD = 1000; // pixels
    private static var FALLING_ACCELERATION = 1.1;
    private static var FRAME_RATE = 50; // milliseconds
    
    private var _shaved:Boolean = false;
    private var _startx:int;
    private var _starty:int;
    private var _timer:Timer;
//    private var last_update_time:
    
    // Constructor
    public function Hair(startx:int, starty:int):void {
      this.x = _startx = startx;
      this.y = _starty = starty;
      _timer = new Timer(FRAME_RATE);
      reset_hair();
    }
    
    // Public API
    
    // Events
    private function hair_cut(e:MouseEvent):void {
      this.removeEventListener(MouseEvent.MOUSE_OVER, hair_cut);
      _shaved = true;
      _timer.addEventListener(TimerEvent.TIMER, animate_fall_off);
      _timer.start();
    }
    
    private function animate_fall_off(e:TimerEvent):void {
      this.y = this.y * FALLING_ACCELERATION;
      if (this.y > stage.stageHeight + OFF_SCREEN_THRESHOLD) {
        _timer.stop();
        reset_hair();
      }
    }
    
    // Helpers
    private function reset_hair():void {
      this.y = _starty;
      this.x = _startx;
      this.addEventListener(MouseEvent.MOUSE_OVER, hair_cut);
    }
  }
}