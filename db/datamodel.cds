namespace infy.sd.poa.db;


using {infy.sd.poa.common as common} from './common';
using { cuid, Currency } from '@sap/cds/common';




context master {
    entity businesspartner {
        key NODE_KEY     : common.Guid              @(title: '{i18n>NODE_KEY}');
            BP_ROLE      : String(2)                @(title: '{i18n>BP_ROLE}');
            EMAIL        : common.Email             @(title: '{i18n>EMAIL}');
            PHONE        : common.phoneNumber       @(title: '{i18n>MOBILE}');
            FAX          : String(32)               @(title: '{i18n>FAX}');
            WEB_ADDRESS  : String(44)               @(title: '{i18n>WEB}');
            // Managed Association between businesspartner and address
            ADDRESS_GUID : Association to address   @(title: '{i18n>ADDRESS_GUID}');
            BP_ID        : String(32)               @(title: '{i18n>BP_ID}');
            COMPANY_NAME : String(250)              @(title: '{i18n>COMPNAY_NAME}');
    }


    entity address {
        key NODE_KEY        : common.Guid               @(title: '{i18n>NODE_KEY}');
            CITY            : String(44)                @(title: '{i18n>CITY}');
            POSTAL_CODE     : String(8)                 @(title: '{i18n>POSTAL}');
            STREET          : String(44)                @(title: '{i18n>STREET}');
            BUILDING        : String(128)               @(title: '{i18n>BUILDING}');
            COUNTRY         : String(44)                @(title: '{i18n>COUNTRY}');
            ADDRESS_TYPE    : String(44)                @(title: '{i18n>ADDRESS_TYPE}');
            VAL_START_DATE  : Date                      @(title: '{i18n>VAL_START}');
            VAL_END_DATE    : Date                      @(title: '{i18n>VAL_END}');
            LATITUDE        : Decimal                   @(title: '{i18n>LATITUDE}');
            LONGITUDE       : Decimal                   @(title: '{i18n>LONGITUDE}');
            // Unmanaged Association between Business Partner and Address
            businesspartner : Association to one businesspartner
                                  on businesspartner.ADDRESS_GUID = $self;


    }


    entity product {
        key NODE_KEY : common.Guid                   @(title: '{i18n>NODE_KEY}');
        PRODUCT_ID : String(28)                   @(title: '{i18n>PRODUCT_ID}');
        TYPE_CODE : String(2)                   @(title: '{i18n>TYPE_CODE}');
        CATEGORY : String(32)                   @(title: '{i18n>CATEGORY}');
        DESCRIPTION : localized String(255)                   @(title: '{i18n>DESCRIPTION}');
        // Managed Association between Business Partner and Product
        SUPPLIER_GUID : Association to master.businesspartner                   @(title: '{i18n>SUPPLIER_GUID}');
        TAX_TARIF_CODE : Integer                   @(title: '{i18n>TAX_TARIF_CODE}');
        MEASURE_UNIT : String(2)                   @(title: '{i18n>MEASURE_UNIT}');
        WEIGHT_MEASURE : Decimal(5,2)                   @(title: '{i18n>WEIGHT_MEASURE}');
        WEIGHT_UNIT : String(2)                   @(title: '{i18n>WEIGHT_UNIT}');
        CURRENCY_CODE : String(4)                   @(title: '{i18n>CURRENCY_CODE}');
        PRICE : Decimal(15,2)                   @(title: '{i18n>PRICE}');
        WIDHT : Decimal(15,2)                   @(title: '{i18n>WIDTH}');
        DEPTH : Decimal(15,2)                   @(title: '{i18n>DEPTH}');
        HEIGHT : Decimal(15,2)                   @(title: '{i18n>HEIGHT}');
        DIM_UNIT : String(2)                   @(title: '{i18n>DIM_UNIT}');
    }


    entity employees : cuid {
        nameFirst : String(40);
        nameMiddle : String(40);
        nameLast : String(40);
        nameInitials : String(40);
        sex : common.Gender;
        language : String(2);
        phoneNumber : common.phoneNumber;
        email : common.Email;
        loginName : String(12);
        Currency : Currency;
        salaryAmount : common.AmountT;
        accountNumber : String(16);
        bankId : String(12);
        bankName : String(64);


    }
}

context transaction {
    entity purchaseorder : common.Amount {
        key NODE_KEY : common.Guid                   @(title: '{i18n>NODE_KEY}');
        PO_ID : String(40)                   @(title: '{i18n>PO_ID}');
        // Managed Association between purchase order and businesspartner
        PATRNER_GUID : Association to one master.businesspartner                   @(title: '{i18n>PARTNER_GUID}');
        LIFECYCLE_STATUS : String(1)                   @(title: '{i18n>LIFECYCLE_STATUS}');
        OVERALL_STATUS : String(1)                   @(title: '{i18n>OVERALL_STATUS}');
        Items: Composition of  many poitems on Items.PARENT_KEY = $self;

    }

    entity poitems : common.Amount {
        key NODE_KEY : common.Guid                   @(title: '{i18n>NODE_KEY}');
        PARENT_KEY : Association to transaction.purchaseorder                   @(title: '{i18n>PARENT_KEY}');
        PO_ITEM_POS : Integer                   @(title: '{i18n>PO_ITEMS_POS}');
        PRODUCT_GUID : Association to master.product                  ;
    }
}

// 1. Data Model
// 2. Services - Definintion & CDS Based Authorization & Actions / Functions
// 3. User Interface - Firoi Annotations
// 4. Version Management - Git & Git Hub
// 5. Job Scheduler
// 6. DMS
// 7. Authorziation and Trust Management
// 8. Deployment configuration & Deployments
// 9. App Router configuration
// Q&A