xmlport 67023 "UTT O9ResourceAvailability"
{
    Caption = 'UTT O9 Resource Availabiliy';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_P_o9ResourceAvai.dsv';
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
                        ResourceCodeLbl := 'Resourcecode';
                        IBPO9Buffer."Field 1" := ResourceCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationCodelbl := 'LocationCode';
                        IBPO9Buffer."Field 2" := LocationCodelbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ResourceAvailabilityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ResourceAvailabilityLbl := 'ResourceAvailability (in Hours/Days)';
                        IBPO9Buffer."Field 3" := ResourceAvailabilityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ResourceEfficiencyLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ResourceEfficiencyLbl := 'ResourceEfficiency';
                        IBPO9Buffer."Field 4" := ResourceEfficiencyLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(AverageDailyMaintenanceHoursLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        AverageDailyMaintenanceHoursLbl := 'AverageDailyMaintenanceHours';
                        IBPO9Buffer."Field 5" := AverageDailyMaintenanceHoursLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(AverageDailySetupHoursLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        AverageDailySetupHoursLbl := 'AverageDailySetupHours';
                        IBPO9Buffer."Field 6" := AverageDailySetupHoursLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(NumberOfResourceLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        NumberOfResourceLbl := 'NumberOfResource';
                        IBPO9Buffer."Field 7" := NumberOfResourceLbl;
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
                    IBPO9Buffer."Export Batch ID" := 'RESOURCEAVAIL_SP';
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
                textelement(wLocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                wLocationCode := 'IVMK';
                            'MX':
                                wLocationCode := 'IVMP';
                        end;
                        IBPO9Buffer."Field 2" := wLocationCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(wResourceAvailability)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wResourceAvailability := 'N/A';
                        IBPO9Buffer."Field 3" := wResourceAvailability;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(wResourceEfficiency)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wResourceEfficiency := 'N/A';
                        IBPO9Buffer."Field 4" := wResourceEfficiency;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(wAverageDailyMaintenanceHours)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wAverageDailyMaintenanceHours := 'N/A';
                        IBPO9Buffer."Field 5" := wAverageDailyMaintenanceHours;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(wAverageDailySetupHours)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wAverageDailySetupHours := 'N/A';
                        IBPO9Buffer."Field 6" := wAverageDailySetupHours;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(NumberOfResource)
                {
                    trigger OnBeforePassVariable()
                    begin
                        NumberOfResource := '1';
                        IBPO9Buffer."Field 7" := NumberOfResource;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    companyInfo.get();
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
                    IBPO9Buffer."Export Batch ID" := 'RESOURCEAVAIL_SP';
                    IBPO9Buffer.Insert();
                end;
            }
        }
    }

    var
        companyInfo: Record "Company Information";
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
}
