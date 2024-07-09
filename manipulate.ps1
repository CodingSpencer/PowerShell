<#
Script name: manipulate.ps1
Course: CIT 361
Date: 6/4/2024
Authors: Spencer A and Spencer W
Affidavit: We affirm this script is our original work.
Citations: We leveraged ideas and help from the following sources:
    -- <ChatGPT, https://chat.openai.com/>
    -- <etc.>
#> 

function Get-MACVendor {
    param ([string]$MACAddress, [Parameter(Mandatory=$true)][string]$DatabasePath)
    if (Test-Path $DatabasePath) {
        Write-Host "This file exists."
    } else {
        Throw "This file cannot be found."
    }

    function Get-Vendor {
        param (
            $macPrefix, $database
        )
        
        foreach ($line in Get-Content $database | Where-Object {$_ -notmatch '^#'}) {
            $parts = ($line -split '\s+').Trim()
            if ($parts[0] -eq $macPrefix) {
                return $parts[2..($parts.Length - 1)] -join ' '
            }
        }
        return "Unknown Vendor"
    }

    function Normalize-MAC {
        param (
            $MACAddress
        )
        $MACAddress = $MACAddress.ToUpper().Replace('-', ':').Replace('.', ':')
        $MACAddress = $MACAddress -replace '^(\w\w:\w\w:\w\w).+', '$1'
        return $MACAddress
    }

    if ($MACAddress) {
        $macPrefix = Normalize-MAC $MACAddress
        return Get-Vendor $macPrefix $DatabasePath
        # Get-WmiObject Win32_NetworkAdapter | Where-Object { $_.MACAddress -eq $MACAddress} | Write-Output "Name: $_.Name, MacAddress: $_.MacAddress"
    } else {
        $Addresses = @()

        if ($IsWindows) {
            $Addresses = Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | Select-Object -ExpandProperty MacAddress
        } elseif ($IsLinux) {
            $Addresses = (ip link show | Select-String 'link/ether (\w+:\w+:\w+:\w+:\w+:\w+)' -AllMatches).Matches | ForEach-Object{ $_.Groups[1].Value}
        }
        # Get-NetAdapter | ForEach-Object {
        #     $Addresses += "Name: $_.Name, MacAddress: $_.MacAddress"
        # }

        $Vendors = @()
        foreach ($mac in $Addresses) {
            $macPrefix = Normalize-MAC $mac
            $Vendors += Get-Vendor $macPrefix $DatabasePath
        }
        return $Vendors
    }
}

Get-MACVendor -MACAddress "00:00:2A:3B:4C:5D" -DatabasePath "C:\Users\sashc\Downloads\psfiles\data\MACDatabase.txt"
Get-MACVendor -DatabasePath "C:\Users\sashc\Downloads\psfiles\data\MACDatabase.txt"


function FormatSongs {
    param (
        [Parameter(Mandatory=$true)][string]$DatabasePath,
        [string]$OutPath
    )

    if(-Not (Test-Path $DatabasePath)) {
        throw "Database file not found: $DatabasePath"
    }

    $songs = Import-Csv $DatabasePath -Delimiter "`t" -Header "Title", "Album", "Year", "Notes"
    $albums = $songs | Group-Object -Property Album | Sort-Object @{Expression="Group[0].Year"; Descending=$true}

    $report = ""
    foreach ($album in $albums) {
        $report += "Album: $($album.Name) ($($album.Group[0].Year))`n"
        $sortedSongs = $album.Group | Sort-Object Title
        foreach ($song in $sortedSongs) {
            $report += "    $($song.Title)`n"
        }
        $report += "`n"
    }

    if ($OutPath) {
        try {
            $report | Out-File $OutPath
        } catch {
            throw "Unable to write to file: $OutPath"
        }
    } else {
        return $report
    }
}

FormatSongs "C:\Users\sashc\Downloads\psfiles\data\RushSongs.txt" -OutPath "C:\Users\sashc\Downloads\psfiles\output\RushSongsReport.txt"