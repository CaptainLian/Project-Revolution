INSERT INTO "ActivityResearchForm"(
            "GOSMActivity", "positionInOrganization", "IUTPOTA", 
            "TASMI", "IFIDTA", "TAWWP", "TOUMTGTTA", field6, field7, "WWWITA", "FAC", "EFFA", 
            "dateSubmitted")
    VALUES (${gosmactivity}, ${positionInOrganization}, ${iutpota}, ${tasmi}, 
            ${ifidta}, ${tawwp}, ${toumtgtta}, ${field6}, ${field7}, ${wwwita}, ${fac}, ${effa}, NOW());
