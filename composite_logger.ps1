class ILogger {
    Log([String] $Message) {}
}

class CompositeLogger: ILogger {

    # Declarando um array de ILoggers
    [ILogger[]] $_loggers

    CompositeLogger([ILogger[]] $_loggers) {
        $this._loggers = $_loggers
    }

    Log([String] $Message) {
        foreach ($obj_logger in $this._loggers) {
            $obj_logger.Log($Message)
        }
    }
}

class ConsoleLogger: ILogger {
    Log([String] $Message) {
        Write-Host "Escrevendo no console."
        Write-Host "Esta é a mensagem: $Message."
    }
}

class FileLogger: ILogger {
    Log([String] $Message) {
        Write-Host "Escrevendo em arquivo."
        Write-Host "Esta é a mensagem: $Message."
    }
}

$MeuArrayDeLogs = @([ConsoleLogger]::new(), [FileLogger]::new())
[CompositeLogger] $CompositeLogger = [CompositeLogger]::new($MeuArrayDeLogs)
$CompositeLogger.Log("Esta eh a mensagem.")
