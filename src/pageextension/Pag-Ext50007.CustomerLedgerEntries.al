pageextension 50007 "PWD CustomerLedgerEntries" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Reason Code")
        {
            field("PWD Reference"; Rec."PWD Reference")
            {
                ApplicationArea = all;
            }
        }
    }
}
