codeunit 50011 "PWD Stocking Advice Mngt"
{
    TableNo = "Purchase Header";

    trigger OnRun()
    var
        Location: Record Location;
        PurchHeader: Record "Purchase Header";
        ReservEntry: Record "Reservation Entry";
        NoSeriesMngt: Codeunit NoSeriesManagement;
    begin
        IF Location.GET(Rec."Location Code") THEN
            IF Location."PWD Placement Series No." <> '' THEN BEGIN
                PurchHeader := Rec;
                PurchHeader.LOCKTABLE();
                PurchHeader.FIND();
                PurchHeader."PWD Notice Series No." := NoSeriesMngt.GetNextNo
                  (Location."PWD Placement Series No.", PurchHeader."Document Date", TRUE);
                ReservEntry.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID");
                ReservEntry.SETRANGE("Source Type", 39);
                ReservEntry.SETRANGE("Source Subtype", 1);
                ReservEntry.SETRANGE("Source ID", Rec."No.");
                ReservEntry.MODIFYALL("PWD Stocking Advice No.", PurchHeader."PWD Notice Series No.");
                PurchHeader.MODIFY();
            END;
    end;
}
