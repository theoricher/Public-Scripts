$github_repo = "buttercup/buttercup-desktop"
$release_info = Invoke-RestMethod -Uri "https://api.github.com/repos/$github_repo/releases/latest"
$version_name = $release_info.name
$version_number = $release_info.name.substring(1) 
Invoke-WebRequest -Uri "https://github.com/buttercup/buttercup-desktop/releases/download/$version/Buttercup-Setup-$version_number.exe" -OutFile "C:\temp\Buttercup-Setup-$version_number.exe"
Start-Process -FilePath "C:\temp\Buttercup-Setup-$version_number.exe" -ArgumentList '/s'