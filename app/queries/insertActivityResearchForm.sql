INSERT INTO "ActivityResearchForm"(
            "GOSMActivity",
            "idNumber",
            "email" 
            "positionInOrganization", 
            "IUTPOTA", 
            "TASMI", 
            "IFIDTA", 
            "TAWWP", 
            "TOUMTGTTA",
            field6, 
            field7, 
            "WWWITA", 
            "FAC", 
            "EFFA", 
            "dateSubmitted")
    VALUES (${gosmactivity}, ${idNumber}, ${email}, ${positionInOrganization}, ${iutpota}, ${tasmi}, 
            ${ifidta}, ${tawwp}, ${toumtgtta}, ${field6}, ${field7}, ${wwwita}, ${fac}, ${effa}, NOW());
