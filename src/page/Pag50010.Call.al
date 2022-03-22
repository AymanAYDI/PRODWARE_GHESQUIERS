page 50010 "PWD Call"
{
    Caption = 'Call';
    PageType = Card;
    SourceTable = "PWD Call";

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("Call No."; Rec."Call No.")
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Call Type"; Rec."Call Type")
                {
                    ApplicationArea = all;
                }
                field(Ship; Rec.Ship)
                {
                    ApplicationArea = all;
                }
                field(Flag; Rec.Flag)
                {
                    ApplicationArea = all;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = all;
                }
                field("Monthly Code"; Rec."Monthly Code")
                {
                    ApplicationArea = all;
                }
                field("Board Location"; Rec."Board Location")
                {
                    ApplicationArea = all;
                }
                field("Border Office"; Rec."Border Office")
                {
                    ApplicationArea = all;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = all;
                }
                field("File Date"; Rec."File Date")
                {
                    ApplicationArea = all;
                }
                field("Date and time of arrival"; Rec."Date and time of arrival")
                {
                    ApplicationArea = all;
                }
                field("Date and time of departure"; Rec."Date and time of departure")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = all;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field("Code information transport"; Rec."Code information transport")
                {
                    ApplicationArea = all;
                }
                field("Designation info. transport"; Rec."Designation info. transport")
                {
                    ApplicationArea = all;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Commentaire 1"; Rec."Commentaire 1")
                {
                    ApplicationArea = all;
                }
                field("Commentaire 2"; Rec."Commentaire 2")
                {
                    ApplicationArea = all;
                }
                field("Commentaire 3"; Rec."Commentaire 3")
                {
                    ApplicationArea = all;
                }
                field("Commentaire 4"; Rec."Commentaire 4")
                {
                    ApplicationArea = all;
                }
                field("Commentaire 5"; Rec."Commentaire 5")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Country: Record "Country/Region";
        MyFlag: Code[10];
}

