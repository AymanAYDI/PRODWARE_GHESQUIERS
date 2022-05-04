report 50016 "PWD Calcul PU=CU*coef"
{
    // --------------------------------------------
    // Prodware - www.prodware.fr
    // --------------------------------------------
    // //>>SOBI
    // P3346_0011 RO.LALE REGIE 11/07/2013 : - Création report de traitement utilisé dans les cdes et devis vente
    // P3346_0011 RO.LALE REGIE 15/07/2013 : - correctif suite test.

    ProcessingOnly = true;

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
                    "Sales Line".VALIDATE("Unit Price", ROUND("Sales Line"."Unit Cost" * DecGCoefficient, 0.01));
                    "Sales Line".MODIFY();
                end;
            }

            trigger OnPostDataItem()
            begin
                MESSAGE('Prix unitaire des lignes calculés sur le coût unitaire avec coefficient %1', DecGCoefficient);
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
                    field(DecGCoefficient; DecGCoefficient)
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
        DecGCoefficient: Decimal;
}

