<#
Program Name : color.ps1
Date: 20241605
Author: SPencer Ashcraft
Course CIT361
I, Spencer Ashcraft, affirm that I wrote this script as original work completed by me.
#>

#Select a console color at random
$SystemColors=[System.Enum]::GetValues([System.ConsoleColor])
$colorAnswer = $SystemColors | Get-Random
$guesses = @()
$counter = 0

function Show-Hint {
    $hint = $colorAnswer.ToString()
    if ($hint.StartsWith("Dark")) {
        $hint = "Dark" + $hint.Substring(4,1)
    } else {
        $hint = $hint.Substring(0,1)
    }
    return $hint
}

function Get-Time {
    param (
        $start
    )
    Start-Sleep -Seconds 2
    $end = Get-Date
    $seconds = $end - $start
    Write-Host "It took you $("{0:N2}" -f $seconds.TotalSeconds) seconds to guess the color."
}

$colorAnswer
while ($guess -ne $colorAnswer) {
    $guess = Read-Host "Guess my favorite color"
    $guesses += $guess
    $counter++
    $start = Get-Date
    if ($SystemColors -contains $guess) {
        if ($guess -eq $colorAnswer) {
            Write-Host "Correct! $guess is my favorite color."
            Write-Host "It took you $counter guesses"
            Get-Time($start)
        } else {
            Write-Host "$guess is not my favorite. Guess again!"
        }
    } elseif ($guess -eq "hint") {
        Show-Hint
    } elseif ($guess -eq "Wrong") {
        $incorrect = $guesses -join ", "
        $incorrect
    } elseif ($guess -eq "Quit") {
        $guess = $colorAnswer
    } else {
        Write-Host "That is not a value in the color list. Guess again!"
    }   
}
