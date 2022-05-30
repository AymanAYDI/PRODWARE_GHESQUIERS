codeunit 50008 "PWD Cr.Memo Line - Edit"
{
    Permissions = TableData "Sales Cr.Memo Line" = m;
    TableNo = "Sales Cr.Memo Line";

    trigger OnRun()
    begin
        SalesCRMemoLine := Rec;
        SalesCRMemoLine.LOCKTABLE();
        SalesCRMemoLine.FIND();
        SalesCRMemoLine."Net Weight" := Rec."Net Weight";
        SalesCRMemoLine."Gross Weight" := Rec."Gross Weight";
        SalesCRMemoLine."PWD Cle (restitution)" := Rec."PWD Cle (restitution)";
        SalesCRMemoLine."PWD Parcel Nb." := Rec."PWD Parcel Nb.";
        SalesCRMemoLine."PWD Origin Area" := Rec."PWD Origin Area";
        SalesCRMemoLine."PWD DCG Tariff No." := Rec."PWD DCG Tariff No.";
        SalesCRMemoLine."PWD National Add. Code" := Rec."PWD National Add. Code";
        SalesCRMemoLine."PWD Monthly Code" := Rec."PWD Monthly Code";
        SalesCRMemoLine."PWD Valeur douane (correction)" := Rec."PWD Valeur douane (correction)";
        SalesCRMemoLine.MODIFY();
        Rec := SalesCRMemoLine;
    end;

    var
        SalesCRMemoLine: Record "Sales Cr.Memo Line";
}
