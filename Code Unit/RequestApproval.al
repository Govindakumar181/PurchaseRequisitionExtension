codeunit 70107 RequestApproval
{

    procedure GetApprovalRequest(): Text

    var
        headerRec: Record ApprovalTemp;
        varTempHeader: Code[20];
    begin

        If headerRec.FindFirst() then begin

            varTempHeader := headerRec."PR No";//
            headerRec.DeleteAll;
            exit(varTempHeader);

        end;
    end;



}