Class Circle{
    static $Pi=3.1415927
    [double]$Diameter
    $Color
    Circle(){}
    static[double]Area([double]$Diameter){
        return [Circle]::Pi * [math]::pow($Diameter/2,2)
    }
    static[double]Circumference([double]$Diameter){
        return [Circle]::Pi * $Diameter
    }
    [double]Area() { 
        $d = $this.Diameter 
        return [Circle]::Pi * [math]::pow($d/2,2) 
    }     
}

$c1 = [Circle]@{Diameter=12; Color="blue"}
[Circle]::Pi

[Circle]::Area(2.5)

[Circle]::Circumference(3.75)

$c1=[Circle]::New()
$c1.Diameter=8
$c1.Area()

$c3=[Circle]::New(12)
$c3

$c5=[Circle]::new()
$c5.Diameter


