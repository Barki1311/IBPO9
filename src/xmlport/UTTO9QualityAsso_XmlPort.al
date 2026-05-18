xmlport 67013 "UTT O9QualityAssociation"
{
    Caption = 'UTT O9 QualityAssociation';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_P_o9QualityAssociation.dsv';
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
                textelement(QualityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityLbl := 'Quality';
                        IBPO9Buffer."Field 1" := QualityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MaterialLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MaterialLbl := 'Material';
                        IBPO9Buffer."Field 2" := MaterialLbl;
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
                    IBPO9Buffer."Export Batch ID" := 'QUALITYASSO';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(Item; Item)
            {
                XmlName = 'Data';
                RequestFilterFields = "No.";
                textelement(Quality)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Quality := 'STANDARD';
                        IBPO9Buffer."Field 1" := Quality;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Material)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Material := item."No.";
                        IBPO9Buffer."Field 2" := Material;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    Item.Setfilter("KVSTEX Item Type", '%1|%2|%3', item."KVSTEX Item Type"::"Finished Product", item."KVSTEX Item Type"::Yarn, item."KVSTEX Item Type"::"KVS Cutset", item."KVSTEX Item Type"::"KVS Colour Ribbon");
                    item.SetRange("KVSTEX Item Status", item."KVSTEX Item Status"::Certified);
                    companyInfo.get();
                end;

                trigger OnAfterGetRecord()
                begin
                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then
                        IBPO9Buffer."Entry No." := 1
                    else
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'QUALITYASSO';
                    IBPO9Buffer.Insert();
                end;
            }
        }
    }

    var
        companyInfo: Record "Company Information";
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
}
