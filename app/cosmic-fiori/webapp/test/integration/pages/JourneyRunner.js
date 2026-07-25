sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"cosmicfiori/test/integration/pages/SpacefarersList.gen",
	"cosmicfiori/test/integration/pages/SpacefarersObjectPage.gen",
	"cosmicfiori/test/integration/pages/SpacefarersStarDustsObjectPage.gen"
], function (JourneyRunner, SpacefarersListGenerated, SpacefarersObjectPageGenerated, SpacefarersStarDustsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('cosmicfiori') + '/test/flp.html#app-preview',
        pages: {
			onTheSpacefarersListGenerated: SpacefarersListGenerated,
			onTheSpacefarersObjectPageGenerated: SpacefarersObjectPageGenerated,
			onTheSpacefarersStarDustsObjectPageGenerated: SpacefarersStarDustsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

