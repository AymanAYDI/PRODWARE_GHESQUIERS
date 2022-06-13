codeunit 60005 "PWD Set/Get Functions"
{
    SingleInstance = true;

    var
        GboolSkipLoc: Boolean;
        Processing: Boolean;
        CountryCode: Code[10];
        OriginLotNo: Code[20];
        StockingAdviceNo: Code[20];
        ToLocationCode: Code[20];
        CertifTransNo: Code[30];
        ButchExpirationDate: Date;
        ButchExpirationDate2: Date;
        MemLineDiscount: Decimal;
        MemUnitPrice: Decimal;

    //---TAB37---
    procedure SetMemLineDiscount(NewMemLineDiscount: Decimal)
    begin
        MemLineDiscount := NewMemLineDiscount;
    end;

    procedure GetMemLineDiscount(): Decimal
    begin
        exit(MemLineDiscount);
    end;

    procedure SetMemUnitPrice(NewMemUnitPrice: Decimal)
    begin
        MemUnitPrice := NewMemUnitPrice;
    end;

    procedure GetMemUnitPrice(): Decimal
    begin
        exit(MemUnitPrice);
    end;

    //cdu414
    procedure InitRelease(FromProcess: Boolean)
    BEGIN
        Processing := FromProcess;
    END;

    PROCEDURE GetProcessing(): Boolean
    BEGIN
        exit(Processing);
    END;

    procedure SkipLocationControl(BoolPar: Boolean);
    BEGIN
        GboolSkipLoc := BoolPar;
    END;

    //---CDU99000830---
    PROCEDURE SetOriginArea(CountryOrigin: Code[10]);
    BEGIN
        CountryCode := CountryOrigin;
    END;

    PROCEDURE GetOriginArea(): Code[10]
    BEGIN
        exit(CountryCode);
    END;

    PROCEDURE SetCertifTransit(CertifNo: Code[30]);
    BEGIN
        CertifTransNo := CertifNo;
    END;

    PROCEDURE GetCertifTransit(): Code[30]
    BEGIN
        exit(CertifTransNo);
    END;

    PROCEDURE SetStockingAdvice(StockAdvNo: Code[20]);
    BEGIN
        StockingAdviceNo := StockAdvNo;
    END;

    PROCEDURE GetStockingAdvice(): Code[20]
    BEGIN
        exit(StockingAdviceNo);
    END;

    PROCEDURE SetButchery(ExpDate: Date);
    BEGIN
        ButchExpirationDate := ExpDate;
    END;

    PROCEDURE GetButchery(): Date
    BEGIN
        exit(ButchExpirationDate);
    END;

    PROCEDURE SetButcheryOriginLot(OriginLotNoFill: Code[20]);
    BEGIN
        OriginLotNo := OriginLotNoFill;
    END;

    PROCEDURE GetButcheryOriginLot(): Code[20]
    BEGIN
        exit(OriginLotNo);
    END;

    PROCEDURE SetLocationCode(FromLocationCode: Code[20]);
    BEGIN
        ToLocationCode := FromLocationCode;
    END;

    PROCEDURE GetLocationCode(): Code[20]
    BEGIN
        exit(ToLocationCode);
    END;

    PROCEDURE SetButchery2(ExpDate: Date);
    BEGIN
        ButchExpirationDate2 := ExpDate;
    END;

    PROCEDURE GetButchery2(): Date
    BEGIN
        exit(ButchExpirationDate2);
    END;

}
