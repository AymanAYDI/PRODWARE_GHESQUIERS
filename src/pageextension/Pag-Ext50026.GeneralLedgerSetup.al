pageextension 50026 "PWD GeneralLedgerSetup" extends "General Ledger Setup"
{
    layout
    {
        addafter("Local Cont. Addr. Format")
        {
            field("PWD Magasin DEB 1"; Rec."PWD Magasin DEB 1")
            {
                ApplicationArea = All;
            }
            field("PWD Magasin DEB 2"; Rec."PWD Magasin DEB 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Print VAT specification in LCY")
        {
            field("PWD Amount Rounding Precision"; Rec."Amount Rounding Precision")
            {
                ApplicationArea = All;
            }
            field("PWD Unit-Amount Rounding Precision"; Rec."Unit-Amount Rounding Precision")
            {
                ApplicationArea = all;
            }
        }
    }
}
