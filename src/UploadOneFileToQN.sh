#这对单个文件上传到七牛云 返回 md访问链接
filePath=$1
fileName=$(date +%Y%m%d%H%M%S | md5)
fileType=${filePath##*.}
fullName=${fileName}.${fileType}
cd /Users/yihuineng/QNCloud/CLI
./qshell rput image ${fullName} ${filePath} true
copyUrl=![](http://image.yihuineng.com/${fullName}.logo)
echo ${copyUrl} | pbcopy
