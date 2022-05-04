pageextension 50041 "PWD IntrastatJournal" extends "Intrastat Journal"
{
    layout
    {
        addafter("Internal Ref. No.")
        {
            field("PWD Supplementary Units Value"; Rec."PWD Supplementary Units Value")
            {
                ApplicationArea = all;
            }
        }
        addafter("TotalStatisticalValue + ""Statistical Value"" - xRec.""Statistical Value""")
        {
            field("PWD DecGTotalAmount"; DecGTotalAmount)
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter(GetEntries)
        {
            action("PWD Extract with Filtering")
            {
                ApplicationArea = all;
                Ellipsis = true;
                Caption = 'Extract with Filtering';
                Promoted = true;
                PromotedIsBig = true;
                Image = GetEntries;
                PromotedCategory = Process;
                Trigger OnAction()
                BEGIN
                    GetItemEntries2.SetIntrastatJnlLine(Rec);
                    GetItemEntries2.RUNMODAL();
                    CLEAR(GetItemEntries2);
                END;
            }
        }
    }
    var
        GetItemEntries2: Report "Get Item Ledger Entries SPE";
        DecGTotalAmount: Decimal;

    LOCAL PROCEDURE OnAfterGetCurrRecord();
    VAR
        TempIntrastatJnlLine: Record "Intrastat Jnl. Line";
    BEGIN
        xRec := Rec;
        UpdateStatisticalValue();
        TempIntrastatJnlLine.COPYFILTERS(Rec);
        IF TempIntrastatJnlLine.CALCSUMS(Amount) THEN
            DecGTotalAmount := TempIntrastatJnlLine.Amount
    END;

    local procedure UpdateStatisticalValue()
    var
        IntraJnlManagement: Codeunit IntraJnlManagement;
        ShowStatisticalValue: Boolean;
        ShowTotalStatisticalValue: Boolean;
        StatisticalValueVisible: Boolean;
        StatisticalValue: Decimal;
        TotalStatisticalValue: Decimal;
    begin
        IntraJnlManagement.CalcStatisticalValue(
          Rec, xRec, StatisticalValue, TotalStatisticalValue,
          ShowStatisticalValue, ShowTotalStatisticalValue);
        StatisticalValueVisible := ShowStatisticalValue;
        StatisticalValueVisible := ShowTotalStatisticalValue;
    end;
}
