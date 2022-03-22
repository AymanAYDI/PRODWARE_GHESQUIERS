codeunit 50008 "PWD Cr.Memo Line - Edit"
{
    Permissions = TableData "Sales Cr.Memo Line" = m;
    TableNo = "Sales Cr.Memo Line";

    trigger OnRun()
    begin
        SalesCRMemoLine := Rec;
        SalesCRMemoLine.LOCKTABLE();
        SalesCRMemoLine.FIND();
        SalesCRMemoLine."Net Weight" := "Net Weight";
        SalesCRMemoLine."Gross Weight" := "Gross Weight";
        SalesCRMemoLine."PWD Cle (restitution)" := "PWD Cle (restitution)";
        SalesCRMemoLine."PWD Parcel Nb." := "PWD Parcel Nb.";
        SalesCRMemoLine."PWD Origin Area" := "PWD Origin Area";
        SalesCRMemoLine."PWD DCG Tariff No." := "PWD DCG Tariff No.";
        SalesCRMemoLine."PWD National Add. Code" := "PWD National Add. Code";
        SalesCRMemoLine."PWD Monthly Code" := "PWD Monthly Code";
        SalesCRMemoLine."PWD Valeur douane (correction)" := "PWD Valeur douane (correction)";
        SalesCRMemoLine.MODIFY();
        Rec := SalesCRMemoLine;
    end;

    var
        SalesCRMemoLine: Record "Sales Cr.Memo Line";
}

