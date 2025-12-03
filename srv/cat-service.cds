using { infy.sd.poa.db as db } from '../db/datamodel';

service CatalogService @(path: 'cat-service', requires: 'authenticated-user') {

    //Show employee data in the end point
    @Capabilities : { Updatable : false, Insertable }
    entity EmployeeS as projection on db.master.employees;

    // Show business parter data in the end point
    entity BusinessPartnerS as projection on db.master.businesspartner;

    entity AddressS @(
        restrict : [
            {
                grant : ['READ'],
                to : 'Viewer',
                where : 'COUNTRY = $user.myCountry'
            },
            {
                grant : ['WRITE'],
                to : 'Admin'
            }
        ]
    ) as projection on db.master.address;
    
    entity ProductS as projection on db.master.product;
    
    entity poitems as projection on db.transaction.poitems;

    @odata.draft.enabled: true
    entity POs as projection on db.transaction.purchaseorder{
        *,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'Pending'
            when 'B' then 'Blocked'
            when 'C' then 'Completed'
        end as OStatus : String(20) @title : '{i18n>OVERALL_STATUS}',
        case OVERALL_STATUS
            when 'N' then 3
            when 'P' then 2
            when 'B' then 1
            when 'C' then 2
        end as OSC : Integer,
        case LIFECYCLE_STATUS
            when 'N' then 'Not Paid'
            when 'P' then 'Paid'
            when 'R' then 'Returned'
            when 'C' then 'Closed'
        end as LStatus : String(20) @title : '{i18n>LIFECYCLE_STATUS}',
        case LIFECYCLE_STATUS
            when 'N' then 1
            when 'P' then 3
            when 'R' then 2
            when 'C' then 3
        end as LSC : Integer,
        Items : redirected to poitems
    } actions {
        action discountPrice() returns POs;
        function largestOrder() returns array of  POs;
    }



    action createEmployee(
        ID : UUID,
        accountNumber : String,
        bankId : String,
        bankName : String,
        email : String,
        phoneNumber : String,
        nameFirst : String,
        sex : String,
        language : String,
        nameLast : String,
        loginName : String,
        nameMiddle : String,
        salaryAmount : Decimal(10,2),
        nameInitials : String
    ) returns array of EmployeeS ;


    function getAllEmployees() returns array of EmployeeS;
}