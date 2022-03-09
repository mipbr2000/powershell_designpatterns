class DocumentHandler {

    [DocumentHandler] $next



    DocumentHandler([DocumentHandler] $next) {

        $this.next = $next

    }



    [void] openDocument([String] $FileExtension) {

        if ($null -ne $FileExtension) {

            $this.next.openDocument($fileExtension);

        }

    }

}



class SlideshowHandler:  DocumentHandler {

    SlideshowHandler ([DocumentHandler] $handler) : base ($handler) {}

    

    [void] openDocument([String] $FileExtension) {

        if ("ppt" -eq $FileExtension) {

            Write-Host "Opening Slideshow document..."

        }

        else {

            ([DocumentHandler]$this).openDocument($FileExtension)

        }

    }



}



class SpreadsheetHandler:  DocumentHandler {

    SpreadsheetHandler ([DocumentHandler] $handler) : base ($handler) {}

    

    [void] openDocument([String] $FileExtension) {

        if ("xlsx" -eq $FileExtension) {

            Write-Host "Opening Spreadsheet document..."

        }

        else {

            ([DocumentHandler]$this).openDocument($FileExtension)

        }

    }



}



class TextDocumentHandler:  DocumentHandler {

    TextDocumentHandler ([DocumentHandler] $handler) : base ($handler) {}

    

    [void] openDocument([String] $FileExtension) {

        if ("txt" -eq $FileExtension) {

            Write-Host "Opening Text document..."

        }

        else {

            ([DocumentHandler]$this).openDocument($FileExtension)

        }

    }



}



class Client {

    static [void] Main() {

        [DocumentHandler] $Chain = [SlideshowHandler]::new([SpreadsheetHandler]::new([TextDocumentHandler]::new($null)))

        $Chain.openDocument("txt")

    }

}

[Client]::Main()
