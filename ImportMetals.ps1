Set-Location C:\Users\sashc\Downloads\psfiles\data

Class Metal{ 
    [string]$Symbol
    [string]$Name
    [int]$MeltingPoint
    [float]$SpecificGravity
} 

$m1=[Metal]::New()
$m1.Symbol='Au' 
$m1.Name='Gold' 
$m1.MeltingPoint=1945 
$m1.SpecificGravity=19.3
$m1

$m2=New-Object Metal 
$m2.Symbol='Ag' 
$m2.Name ='Silver'
$m2.MeltingPoint = 1762
$m2.SpecificGravity = 10.6 
$m2 

$m3=[Metal]@{Symbol='Sn';Name='Tin';MeltingPoint=450;SpecificGravity=7.3} 
$m3 

$Metals=Import-Csv Metals.csv | ForEach-Object {[Metal]$_}
$Metals[2].GetType().FullName

