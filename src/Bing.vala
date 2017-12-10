public class Bing:Object 
{
	//配置文件及壁纸存放目录
	public string confDir 
	{
		get;
		set;
	}
	public Bing() 
	{
		this.confDir=Environment.get_home_dir ()+"/baiwall/";
		var dir= File.new_for_path (this.confDir);
		if (!dir.query_exists ()) 
		{
			dir.make_directory ();
		}
	}
	public void fetch() 
	{
		var uri = "https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8";
		var session = new Soup.Session ();
		var msg = new Soup.Message ("GET", uri);
		session.send_message (msg);
		var co=msg.status_code.to_string();
		int statusCode=int.parse(co);
		if(statusCode!=200) 
		{
			stdout.printf ("请求Bing Api接口异常");
		}
		File file = File.new_for_path (this.confDir+"bing.json");
		try 
		{
			FileOutputStream os = file.create (FileCreateFlags.NONE);
			var data_stream = new DataOutputStream (os);
			data_stream.put_string ((string) msg.response_body.data);
		}
		catch (Error e) 
		{
			stdout.printf ("Error: %s\n", e.message);
		}
	}
  
	public void parseJson() 
	{
		var file = File.new_for_path (this.confDir+"bing.json");
		Screen screen=new Screen();
		screen.getPixel();
		if(screen.width==0 || screen.height==0 ) 
		{
			screen.width=1920;
			screen.height=1080;
		}
		string downloadPixel=screen.width.to_string()+"x"+screen.height.to_string();
		try 
		{
			var dis = new DataInputStream (file.read ());
			string line = dis.read_line (null);
			var parser = new Json.Parser ();
			parser.load_from_data(line);
			var root_object = parser.get_root ().get_object ();
			var results = root_object.get_array_member ("images");
			int64 count = results.get_length ();
			stdout.printf ("got %lld results:\n\n", count);
			var session = new Soup.Session ();
			foreach (var img in results.get_elements ()) 
			{
				var imgo = img.get_object ();
				var url="https://cn.bing.com"+imgo.get_string_member ("urlbase")+"_"+downloadPixel+".jpg";
				stdout.printf("下载路径:%s\n",url);
				// 开始下载了
				var message = new Soup.Message ("GET",url);
				session.send_message (message);
				string picDownUrl=imgo.get_string_member ("fullstartdate")+"_"+downloadPixel+".jpg";
				File filejpg = File.new_for_path (this.confDir+picDownUrl);
				if (!filejpg.query_exists ()) 
				{
					//已存在就不去下载了
					FileOutputStream os = filejpg.create (FileCreateFlags.REPLACE_DESTINATION);
					var dos = new DataOutputStream (os);
					uint8[] data = message.response_body.data;
					long written = 0;
					while (written < data.length) 
					{
						written += dos.write (data[written:data.length]);
					}
				} else 
				{
					stdout.printf("文件 %s 已存在跳过\n",picDownUrl);
				}
			}
		}
		catch (Error e) 
		{
			stdout.printf ("Error: %s\n", e.message);
		}
	}
  
	public static void main(string[] args) 
	{
		Bing bing=new Bing();
		bing.fetch();
		bing.parseJson();
	}
}
