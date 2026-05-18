xmlport 67014 "UTT O9ResourceMaster"
{
    Caption = 'UTT O9 Resource Master';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_P_O9ResourceMaster.dsv';
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
                textelement(ResourceCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ResourceCodeLbl := 'ResourceCode';
                        IBPO9Buffer."Field 1" := ResourceCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ResourceDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ResourceDescLbl := 'ResourceDescription';
                        IBPO9Buffer."Field 2" := ResourceDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ResourceGroupLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ResourceGroupLbl := 'ResourceGroup';
                        IBPO9Buffer."Field 3" := ResourceGroupLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ResourceTypeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ResourceTypeLbl := 'ResourceType';
                        IBPO9Buffer."Field 4" := ResourceTypeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentsLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentsLbl := 'Segments';
                        IBPO9Buffer."Field 5" := SegmentsLbl;
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
                    IBPO9Buffer."Export Batch ID" := 'RESOURCEMASTER';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(WorkCenter; "Work Center")
            {
                XmlName = 'Data';
                RequestFilterFields = "No.";
                textelement(wResourceCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        wResourceCode := WorkCenter."No.";
                        IBPO9Buffer."Field 1" := wResourceCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(wResourceDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        wResourceDesc := WorkCenter.Name;
                        if wResourceDesc = '' then
                            wResourceDesc := WorkCenter."No.";
                        IBPO9Buffer."Field 2" := wResourceDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(WResourceGroup)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        wResourceGroup := '';
                        IBPO9Buffer."Field 3" := wResourceGroup;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(wResourceType)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        wResourceType := 'WorkCenter';
                        IBPO9Buffer."Field 4" := wResourceType;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(WSegments)
                {
                    trigger OnBeforePassVariable()
                    begin
                        WSegments := 'Fiber';
                        IBPO9Buffer."Field 5" := WSegments;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    WorkCenter.SetRange("Work Center Group Code", 'PROD');
                    WorkCenter.SetRange(Blocked, false);
                end;

                trigger OnAfterGetRecord()
                begin
                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then
                        IBPO9Buffer."Entry No." := 1
                    else
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'RESOURCEMASTER';
                    IBPO9Buffer.Insert();
                end;
            }
        }
    }

    var
        companyInfo: Record "Company Information";
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
}
