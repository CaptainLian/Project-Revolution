INSERT INTO "ActivityResearchForm"(
            "GOSMActivity", "positionInOrganization", "IUTPOTA", 
            "TASMI", "IFIDTA", "TAWWP", "TOUMTGTTA", "WWWITA", "FAC", "EFFA", 
            "dateSubmitted")
    VALUES (${gosmactivity}, ${positionInOrganization}, ${iutpota}, ${tasmi}, 
            ${ifidta}, ${tawwp}, ${toumtgtta}, ${wwwita}, ${fac}, ${effa}, NOW());
