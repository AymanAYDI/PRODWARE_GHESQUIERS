codeunit 50012 "PWD ButcheryMngt"
{
    trigger OnRun()
    begin
    end;

    procedure GetOrigin(ItemJnlLine: Record "Item Journal Line"; EntryLineNo: Integer; var OriginButchEntry: Record "Reservation Entry")
    var
        ReservEntry: Record "Reservation Entry";
    begin
        ReservEntry.SETCURRENTKEY("Source ID", "Source Batch Name", "Source Ref. No.");
        ReservEntry.SETRANGE("Source ID", ItemJnlLine."Journal Template Name");
        ReservEntry.SETRANGE("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ReservEntry.SETRANGE("Source Ref. No.", EntryLineNo);
        IF ReservEntry.FIND('-') THEN
            OriginButchEntry := ReservEntry
        ELSE
            OriginButchEntry.INIT();
    end;
}
