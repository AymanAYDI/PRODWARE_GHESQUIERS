page 50043 "PWD Sales Lines to Prepare"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("PWD Shelf/Bin No.", "Location Code") ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF xRec."Location Code" <> '' THEN
                            ERROR(CstG001);
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prepared Quantity"; Rec."PWD Prepared Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Parcel Nb."; Rec."PWD Parcel Nb.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Disponibilité Art. Mag.")
            {
                Caption = 'Item Availability by Location';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ItemAvailability(2);
                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        CLEAR(ReleaseSalesDoc);
        ReleaseSalesDoc.InitRelease(TRUE);
        ReleaseSalesDoc.RUN(SalesHeader);
    end;

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;

    trigger OnOpenPage()
    begin
        SalesHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
        SalesHeader.SETRANGE(SalesHeader."No.", OrderNo);
        IF SalesHeader.FIND('-') THEN BEGIN
            CLEAR(ReleaseSalesDoc);
            PWDSetGetFunctions.InitRelease(TRUE);
            ReleaseSalesDoc.Reopen(SalesHeader);
        END;
    end;

    var
        SalesHeader: Record "Sales Header";
        PWDSetGetFunctions: Codeunit "PWD Set/Get Functions";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        OrderNo: Code[20];
        // "--MIGRATION2009R2--": ;
        CstG001: Label 'Interdit de modifier le code magasin !';


    procedure InitOrderNo("No.": Code[20])
    begin
        OrderNo := "No.";
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        Rec.ItemAvailability(AvailabilityType);
    end;
}

