table 70100 "Purchase Requisition Header"
{


    fields
    {
        field(1; "PR No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;


        }
        field(3; "Reason"; Text[100])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
            NotBlank = true;


        }
        field(4; "Description"; Text[120])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

        }
        field(5; "Raised By"; Text[40])
        {
            Caption = 'Raised By';
            DataClassification = CustomerContent;

        }
        field(6; "Status"; Text[10])
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            InitValue = 'Draft';

        }
        field(7; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
            trigger OnValidate()


            begin

                if (Rec."Due Date" < Today()) Or (Rec."Due Date" < Rec."Document Date") then
                    //text field error
                    FieldError(Rec."Due Date", 'You can only select future dates');

            end;
        }


    }

    keys
    {
        key(PK; "PR No.", "Reason")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        varEmail: Record User;
        varHistRec: Record "Purchase Requisition History";
        varDate: Text;
        varPRNo: Text;
    begin
        //inserting default values
        Rec."PR No." := NoSeriesMgt.GetNextNo('PR-APP', Today(), true);
        Rec."Document Date" := Today();
        Rec."Due Date" := Today();

        varEmail.Reset();
        varEmail.SETFILTER("User Name", UserId());
        if varEmail.FindFirst() then begin
            Rec."Raised By" := varEmail."Authentication Email";
        end;

    end;


    //deleting line records when header deleted
    trigger onDelete()
    var
        varLines: Record "Purchase Requistion Line";
    begin
        varLines.SETFILTER("PR No.", Rec."PR No.");
        if varLines.FindSet() then
            repeat
                varLines.Delete(true);

            until varLines.Next() = 0;

    end;

}