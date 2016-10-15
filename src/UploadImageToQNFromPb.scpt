property fileTypes : {¬
	{«class PNGf», ".png"}, ¬
	{JPEG picture, ".jpg"}}
on getType()
	repeat with aType in fileTypes
		repeat with theInfo in (clipboard info)
			if (first item of theInfo) is equal to (first item of aType) then return aType
		end repeat
	end repeat
	return missing value
end getType
set theType to getType()
if theType is not missing value then
	set filePath to "/Users/yihuineng/QNCloud/data/" --这里换成你自己放置图片的路径
	set fileName to do shell script "date \"+%Y%m%d%H%M%S\" | md5" --用当前时间的md5值做文件名
	if fileName does not end with (second item of theType) then set fileName to (fileName & second item of theType as text) --加文件后缀
	set markdownUrl to "![](http://image.yihuineng.com/" & fileName & ".logo)" --这里是你的七牛域名和设置的图片样式
	set filePath to filePath & fileName
	try
		set imageFile to (open for access filePath with write permission)
		set eof imageFile to 0
		write (the clipboard as (first item of theType)) to imageFile
		close access imageFile
		set scriptstr to "cd /Users/yihuineng/QNCloud/CLI; ./qshell rput image " & fileName & " " & filePath & " true;rm -rf /Users/yihuineng/QNCloud/data/*"
		do shell script scriptstr --此处是你的Qn脚本目录和命令
		set the clipboard to markdownUrl
		try
			tell application "System Events"
				keystroke "v" using command down
			end tell
		end try

	on error
		try
			close access imageFile
		end try
		return "error"
	end try
else
	return "missing value"
end if
