class Car {}
class Manual {}

class Builder {
    Reset() {}
    SetSeats([int] $NumeroDeAssentos) {}
    SetEngine([String] $TipoDeMotor) {}
    SetTripComputer([String] $TipoComputadorBordo) {}
    SetGPS([String] $TipoGPS) {}
}

class CarBuilder: Builder {
    [Car] $Car
    
    CarBuilder() {
        $this.Reset()
    }
    
    Reset() {
        $this.Car = [Car]::new()
    }
    
    SetSeats([int] $NumeroDeAssentos) {
        Write-Host "O numero de assentos deste carro é: " $NumeroDeAssentos
    }
    SetEngine([String] $TipoDeMotor) {
        Write-Host "O tipo de motor deste carro é: " $TipoDeMotor
    }
    SetTripComputer([String] $TipoComputadorBordo) {
        Write-Host "O tipo de Computador de Bordo deste carro é: " $TipoComputadorBordo
    }
    SetGPS([String] $TipoGPS) {
        Write-Host "O tipo de GPS deste carro é: " $TipoGPS
    }

    [Car] GetProduct() {
        $Product = $this.Car
        $this.Reset()
        return $Product
    }

}
class CarManualBuilder: Builder {
    [Manual] $Manual
    
    CarManualBuilder() {
        $this.Reset()
    }
    
    Reset() {
        $this.Manual = [Manual]::new()
    }
    
    SetSeats([int] $NumeroDeAssentos) {
        Write-Host "O numero de assentos deste carro é: " $NumeroDeAssentos
    }
    SetEngine([String] $TipoDeMotor) {
        Write-Host "O tipo de motor deste carro é: "$TipoDeMotor
    }
    SetTripComputer([String] $TipoComputadorBordo) {
        Write-Host "O tipo de Computador de Bordo deste carro é: " $TipoComputadorBordo
    }
    SetGPS([String] $TipoGPS) {
        Write-Host "O tipo de GPS deste carro é: " $TipoGPS
    }

    [Manual] GetProduct() {
        $Product = $this.Manual
        $this.Reset()
        return $Product
    }

}

class Director {

    [Builder] $Builder

    SetBuilder([Builder] $Builder) {
        $this.Builder = $Builder
    }
    
    ConstructSportsCar([Builder] $Builder) {
        $this.Builder = $Builder
        $this.Builder.Reset()
        $this.Builder.SetSeats(2)
        $this.Builder.SetEngine("Super Motor")
        $this.Builder.SetTripComputer("Super Computador")
        $this.Builder.SetGPS("Super GPS")
    }
    
    ConstructSUV([Builder] $Builder) {
        $this.Builder = $Builder
        $this.Builder.Reset()
        $this.Builder.SetSeats(6)
        $this.Builder.SetEngine("Motor popular.")
        $this.Builder.SetTripComputer("Computador popular.")
        $this.Builder.SetGPS("GPS popular.")
    }
}

class Application {
    MakeCar() {
        $Director = [Director]::new()
        
        [Builder] $Builder = [CarBuilder]::new()
        $Director.ConstructSportsCar($Builder)
        [Car] $Car = $Builder.GetProduct()


        [Builder] $Builder = [CarBuilder]::new()
        $Director.ConstructSUV($Builder)
        [Car] $Car = $Builder.GetProduct()

        
        
        [Builder] $Builder = [CarManualBuilder]::new()
        $Director.ConstructSportsCar($Builder)
        
        # O produto final é frequentemente retornado de um
        # objeto Builder uma vez que o diretor não está
        # ciente e não é dependente de Builders e produtos
        # concretos.
        [Manual] $Manual = $Builder.GetProduct()
    }

}

[Application] $Application = [Application]::new()
$Application.MakeCar()
