sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"poapp/test/integration/pages/POsList",
	"poapp/test/integration/pages/POsObjectPage",
	"poapp/test/integration/pages/poitemsObjectPage"
], function (JourneyRunner, POsList, POsObjectPage, poitemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('poapp') + '/test/flp.html#app-preview',
        pages: {
			onThePOsList: POsList,
			onThePOsObjectPage: POsObjectPage,
			onThepoitemsObjectPage: poitemsObjectPage
        },
        async: true
    });

    return runner;
});

