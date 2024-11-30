# 删除已有的 .qlplugin 文件（如果存在）
Remove-Item ..\QuickLook.Plugin.OfficeViewer.qlplugin -ErrorAction SilentlyContinue

# 检查 'bin\Release' 目录是否存在
$releaseDir = "..\bin\Release"
if (-Not (Test-Path $releaseDir)) {
    Write-Host "Directory $releaseDir does not exist. Exiting script."
    exit 1
}

# 获取 bin\Release 目录下的文件（排除 .pdb 和 .xml 文件）
$files = Get-ChildItem -Path $releaseDir -Exclude *.pdb,*.xml

# 检查是否找到了文件
if ($files.Count -eq 0) {
    Write-Host "No files found in $releaseDir"
    exit 1
}

# 打包文件为 .zip 格式
Compress-Archive -Path $files -DestinationPath ..\QuickLook.Plugin.OfficeViewer.zip

# 将生成的 zip 文件重命名为 .qlplugin
Move-Item ..\QuickLook.Plugin.OfficeViewer.zip ..\QuickLook.Plugin.OfficeViewer.qlplugin
