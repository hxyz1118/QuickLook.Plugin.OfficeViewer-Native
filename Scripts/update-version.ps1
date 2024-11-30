$tag = git describe --tags --abbrev=0
$revision = git describe --tags --always --abbrev=7  # 使用 Git 哈希的前 7 个字符

# 构建符合 .NET 版本号格式的版本字符串
$major = 1
$minor = 0
$build = 0
$revision = $revision.Substring(0, 7)  # 取前7位作为版本号的一部分

# 创建符合格式的版本字符串
$version = "$major.$minor.$build.$revision"

# 输出到 GitVersion.cs
$text = @"
using System.Reflection;
 
[assembly: AssemblyVersion("$version")]
[assembly: AssemblyInformationalVersion("$version")]
"@

# 写入文件
$text | Out-File $PSScriptRoot\..\GitVersion.cs -Encoding utf8
