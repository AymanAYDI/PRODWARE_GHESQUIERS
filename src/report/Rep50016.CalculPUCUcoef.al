report 50016 "PWD Calcul PU=CU*coef"
{
    ProcessingOnly = true;
    UsageCategory = None;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE(Type = FILTER(Item));

                trigger OnAfterGetRecord()
                begin
                    "Sales Line".VALIDATE("Unit Price", ROUND("Sales Line"."Unit Cost" * "PWD DecGCoefficient", 0.01));
                    "Sales Line".MODIFY();
                end;
            }

            trigger OnPostDataItem()
            begin
                MESSAGE('Prix unitaire des lignes calculés sur le coût unitaire avec coefficient %1', "PWD DecGCoefficient");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DecGCoefficient; "PWD DecGCoefficient")
                    {
                        Caption = 'Coefficient à appliquer';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        "PWD DecGCoefficient": Decimal;
}