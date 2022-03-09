# classe Abstrata Revista
class Revista {
    Assinar([Assinante] $Assinante) {}
    CancelarAssinatura([Assinante] $Assinante) {}
    NotificarAssinantes() {}
    AjustaMensalidade([int] $ValorDaAssinatura) {}
}

# classe concreta de Revista
class RevistaDeBairro: Revista {
    [System.Collections.Generic.List[object]]$ListaDeAssinantes
    [int] $ValorDaAssinatura = 100

    RevistaDeBairro() {
        $this.ListaDeAssinantes = @()
    }

    Assinar([Assinante] $Assinante) {
        $this.ListaDeAssinantes.Add($Assinante)
    }
    
    CancelarAssinatura([Assinante] $Assinante) {
        $this.ListaDeAssinantes.Remove($Assinante)
    }

    NotificarAssinantes() {
        foreach ($Assinante in $this.ListaDeAssinantes) {
            $Assinante.Atualizar($this.ValorDaAssinatura)
        }
    }

    AjustaMensalidade([int] $ValorDaAssinatura) {
        $this.ValorDaAssinatura = $ValorDaAssinatura
        $this.NotificarAssinantes()
    }
}
    

class Assinante {
    Atualizar([int] $ValorDaAssinatura) {
        Write-Host "Estou atualizando o valor da assinatura..."
        Write-Host "Este eh meu novo valor: " + $ValorDaAssinatura
    }
}

# concreto
class AssinanteAnual: Assinante {
    [Revista] $RevistaDeBairro

    AssinanteAnual([Revista] $RevistaDeBairro) {
        $this.RevistaDeBairro = $RevistaDeBairro
        $this.RevistaDeBairro.Assinar($this)
    }
}


[Revista] $RevistaOCentro = [RevistaDeBairro]::new()

[Assinante] $ZeDasCoves = [AssinanteAnual]::new($RevistaOCentro)
[Assinante] $BarbeiroNeves = [AssinanteAnual]::new($RevistaOCentro)


$RevistaOCentro.AjustaMensalidade(300)
