public class Bing:Object 
{
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
			stdout.printf ("请求接口异常");
		}
		//var home_dir = File.new_for_path (Environment.get_home_dir ());
		File file = File.new_for_path ("bing.json");
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

	public void parseJson(){
		var file = File.new_for_path ("bing.json");
		try 
		{
			var dis = new DataInputStream (file.read ());
        		string line = dis.read_line (null);
			stdout.printf(line);
		}
		catch (Error e) 
		{
			stdout.printf ("Error: %s\n", e.message);
		}
	}

	public static void main(string[] args) 
	{
		Bing bing=new Bing();
		bing.parseJson();
	}
}
