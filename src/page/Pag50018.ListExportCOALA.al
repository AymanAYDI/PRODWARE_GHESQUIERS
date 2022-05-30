page 50018 "PWD List Export COALA"
{
    PageType = List;
    SourceTable = "PWD Export COALA";
    SourceTableView = SORTING("Entry No.") ORDER(Descending) WHERE("Export COALA Succes" = CONST(true));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = all;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Export DateTime"; Rec."Export DateTime")
                {
                    ApplicationArea = all;
                }
                field("Date premier export"; Rec."Date premier export")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.FINDFIRST();
    end;
}
