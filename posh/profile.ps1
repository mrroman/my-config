function up-dir {
	cd ..
}

function open-vim {
    gvim --remote-silent $args
}

function login-time {
    $today = (Get-Date).DayOfYear 
    Get-EventLog System | Where-Object  { $_.EventId -eq '1' -and $_.Source -match 'Kernel-General' -and $_.TimeGenerated.DayOfYear -eq $today } | Select-Object -Last 1 -Property "TimeGenerated" | ft -HideTableHeaders
}

function edit-config {
    v $HOME\Documents\windowspowershell\profile.ps1
}

set-alias '..' up-dir
set-alias c cd
set-alias l ls
set-alias v open-vim
