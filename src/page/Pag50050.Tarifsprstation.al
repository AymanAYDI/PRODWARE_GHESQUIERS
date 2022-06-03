page 50050 "PWD Tarifs préstation"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "PWD Tarifs prestation";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code prestation"; Rec."Code prestation")
                {
                    ApplicationArea = All;
                }
                field("Code article"; Rec."Code article")
                {
                    ApplicationArea = All;
                }
                field("Designation article"; Rec."Designation article")
                {
                    ApplicationArea = All;
                }
                field("Code unite"; Rec."Code unite")
                {
                    ApplicationArea = All;
                }
                field("Code client"; Rec."Code client")
                {
                    ApplicationArea = All;
                }
                field("Nom du client"; Rec."Nom du client")
                {
                    ApplicationArea = All;
                }
                field("Date de debut"; Rec."Date de debut")
                {
                    ApplicationArea = All;
                }
                field("Prix unitaire"; Rec."Prix unitaire")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Date de debut" := xRec."Date de debut";
    end;
}
