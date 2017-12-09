public class Screen:Object{
	public int height{get; set;}
	public int width{get;set;}
	/**
	* 获取屏幕分辨率,暂时只支持第一块屏幕
	**/
	public  void getPixel(){
		string xrandrOut;
		try {
	 	Process.spawn_command_line_sync("xrandr",out xrandrOut);
		int s1=xrandrOut.index_of("current");
		int s2=xrandrOut.index_of("\n");
		string keyStr=xrandrOut.substring(s1,s2-s1);
		MatchInfo info;
		if (/current ([0-9]+) x ([0-9]+)/.match (keyStr, 0, out info)) {
			this.width=int.parse(info.fetch(1));
			this.height=int.parse(info.fetch(2));
		}else{
			stdout.printf("无法获取正确的屏幕分辨率,请手动配置");
		}
		}catch (SpawnError e) {
			stdout.printf ("调用系统命令获取分辨率时出错,Error: %s\n", e.message);
		}
	}

	
	 public static void main(string[] args){
		Screen screen=new Screen();
		screen.getPixel();
		stdout.printf("width=%d\n",screen.width);
		stdout.printf("height=%d\n",screen.height);
		}
}
