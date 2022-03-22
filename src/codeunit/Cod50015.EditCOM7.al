codeunit 50015 "PWD Edit COM7"
{
    TableNo = "Purch. Rcpt. Header";
    trigger OnRun()
    begin
        CLEAR(Locationlist);
        CLEAR(CleRestitList);
        CLEAR(CustomsLine);
        CustomsLine.SETCURRENTKEY("Document Type", "Document No.", "Location Code");
        CustomsLine.SETRANGE("Document Type", CustomsLine."Document Type"::"P.Receipt");
        CustomsLine.SETRANGE("Document No.", "No.");
        CustomsLine.SETRANGE("Customs Document Type", CustomsLine."Customs Document Type"::COM7);
        IF NOT CustomsLine.FIND('-') THEN BEGIN
            PurchReceiptLine.RESET();
            PurchReceiptLine.SETCURRENTKEY("Document No.", Type, "Location Code", "PWD Cle (restitution)");
            PurchReceiptLine.SETRANGE("Document No.", "No.");
            PurchReceiptLine.SETRANGE(Type, PurchReceiptLine.Type::Item);
            PurchReceiptLine.SETFILTER("Location Code", '5');
            PurchReceiptLine.SETFILTER("PWD Cle (restitution)", '<>%1', '');
            PurchReceiptLine.SETFILTER(Quantity, '<>0');
            IF PurchReceiptLine.FIND('-') THEN BEGIN
                CLEAR(CustomsLine);
                REPEAT
                    IF CurrentCleRest <> PurchReceiptLine."PWD Cle (restitution)" THEN BEGIN
                        i += 1;
                        Locationlist[i] := PurchReceiptLine."Location Code";
                        CleRestitList[i] := PurchReceiptLine."PWD Cle (restitution)";
                        CurrentCleRest := PurchReceiptLine."PWD Cle (restitution)";
                        CustomsLine.RESET();
                        IF CustomsLine.FIND('+') THEN
                            NextLineNo := CustomsLine."Entry No." + 1 ELSE
                            NextLineNo := 1;
                        IF CustomsLine.RECORDLEVELLOCKING THEN
                            CustomsLine.LOCKTABLE();
                        CustomsLine.RESET();
                        CustomsLine.INIT();
                        CustomsLine."Entry No." := NextLineNo;
                        CustomsLine."Document Type" := CustomsLine."Document Type"::"P.Receipt";
                        CustomsLine."Document No." := "No.";
                        CustomsLine."Customs Document Type" := CustomsLine."Customs Document Type"::COM7;
                        CustomsLine."Location Code" := PurchReceiptLine."Location Code";
                        CustomsLine."Cle (restitution)" := PurchReceiptLine."PWD Cle (restitution)";
                        IF NOT ItemRestit.GET(CustomsLine."Cle (restitution)") THEN ItemRestit.INIT();
                        CustomsLine."Cle Description" := ItemRestit.Designation;
                        IF NOT EntryPoint.GET("Entry Point") THEN
                            EntryPoint.INIT();
                        IF "Entry Point" = '' THEN EntryPoint.GET('001');
                        CustomsLine."Pays d origine" := EntryPoint.Description;
                        CustomsLine.INSERT();
                    END;
                UNTIL PurchReceiptLine.NEXT() = 0;
            END;
            NumberCom7(Rec);
        END;
        PurchReceiptLine.RESET();
        PurchReceiptLine.SETCURRENTKEY("Document No.", Type, "Location Code", "PWD Cle (restitution)");
        PurchReceiptLine.SETRANGE("Document No.", "No.");
        PurchReceiptLine.SETRANGE(Type, PurchReceiptLine.Type::Item);
        PurchReceiptLine.SETFILTER("Location Code", '5');
        PurchReceiptLine.SETFILTER("PWD Cle (restitution)", '<>%1', '');
        PurchReceiptLine.SETFILTER(Quantity, '<>0');
        IF PurchReceiptLine.FIND('-') THEN BEGIN
            CLEAR(CustomsLine);
            REPEAT
                IF CurrentCleRest <> PurchReceiptLine."PWD Cle (restitution)" THEN BEGIN
                    i += 1;
                    Locationlist[i] := PurchReceiptLine."Location Code";
                    CleRestitList[i] := PurchReceiptLine."PWD Cle (restitution)";
                    CurrentCleRest := PurchReceiptLine."PWD Cle (restitution)";
                END;
            UNTIL PurchReceiptLine.NEXT() = 0;
        END;
        FOR j := 1 TO 50 DO BEGIN
            PurchReceiptLine.RESET();
            PurchReceiptLine.SETCURRENTKEY("Document No.", Type, "Location Code", "PWD Cle (restitution)");
            PurchReceiptLine.SETRANGE("Document No.", "No.");
            PurchReceiptLine.SETRANGE(Type, PurchReceiptLine.Type::Item);
            PurchReceiptLine.SETRANGE("Location Code", Locationlist[j]);
            PurchReceiptLine.SETRANGE("PWD Cle (restitution)", CleRestitList[j]);
            PurchReceiptLine.SETFILTER(Quantity, '<>0');
            IF PurchReceiptLine.FIND('-') THEN BEGIN
                CLEAR(TotalGrossWeight);
                CLEAR(TotalNetWeight);
                CLEAR(TotalParcel);
                CLEAR(TotalStatValue);
                REPEAT
                    TotalGrossWeight += PurchReceiptLine.Quantity * PurchReceiptLine."Gross Weight";
                    TotalNetWeight += PurchReceiptLine.Quantity * PurchReceiptLine."Net Weight";
                    TotalParcel += PurchReceiptLine."PWD Parcel Nb.";
                    TotalStatValue += PurchReceiptLine.Quantity * PurchReceiptLine."Unit Cost (LCY)";
                    CLEAR(CustomsLine);
                    CustomsLine.SETCURRENTKEY("Document Type", "Document No.", "Customs Document Type", "Location Code", "Cle (restitution)");
                    CustomsLine.SETRANGE("Document Type", CustomsLine."Document Type"::"P.Receipt");
                    CustomsLine.SETRANGE("Document No.", "No.");
                    CustomsLine.SETRANGE("Customs Document Type", CustomsLine."Customs Document Type"::COM7);
                    CustomsLine.SETRANGE("Location Code", Locationlist[j]);
                    CustomsLine.SETRANGE("Cle (restitution)", CleRestitList[j]);
                    IF CustomsLine.FIND('-') THEN BEGIN
                        CustomsLine."Gross Weight" := TotalGrossWeight;
                        CustomsLine."Net Weight" := TotalNetWeight;
                        CustomsLine."Parcel nb." := TotalParcel;
                        CustomsLine."Stat Value" := TotalStatValue;
                        CustomsLine.MODIFY();
                    END;
                UNTIL PurchReceiptLine.NEXT() = 0;
            END;
        END;
        CLEAR(CustomsLine);
        CustomsLine.SETCURRENTKEY("Document Type", "Document No.", "Location Code");
        CustomsLine.SETRANGE("Document Type", CustomsLine."Document Type"::"P.Receipt");
        CustomsLine.SETRANGE("Document No.", "No.");
        FOR i := 1 TO 50 DO BEGIN
            j := 0;
            CustomsLine.SETRANGE("Location Code", Locationlist[i]);
            CustomsLine.MODIFYALL("Total Line", CustomsLine.COUNT);
            CustomsLine.CALCSUMS("Parcel nb.");
            CustomsLine.MODIFYALL("Total Parcel", CustomsLine."Parcel nb.");
            IF CustomsLine.FIND('-') THEN
                REPEAT
                    j += 1;
                    CustomsLine."Line No." := j;
                    CustomsLine.MODIFY();
                UNTIL CustomsLine.NEXT() = 0;
            CustomsLine.SETRANGE("Location Code");
        END;
    end;

    var
        PurchReceiptLine: Record "Purch. Rcpt. Line";
        CustomsLine: Record "PWD Ligne document Douane";
        CurrentCleRest: Code[20];
        CurrentLocation: Code[20];
        NextLineNo: Integer;
        Locationlist: array[50] of Code[20];
        i: Integer;
        j: Integer;
        CleRestitList: array[100] of Code[20];
        TotalGrossWeight: Decimal;
        TotalNetWeight: Decimal;
        TotalParcel: Decimal;
        TotalStatValue: Decimal;
        PurchSetup: Record "Purchases & Payables Setup";
        ItemRestit: Record "PWD Item Restitution";
        EntryPoint: Record "Entry/Exit Point";

    procedure NumberCom7(PurchReceiptHeader: Record "Purch. Rcpt. Header")
    var
        LastLocationCode: Code[20];
        NoSeriesMngt: Codeunit NoSeriesManagement;
        CurrentCustDocNo: Code[20];
    begin
        PurchSetup.GET();
        PurchSetup.TESTFIELD(PurchSetup."PWD Souche COM 7");
        CLEAR(LastLocationCode);
        CLEAR(CustomsLine);
        CustomsLine.SETCURRENTKEY("Document Type", "Document No.", "Location Code");
        CustomsLine.SETRANGE("Document Type", CustomsLine."Document Type"::"P.Receipt");
        CustomsLine.SETRANGE("Document No.", PurchReceiptHeader."No.");
        CustomsLine.SETRANGE("Customs Document Type", CustomsLine."Customs Document Type"::COM7);
        IF CustomsLine.FIND('-') THEN
            REPEAT
                IF (LastLocationCode <> CustomsLine."Location Code") THEN BEGIN
                    LastLocationCode := CustomsLine."Location Code";
                    CLEAR(CurrentCustDocNo);
                    CLEAR(NoSeriesMngt);
                    CurrentCustDocNo := NoSeriesMngt.GetNextNo(PurchSetup."PWD Souche COM 7", TODAY, TRUE);
                END;
                CustomsLine."Customs Doc. No." := CurrentCustDocNo;
                CustomsLine.MODIFY();
                AffectReceiveLines();
            UNTIL CustomsLine.NEXT() = 0;
    end;

    procedure AffectReceiveLines()
    begin
    end;
}

