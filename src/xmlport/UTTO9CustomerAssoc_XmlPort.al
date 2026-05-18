xmlport 67018 "UTT O9CustomerAssoc"
{
    Caption = 'UTT O9CustomerAssoc';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'CustomerAssoc.dsv';
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
                textelement(ShipToLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ShipToLbl := 'ShipTo';
                        IBPO9Buffer."Field 1" := ShipToLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SoldToLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SoldToLbl := 'SoldTo';
                        IBPO9Buffer."Field 2" := SoldToLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationCodeLbl := 'LocationCode';
                        IBPO9Buffer."Field 3" := LocationCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CustomerAssocLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CustomerAssocLbl := 'CustomerAssociation';
                        IBPO9Buffer."Field 4" := CustomerAssocLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then
                        IBPO9Buffer."Entry No." := 1
                    else
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'CUSTOMERASSOC';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(Customer; Customer)
            {
                XmlName = 'CustomerAssoc';
                RequestFilterFields = Name;
                SourceTableView = sorting("No.") WHERE(name = filter(<> ''));
                textelement(ShipTo) 
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ShipTo := Customer."No.";
                        IBPO9Buffer."Field 1" := ShipTo;
                        IBPO9Buffer.Modify();
                    end;
                 }
                textelement(SoldTo) 
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SoldTo := Customer."No.";
                        IBPO9Buffer."Field 2" := SoldTo;
                         IBPO9Buffer.Modify();
                    end;
                 }
                textelement(LocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                LocationCode := 'IVMK';
                            'MX':
                                LocationCode := 'IVMP';
                        end;
                        IBPO9Buffer."Field 3" := LocationCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CustomerAssoc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CustomerAssoc := '1';
                        IBPO9Buffer."Field 4" := CustomerAssoc;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    CompanyInfo.get();
                    Customer.setfilter("Gen. Bus. Posting Group", '<>%1', '');
                    customer.SetFilter(name, '<>%1', '');
                end;

                trigger OnAfterGetRecord()
                begin
                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then
                        IBPO9Buffer."Entry No." := 1
                    else
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'CUSTOMERASSOC';
                    IBPO9Buffer.Insert();
                end;
            }
        }
    }

    var
        companyInfo: Record "Company Information";
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
}
