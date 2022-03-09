class Command {
    # Declara uma interface para comandos abstratos como Execute().
    Execute() {}
}

class Receiver {
    # Sabe como executar um comando particular.
    SwitchOn() {
        Write-Host "Switch on from: " $this.GetType().Name
    }
}

class OnCommand: Command {
    [Receiver] $Receiver

    OnCommand([Receiver] $Receiver) {
        $this.Receiver = $Receiver
    }
    Execute() {
        $this.Receiver.SwitchOn()
    }
}

class Invoker {
    [Command] $Command

    Invoker([Command] $Command) {
        $this.Command = $Command
    }

    Execute() {
        $this.Command.Execute()
    }
}

class TV: Receiver {
    [String] toString() {
        return $this.GetType().Name
    }
}

class DVDPlayer: Receiver {
    [String] toString() {
        return $this.GetType().Name
    }
}

class Main {
    Main() {
        # Receiver é quem recebe o sabe como realizar o comando.
        [Receiver] $Receiver = [TV]::new()
        # O Comando do tipo OnCommand recebe o receiver acima.
        [Command] $OnCommand = [OnCommand]::new($Receiver)
        # O invoker recebe o OnCommand acima, que tem o receiver
        [Invoker] $Invoker = [Invoker]::new($OnCommand)
        # O comando é chamado pelo Invoker.
        $Invoker.Execute()
        
        # On command for DVDPlayer with same invoker
        [Receiver] $Receiver = [DVDPlayer]::new()
        [Command] $OnCommand = [OnCommand]::new($Receiver)
        [Invoker] $Invoker = [Invoker]::new($OnCommand)
        $Invoker.Execute()
    }
}

[Main]::new()
