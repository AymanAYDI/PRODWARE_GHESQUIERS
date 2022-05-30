page 50000 "PWD Custom Parameters"
{
    Caption = 'Custom Parameters';
    PageType = List;
    SourceTable = "PWD Custom Parameters";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec."Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
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
        CurrPage.CAPTION := UpdateFormCaption(Rec.GETFILTER("Table ID"), Rec.GETFILTER("Field ID"));
        Rec.FILTERGROUP(2);
    end;

    procedure UpdateFormCaption(TableIDFilter: Text[30]; FieldIDFilter: Text[30]): Text[50]
    var
        RecFields: Record "Field";
        GetFieldID: Integer;
        GetTableID: Integer;
    begin
        IF (EVALUATE(GetTableID, TableIDFilter) AND EVALUATE(GetFieldID, FieldIDFilter)) THEN
            IF RecFields.GET(GetTableID, GetFieldID) THEN EXIT(RecFields."Field Caption");
    end;
}
