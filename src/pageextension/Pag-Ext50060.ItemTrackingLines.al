pageextension 50060 "PWD ItemTrackingLines" extends "Item Tracking Lines"
{
    layout
    {
        addbefore("Expiration Date")
        {
            field("PWD CountryOrigin"; Rec."PWD Country Origin")
            {
                ApplicationArea = All;
            }

        }
        addbefore(Source)
        {
            group("PWD Origin Butchery")
            {
                field("PWD Country Origin"; OriginButcheryEntry."PWD Country Origin")
                {
                    Caption = 'Origin Butchery Entry';
                    Visible = ShowButchCaption;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PWD Expiration Date"; OriginButcheryEntry."Expiration Date")
                {
                    Visible = ShowButchCaption;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PWD Lot No."; OriginButcheryEntry."Lot No.")
                {
                    ApplicationArea = All;
                    Visible = ShowButchCaption;
                    Editable = false;
                }
            }
        }
        addafter("Quantity Handled (Base)")
        {
            field("PWD Entry No."; Rec."Entry No.")
            {
                ApplicationArea = All;
            }
            field("PWD Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;
            }
            field("PWD Source Batch Name"; Rec."Source Batch Name")
            {
                ApplicationArea = All;
            }
            field("PWD Source Ref. No."; Rec."Source Ref. No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Quantity Invoiced (Base)")
        {
            field("PWD Certificate Transit No."; Rec."PWD Certificate Transit No.")
            {
                ApplicationArea = All;
            }
            field("PWD Stocking Advice No."; Rec."PWD Stocking Advice No.")
            {
                ApplicationArea = All;
            }
            field("PWD Origin Lot No."; Rec."PWD Origin Lot No.")
            {
                ApplicationArea = All;
            }

        }
    }
    trigger OnOpenPage()
    begin
        PurchLine2.SETCURRENTKEY("Document No.", "Line No.");
    end;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Source Type" = 39 THEN BEGIN
            PurchLine2.SETRANGE("Document Type", PurchLine2."Document Type"::Order);
            PurchLine2.SETRANGE("Document No.", Rec."Source ID");
            PurchLine2.SETRANGE("Line No.", Rec."Source Ref. No.");
            IF PurchLine2.FIND('-') THEN
                Rec."PWD Country Origin" := PurchLine2."PWD Origin";
            Rec."PWD Certificate Transit No." := PurchLine2."PWD Cetificate Transit No.";
        END;
        UpdateButchData();
    end;

    var
        PurchLine2: Record "Purchase Line";
        OriginButcheryEntry: Record "Reservation Entry";
        ShowButchCaption: Boolean;

    PROCEDURE SetOrigineButcheryEntry(VAR OriginButchEntryFilter: Record "Reservation Entry"; ShowCaption: Boolean);
    VAR
        Text1000000002: Label 'Please add then correct tracking line for the outbound butchery line.;FRA=Veuillez saisir la ligne tra‡abilit‚ pour l''ecriture de sortie boucherie.';
    BEGIN
        IF NOT OriginButchEntryFilter.FIND() THEN
            ERROR(Text1000000002);
        ShowButchCaption := ShowCaption;
        OriginButcheryEntry := OriginButchEntryFilter;
    END;

    PROCEDURE UpdateButchData()
    BEGIN
        IF OriginButcheryEntry.FIND() THEN BEGIN
            Rec."PWD Origin Lot No." := OriginButcheryEntry."Lot No.";
            Rec."Expiration Date" := OriginButcheryEntry."Expiration Date";
            Rec."PWD Country Origin" := OriginButcheryEntry."PWD Country Origin";
        END;
    END;

}