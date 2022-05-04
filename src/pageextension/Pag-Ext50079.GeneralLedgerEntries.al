pageextension 50079 "PWD GeneralLedgerEntries" extends "General Ledger Entries"
{
    layout
    {
        addafter("Gen. Bus. Posting Group")
        {
            field("PWD VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = all;
            }
            field("PWD VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }
}
