tableextension 60063 "PWD PriceListLine" extends "Price List Line"
{
    fields
    {
        field(50000; "PWD Purch. Cost"; Decimal)
        {
            Caption = 'Purch. Cost';
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF ("PWD Percentage Profit" <> 0) AND ("PWD Percentage Profit" <> 100) THEN
                    "Unit Price" := ROUND("PWD Purch. Cost" / (1 - "PWD Percentage Profit" / 100), 0.01, '<')
                ELSE
                    "Unit Price" := ROUND("PWD Purch. Cost", 0.01, '<');
            end;
        }
        field(50001; "PWD Percentage Profit"; Decimal)
        {
            Caption = 'Percentage Profit';
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF ("PWD Percentage Profit" <> 0) AND ("PWD Percentage Profit" <> 100) THEN
                    "Unit Price" := ROUND("PWD Purch. Cost" / (1 - "PWD Percentage Profit" / 100), 0.01, '<')
                ELSE
                    "Unit Price" := ROUND("PWD Purch. Cost", 0.01, '<');
            end;
        }
        //TODOfield(50002; "PWD Description"; Text[50]) //"Description" existe dans le STD
        // {
        //     Caption = 'Description';
        //     Description = 'PW2009';
        //     DataClassification = CustomerContent;
        // }
        field(50014; "PWD Family"; Code[10])
        {
            CalcFormula = Lookup(Item."PWD Family" WHERE("No." = FIELD("Asset No.")));
            Caption = 'Family';
            Description = 'PW2009';
            FieldClass = FlowField;
        }
    }
}
