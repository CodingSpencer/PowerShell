enum colors{
    red = 0;
    blue = 1;
    green = 2
}

Class Circle{
    static $Pi=3.1415927
    [double]$Diameter
    [colors]$Color
    Circle([double]$Diameter){
        $this.Diameter = $Diameter
    }
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

# $c1 = [Circle]@{Diameter=12; Color="blue"}
# [Circle]::Pi

# [Circle]::Area(2.5)

# [Circle]::Circumference(3.75)

# $c1=[Circle]::New()
# $c1.Diameter=8
# $c1.Area()

# $c3=[Circle]::New(12)
# $c3

# $c5=[Circle]::new()
# $c5.Diameter

Class Column:Circle {
    [double]$Height
    Column([double]$Diameter,[double]$Height):base($Diameter){
        $this.Height=$Height
        $this.Diameter=$Diameter
    }
    static [double] Volume([double]$Diameter,[double]$Height){
        return [Circle]::Area($Diameter) * $Height
    }
    [double]Volume(){
        return $this.Area() * $this.Height
    }
}


[Column]::Volume(2,2)

[Column]::new(4,10).Volume()

# [enum]::GetNames([colors])

[colors]$v='red'
$v='BLUE'
$v

[Column]::new(4,10).Color
