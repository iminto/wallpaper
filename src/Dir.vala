public class Dir:Object{

/**
*列出当前指定目录下的文件,排除子文件夹和子文件夹下的文件
**/
public string[] listFiles(string? path){
	string[] files={};
	try {	
        var directory = File.new_for_path (path??".");
        var enumerator = directory.enumerate_children (FileAttribute.STANDARD_NAME, 0);
        FileInfo fileInfo;
        while ((fileInfo = enumerator.next_file ()) != null) {
	    if(fileInfo.get_file_type () == FileType.DIRECTORY){continue;};
	    files+=fileInfo.get_name ();
        }
	return files;
    } catch (Error e) {
        stderr.printf ("列文件异常,Error: %s\n", e.message);
        return files;
    }
}
/**
*列出当前目录下的所有图片,vala不支持overload
*/
public string[] listFilesWithImage(string? path){
	string[] files=listFiles(path);
	string[] images={};
	foreach(string file in files){
	  if(file.has_suffix(".jpg")||file.has_suffix(".jpeg")||file.has_suffix(".png")||
		file.has_suffix(".gif")||file.has_suffix(".JPG")){
		images+=file;
		}else{
		
		}
	}
	return images;
}


}
