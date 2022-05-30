page 50025 "PWD Archived Sales List"
{
    Caption = 'Archived Sales List';
    CardPageID = "PWD Archived Sales Order";
    Editable = false;
    PageType = List;
    SourceTable = "PWD Archived Sales Header";
    ApplicationArea = all;
    UsageCategory = History;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = all;
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    ApplicationArea = all;
                }
                field("Time Archived"; Rec."Time Archived")
                {
                    ApplicationArea = all;
                }
                field("Archived By"; Rec."Archived By")
                {
                    ApplicationArea = all;
                }
                field("Interaction Exist"; Rec."Interaction Exist")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Country Code"; Rec."Sell-to Country Code")
                {
                    ApplicationArea = all;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = all;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = all;
                }
                field("Bill-to Country Code"; Rec."Bill-to Country Code")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Country Code"; Rec."Ship-to Country Code")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Ligne")
            {
                Caption = '&Line';
                action(Fiche)
                {
                    Caption = 'Card';
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Page.RUN(70060, Rec);
                    end;
                }
            }
        }
    }
}
