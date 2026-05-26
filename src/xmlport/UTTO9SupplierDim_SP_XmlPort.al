xmlport 67022 "UTT O9SupplierDim_SP"
{
    Caption = 'UTT O9SupplierDim_SP';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_SupplierDim_SP.dsv';
    TableSeparator = '<NewLine>';
    FieldSeparator = '|';
    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'Header';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(SupplierIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SupplierIDLbl := 'SupplierID';
                        IBPO9Buffer."Field 1" := SupplierIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SupplierDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SupplierDescLbl := 'SupplierDescription';
                        IBPO9Buffer."Field 2" := SupplierDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(AllSupplierLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        AllSupplierLbl := 'AllSupplier';
                        IBPO9Buffer."Field 3" := AllSupplierLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(IsSupplierActiveLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        IsSupplierActiveLbl := 'IsSupplierActive';
                        IBPO9Buffer."Field 4" := IsSupplierActiveLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationcodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationcodeLbl := 'LocationCode';
                        IBPO9Buffer."Field 5" := LocationcodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SupplierTypeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SupplierTypeLbl := 'SupplierType';
                        IBPO9Buffer."Field 6" := SupplierTypeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentsLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentsLbl := 'Segments';
                        IBPO9Buffer."Field 7" := SegmentsLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    EntryNo: Integer;
                begin
                    EntryNo := IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init();
                    IBPO9Buffer."Entry No." := EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'SUPPLIERDIM_SP';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(Vendor; Vendor)
            {
                XmlName = 'Vendor';
                RequestFilterFields = Name;
                textelement(SupplierID)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SupplierID := vendor."No.";
                        IBPO9Buffer."Field 1" := SupplierID;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SupplierDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SupplierDesc := vendor.Name;
                        IBPO9Buffer."Field 2" := SupplierDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(AllSupplier)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        AllSupplier := 'ALL';
                        IBPO9Buffer."Field 3" := AllSupplier;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(IsSupplierActive)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        if not vendor.KVSInactive then
                            IsSupplierActive := 'Yes'
                        else
                            IsSupplierActive := 'No';
                        IBPO9Buffer."Field 4" := IsSupplierActive;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        CompanyInfo.get();
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                LocationCode := 'IVMK';
                            'MX':
                                LocationCode := 'IVMP';
                        end;
                        IBPO9Buffer."Field 5" := LocationCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SupplierType)
                {
                    trigger OnBeforePassVariable()
                    begin
                        if StrPos(UpperCase(Vendor.name), 'INDORAMA') > 0 then
                            SupplierType := 'Internal'
                        else
                            SupplierType := 'External';
                        IBPO9Buffer."Field 6" := SupplierType;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Segments)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Segments := 'Fibers';
                        IBPO9Buffer."Field 7" := Segments;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    Vendor.setfilter(name, '<>%1', '')
                end;

                trigger OnAfterGetRecord()
                var
                    EntryNo: Integer;
                begin
                    EntryNo := IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init();
                    IBPO9Buffer."Entry No." := EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'UOMDIM';
                    IBPO9Buffer.Insert();
                end;
            }
        }
    }

    var
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
}
