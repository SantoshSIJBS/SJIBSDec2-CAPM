namespace infy.sd.poa.common;
using { Currency } from '@sap/cds/common';




/**
 * Code to design enumerator for the reuse type
 */
type Gender : String(1) enum {
    male = 'M';
    female = 'F';
    undisclosed = 'U'; 
}


/**
 * Code to design Reuse type for Amount
 */
type AmountT : Decimal(12,2)@(
    Semantics.amount.currencyCode : 'CURRENCY_CODE',
    sap.unit: 'CURRENCY_CODE'
);


/**
 * Code to design aspect for the amount
 */
aspect Amount : {
    CURRENCY : Currency     @(title: '{i18n>CURRENCY_CODE}');
    GROSS_AMOUNT : AmountT  @(title: '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT : AmountT    @(title: '{i18n>NET_AMOUNT}');
    TAX_AMOUNT : AmountT    @(title: '{i18n>TAX_AMOUNT}');
}


/**
 * Code to design aspect type for common uses
 */
type Guid : String(32);
type phoneNumber : String(30);
type Email : String(255);