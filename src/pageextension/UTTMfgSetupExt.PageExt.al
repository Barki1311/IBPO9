pageextension 67052 "UTT MfgSetupExt" extends "Manufacturing Setup"
{
    layout
    {
        addafter("KVS Auto Posting Fixation")
        {
           
            field("UTT O9ExportPath"; "IBPO9ExportPath")
            {
                 ApplicationArea = all;
            }

            

        }
      
    }
}
