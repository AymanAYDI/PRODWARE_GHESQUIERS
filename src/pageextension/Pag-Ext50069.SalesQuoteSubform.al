pageextension 50069 "PWD SalesQuoteSubform" extends "Sales Quote Subform"
{
    layout
    {
        addbefore(Type)
        {
            field("PWD Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("No.")
        {
            field("PWD Item SEAF Code"; Rec."PWD Item SEAF Code")
            {
                ApplicationArea = All;
            }
            field("PWD Item SEAF Code 2"; Rec."PWD Item SEAF Code 2")
            {
                ApplicationArea = All;
            }
            field("PWD Item SEAF Code 3"; Rec."PWD Item SEAF Code 3")
            {
                ApplicationArea = All;
            }
            field("PWD Item SEAF Code 4"; Rec."PWD Item SEAF Code 4")
            {
                ApplicationArea = All;
            }
            field("PWD Item SEAF Code 5"; Rec."PWD Item SEAF Code 5")
            {
                ApplicationArea = All;
            }
            field("PWD Vendor No."; Rec."PWD Vendor No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("PWD Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field("PWD Designation ENU"; Rec."PWD Designation ENU")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter("Unit Price")
        {
            field("PWD Trading Brand"; Rec."PWD Trading Brand")
            {
                ApplicationArea = All;
            }
            field("PWD Substitution Available"; Rec."Substitution Available")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("PWD Purchasing Code"; Rec."Purchasing Code")
            {
                ApplicationArea = All;
            }
            field("PWD Special Order"; Rec."Special Order")
            {
                ApplicationArea = All;
            }
            field("PWD Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
            field("PWD Unit of Measure"; Rec."Unit of Measure")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("PWD Units per Parcel"; Rec."Units per Parcel")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("PWD Nb Appeal for tenders"; Rec."PWD Nb Appeal for tenders")
            {
                ApplicationArea = All;
            }
            field("PWD Nb Purchase Quote"; Rec."PWD Nb Purchase Quote")
            {
                ApplicationArea = All;
            }
            field("PWD Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("PWD Specific Cost"; Rec."PWD Specific Cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Allow Invoice Disc.")
        {
            field("PWD Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("PWD Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("PWD Unit Volume"; Rec."Unit Volume")
            {
                ApplicationArea = All;
            }
        }
        addafter(ShortcutDimCode8)
        {
            field("PWD KPI"; Rec."PWD KPI")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Item &Tracking Lines")
        {
            action("PWD ExtraireCodeFournisseurEtCoutUnitaireDirect")
            {
                ApplicationArea = all;
                ShortCutKey = 'Shift+Ctrl+F';
                Caption = 'Extraire code &Fournisseur et coût unitaire direct';
                Image = Action;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Trigger OnAction()
                BEGIN
                    Rec.FctPushVendorAndUnitCostItem();
                END;
            }
        }
        modify("Select Nonstoc&k Items")
        {
            ShortcutKey = 'F6';
        }
    }
    PROCEDURE UnitPriceOnFormat()
    BEGIN
        ParamsVente.GET();
        CoefPrixUnitaire := ParamsVente."PWD Coef Ctrl Prix Unit";
    END;

    PROCEDURE UpdateKPI()
    VAR
        RecLKPIRulesSetup: Record "PWD KPI Rules Setup";
    BEGIN
        IF NOT RecLKPIRulesSetup.GET('', 1) THEN EXIT;
        RecLKPIRulesSetup.CALCFIELDS(RecLKPIRulesSetup.KPI);
        ParamsVente.GET();
        CoefPrixUnitaire := ParamsVente."PWD Coef Ctrl Prix Unit";
        IF Rec."Unit Price" * (1 - (Rec."Line Discount %" / 100)) < Rec."Unit Cost" * CoefPrixUnitaire THEN BEGIN
            Rec."PWD KPI" := RecLKPIRulesSetup.KPI;
            Rec.CALCFIELDS(Rec."PWD KPI");
        END ELSE
            CLEAR(Rec."PWD KPI");
    END;

    var
        ParamsVente: Record "Sales & Receivables Setup";
        CoefPrixUnitaire: Decimal;
}
