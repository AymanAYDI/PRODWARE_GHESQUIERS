page 50008 "PWD Purchases Line FactBox"
{
    Caption = 'Détails ligne achat';
    PageType = CardPart;
    SourceTable = "Purchase Line";

    layout
    {
        area(content)
        {
            field("STRSUBSTNO('%1',PurchPriceMgt.CalcNoOfPurchPricesFromPurchLi(Rec))"; STRSUBSTNO('%1', PWDFunctionMgt.CalcNoOfPurchPricesFromPurchLi(Rec)))
            {
                Caption = 'Purchase Prices';
                ApplicationArea = all;

                trigger OnDrillDown()
                begin
                    PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                    CLEAR(PurchPriceMgt);
                    IF Rec.Type = Rec.Type::Item THEN
                        PWDFunctionMgt.GetItemPurchLinePrice(Rec."No.", PurchaseHeader."Order Date");
                end;
            }
        }
    }

    actions
    {
    }

    var
        PurchaseHeader: Record "Purchase Header";
        PurchPriceMgt: Codeunit "Purch. Price Calc. Mgt.";
        "PWDFunctionMgt": Codeunit "PWD Function Mgt";
}

