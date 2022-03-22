pageextension 50011 "PWD ItemLedgerEntries" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Entry Type")
        {
            field("PWD Source No."; Rec."Source No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Prod. Order Comp. Line No.")
        {
            field("PWD Notice Series No."; Rec."PWD Notice Series No.")
            {
                ApplicationArea = all;
            }
            field("PWD Origin"; Rec."PWD Origin")
            {
                ApplicationArea = All;
            }
            field("PWD Cetificate Transit No."; Rec."PWD Cetificate Transit No.")
            {
                ApplicationArea = All;
            }
            field("PWD Code fournisseur"; Rec."PWD Code fournisseur")
            {
                ApplicationArea = All;
            }
            field("PWD Code client"; Rec."PWD Code client")
            {
                ApplicationArea = All;
            }
            field("PWD Lot Reserved Qty"; Rec."PWD Lot Reserved Qty")
            {
                ApplicationArea = All;
            }

        }
    }
}
