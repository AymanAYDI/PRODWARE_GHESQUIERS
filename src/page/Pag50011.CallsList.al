page 50011 "PWD Calls List"
{
    Caption = 'Calls List';
    CardPageID = "PWD Call";
    Editable = false;
    PageType = List;
    SourceTable = "PWD Call";
    SourceTableView = ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Call No."; Rec."Call No.")
                {
                    ApplicationArea = all;
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
                field("File Date"; Rec."File Date")
                {
                    ApplicationArea = all;
                }
                field(Department; Rec.Department)
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
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = all;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field("Area"; Rec.Area)
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
                field("Boat Name"; Rec."Boat Name")
                {
                    ApplicationArea = all;
                }
                field(Attachement; Rec.Attachement)
                {
                    ApplicationArea = all;
                }
                field("Equipe for fisching"; Rec."Equipe for fisching")
                {
                    ApplicationArea = all;
                }
                field("Equipement Statement"; Rec."Equipement Statement")
                {
                    ApplicationArea = all;
                }
                field(Captain; Rec.Captain)
                {
                    ApplicationArea = all;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Fiche)
            {
                Caption = 'Fiche';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "PWD Call";
                ApplicationArea = all;
                RunPageOnRec = true;
            }
        }
    }
}

