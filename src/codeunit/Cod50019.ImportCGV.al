codeunit 50019 "PWD Import CGV"
{

    trigger OnRun()
    begin
        Fichier.TEXTMODE := TRUE;
        Fichier.OPEN('c:\avita\CGV.txt');
        NextLineNo += 1000;

        REPEAT
            Fichier.READ(TexteLu);
            NextLineNo += 100;
            CGVLine.INIT();
            //Todo
            CGVLine."Code regime" := NextLineNo;
            CGVLine."Periode DCG" := AnsiToAscii.AnsiToAscii(TexteLu);
            CGVLine.INSERT();
            Fichier.SEEK(Fichier.POS);
        UNTIL Fichier.POS = Fichier.LEN;
    end;

    var
        I: Integer;
        Fichier: File;
        TexteLu: Text[1024];
        AnsiToAscii: Codeunit "PWD ConvertAscii I";
        NextLineNo: Integer;
        CGVLine: Record "PWD Liste DCG";
}

