codeunit 50016 "PWD Shipment Line - Edit"
{
    Permissions = TableData "Sales Shipment Line" = m,
                  TableData "Sales Cr.Memo Line" = m;
    TableNo = "Sales Shipment Line";

    trigger OnRun()
    begin
        SalesShptLine := Rec;
        SalesShptLine.LOCKTABLE();
        SalesShptLine.FIND();
        SalesShptLine."Net Weight" := "Net Weight";
        SalesShptLine."Gross Weight" := "Gross Weight";
        SalesShptLine."Cle (restitution)" := "Cle (restitution)";
        SalesShptLine."PWD Parcel Nb." := "PWD Parcel Nb.";
        SalesShptLine."PWD Certified Origin" := "PWD Certified Origin";
        SalesShptLine."PWD Origin Area" := "PWD Origin Area";
        SalesShptLine."PWD DCG Tariff No." := "PWD DCG Tariff No.";
        SalesShptLine."PWD National Add. Code" := "PWD National Add. Code";
        SalesShptLine."PWD Monthly Code" := "PWD Monthly Code";
        SalesShptLine."Valeur douane (correction)" := "Valeur douane (correction)";
        SalesShptLine."PWD Provision/materiel" := "PWD Provision/materiel";
        SalesShptLine.MODIFY();
        Rec := SalesShptLine;
    end;

    var
        SalesShptLine: Record "Sales Shipment Line";
}

