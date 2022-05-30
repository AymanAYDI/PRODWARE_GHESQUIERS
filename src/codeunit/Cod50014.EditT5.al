codeunit 50014 "PWD Edit T5"
{
    TableNo = "Sales Shipment Header";

    trigger OnRun()
    begin
        CLEAR(Locationlist);
        CLEAR(CleRestitList);
        CLEAR(CustomsLine);
        CustomsLine.SETCURRENTKEY("Document Type", "Document No.", "Location Code");
        CustomsLine.SETRANGE("Document Type", CustomsLine."Document Type"::"S.Shipment");
        CustomsLine.SETRANGE("Document No.", Rec."No.");
        CustomsLine.SETRANGE("Customs Document Type", CustomsLine."Customs Document Type"::T5);
        IF NOT CustomsLine.FIND('-') THEN BEGIN
            CLEAR(Locationlist);
            CLEAR(CleRestitList);
            CLEAR(CustomsLine);
            SalesShipmentLine.RESET();
            SalesShipmentLine.SETCURRENTKEY("Document No.", Type, "Location Code", "PWD Cle (restitution)");
            SalesShipmentLine.SETRANGE("Document No.", Rec."No.");
            SalesShipmentLine.SETRANGE(Type, SalesShipmentLine.Type::Item);
            SalesShipmentLine.SETFILTER("Location Code", '3|5|6');
            SalesShipmentLine.SETFILTER("PWD Cle (restitution)", '<>%1', '');
            SalesShipmentLine.SETFILTER(Quantity, '<>0');
            IF SalesShipmentLine.FIND('-') THEN
                REPEAT
                    IF CurrentCleRest <> SalesShipmentLine."PWD Cle (restitution)" THEN BEGIN
                        i += 1;
                        Locationlist[i] := SalesShipmentLine."Location Code";
                        CleRestitList[i] := SalesShipmentLine."PWD Cle (restitution)";
                        CurrentCleRest := SalesShipmentLine."PWD Cle (restitution)";
                        CustomsLine.RESET();
                        IF CustomsLine.FIND('+') THEN
                            NextLineNo := CustomsLine."Entry No." + 1 ELSE
                            NextLineNo := 1;
                        IF CustomsLine.RECORDLEVELLOCKING THEN
                            CustomsLine.LOCKTABLE();
                        CustomsLine.RESET();
                        CustomsLine.INIT();
                        CustomsLine."Entry No." := NextLineNo;
                        CustomsLine."Document Type" := CustomsLine."Document Type"::"S.Shipment";
                        CustomsLine."Document No." := Rec."No.";
                        CustomsLine."Customs Document Type" := CustomsLine."Customs Document Type"::T5;
                        CustomsLine."Location Code" := SalesShipmentLine."Location Code";
                        CustomsLine."Cle (restitution)" := SalesShipmentLine."PWD Cle (restitution)";
                        IF NOT ItemRestit.GET(CustomsLine."Cle (restitution)") THEN ItemRestit.INIT();
                        CustomsLine."Cle Description" := ItemRestit.Designation;
                        CustomsLine.INSERT();
                    END;
                UNTIL SalesShipmentLine.NEXT() = 0;
            NumberT5(Rec);
        END;

        SalesShipmentLine.RESET();
        SalesShipmentLine.SETCURRENTKEY("Document No.", Type, "Location Code", "PWD Cle (restitution)");
        SalesShipmentLine.SETRANGE("Document No.", Rec."No.");
        SalesShipmentLine.SETRANGE(Type, SalesShipmentLine.Type::Item);
        SalesShipmentLine.SETFILTER("Location Code", '3|5|6');
        SalesShipmentLine.SETFILTER("PWD Cle (restitution)", '<>%1', '');
        SalesShipmentLine.SETFILTER(Quantity, '<>0');
        IF SalesShipmentLine.FIND('-') THEN
            REPEAT
                IF CurrentCleRest <> SalesShipmentLine."PWD Cle (restitution)" THEN BEGIN
                    i += 1;
                    Locationlist[i] := SalesShipmentLine."Location Code";
                    CleRestitList[i] := SalesShipmentLine."PWD Cle (restitution)";
                    CurrentCleRest := SalesShipmentLine."PWD Cle (restitution)";
                END;
            UNTIL SalesShipmentLine.NEXT() = 0;

        FOR j := 1 TO 50 DO BEGIN
            SalesShipmentLine.RESET();
            SalesShipmentLine.SETCURRENTKEY("Document No.", Type, "Location Code", "PWD Cle (restitution)");
            SalesShipmentLine.SETRANGE("Document No.", Rec."No.");
            SalesShipmentLine.SETRANGE(Type, SalesShipmentLine.Type::Item);
            SalesShipmentLine.SETRANGE("Location Code", Locationlist[j]);
            SalesShipmentLine.SETRANGE("PWD Cle (restitution)", CleRestitList[j]);
            SalesShipmentLine.SETFILTER(Quantity, '<>0');
            IF SalesShipmentLine.FIND('-') THEN BEGIN
                CLEAR(TotalGrossWeight);
                CLEAR(TotalNetWeight);
                CLEAR(TotalParcel);
                REPEAT
                    TotalGrossWeight += SalesShipmentLine.Quantity * SalesShipmentLine."Gross Weight";
                    TotalNetWeight += SalesShipmentLine.Quantity * SalesShipmentLine."Net Weight";
                    TotalParcel += SalesShipmentLine."PWD Parcel Nb.";
                UNTIL SalesShipmentLine.NEXT() = 0;

                CLEAR(CustomsLine);
                CustomsLine.SETCURRENTKEY("Document Type", "Document No.", "Customs Document Type", "Location Code", "Cle (restitution)");
                CustomsLine.SETRANGE("Document Type", CustomsLine."Document Type"::"S.Shipment");
                CustomsLine.SETRANGE("Document No.", Rec."No.");
                CustomsLine.SETRANGE("Customs Document Type", CustomsLine."Customs Document Type"::T5);
                CustomsLine.SETRANGE("Location Code", Locationlist[j]);
                CustomsLine.SETRANGE("Cle (restitution)", CleRestitList[j]);
                IF CustomsLine.FIND('-') THEN BEGIN
                    CustomsLine."Gross Weight" := TotalGrossWeight;
                    CustomsLine."Net Weight" := TotalNetWeight;
                    CustomsLine."Parcel nb." := TotalParcel;
                    CustomsLine.MODIFY();
                END;
            END;
        END;
        CLEAR(CustomsLine);
        CustomsLine.SETCURRENTKEY("Document Type", "Document No.", "Location Code");
        CustomsLine.SETRANGE("Document Type", CustomsLine."Document Type"::"S.Shipment");
        CustomsLine.SETRANGE("Document No.", Rec."No.");
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
        ItemRestit: Record "PWD Item Restitution";
        CustomsLine: Record "PWD Ligne document Douane";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesShipmentLine: Record "Sales Shipment Line";
        CleRestitList: array[100] of Code[20];
        CurrentCleRest: Code[20];
        Locationlist: array[50] of Code[20];
        TotalGrossWeight: Decimal;
        TotalNetWeight: Decimal;
        TotalParcel: Decimal;
        i: Integer;
        j: Integer;
        NextLineNo: Integer;

    procedure NumberT5(SalesShipHeader: Record "Sales Shipment Header")
    var
        NoSeriesMngt: Codeunit NoSeriesManagement;
        CurrentCustDocNo: Code[20];
        LastLocationCode: Code[20];
    begin
        SalesSetup.GET();
        SalesSetup.TESTFIELD("PWD Souche de T5");
        CLEAR(LastLocationCode);
        CLEAR(CustomsLine);
        CustomsLine.SETCURRENTKEY("Document Type", "Document No.", "Location Code");
        CustomsLine.SETRANGE("Document Type", CustomsLine."Document Type"::"S.Shipment");
        CustomsLine.SETRANGE("Document No.", SalesShipHeader."No.");
        CustomsLine.SETRANGE("Customs Document Type", CustomsLine."Customs Document Type"::T5);
        IF CustomsLine.FIND('-') THEN
            REPEAT
                IF (LastLocationCode <> CustomsLine."Location Code") THEN BEGIN
                    LastLocationCode := CustomsLine."Location Code";
                    CLEAR(CurrentCustDocNo);
                    CLEAR(NoSeriesMngt);
                    CurrentCustDocNo := NoSeriesMngt.GetNextNo(SalesSetup."PWD Souche de T5", TODAY, TRUE);
                END;

                CustomsLine."Customs Doc. No." := CurrentCustDocNo;
                CustomsLine.MODIFY();
            UNTIL CustomsLine.NEXT() = 0;
    end;
}
