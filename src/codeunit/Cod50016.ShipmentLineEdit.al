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
        SalesShptLine."Net Weight" := Rec."Net Weight";
        SalesShptLine."Gross Weight" := Rec."Gross Weight";
        SalesShptLine."PWD Cle (restitution)" := Rec."PWD Cle (restitution)";
        SalesShptLine."PWD Parcel Nb." := Rec."PWD Parcel Nb.";
        SalesShptLine."PWD Certified Origin" := Rec."PWD Certified Origin";
        SalesShptLine."PWD Origin Area" := Rec."PWD Origin Area";
        SalesShptLine."PWD DCG Tariff No." := Rec."PWD DCG Tariff No.";
        SalesShptLine."PWD National Add. Code" := Rec."PWD National Add. Code";
        SalesShptLine."PWD Monthly Code" := Rec."PWD Monthly Code";
        SalesShptLine."PWD Valeur douane (correction)" := Rec."PWD Valeur douane (correction)";
        SalesShptLine."PWD Provision/materiel" := Rec."PWD Provision/materiel";
        SalesShptLine.MODIFY();
        Rec := SalesShptLine;
    end;

    var
        SalesShptLine: Record "Sales Shipment Line";
}
