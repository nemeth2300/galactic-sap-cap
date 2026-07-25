import cds from "@sap/cds";
import EmailService from "./email-service.js";

class CosmosService extends cds.ApplicationService {
  emailService = new EmailService(); // how tf does dependency injection work in CAP

  init() {
    const { Spacefarers } = this.entities;

    this.before("READ", Spacefarers, async (req) => {
      const [spacefarer] = await cds.ql
        .SELECT("Spacefarers")
        .where({ createdBy: req.user?.id })
        .limit(1);

      if (!spacefarer) {
        return req.error(
          403,
          `User ${req.user?.id} does not have a spacefarer yet.`,
        );
      }

      req.query.where("origin_planet_ID", "=", spacefarer.origin_planet_ID);
    });

    this.before("CREATE", Spacefarers, async (req) => {
      // Check if the user already has a spacefarer
      const [currentSpacefarer] = await cds.ql
        .SELECT("Spacefarers")
        .where({ createdBy: req.user?.id })
        .limit(1);

      if (currentSpacefarer) {
        return req.error(
          400,
          `User ${req.user?.id} already has a spacefarer with ID ${currentSpacefarer.ID}.`,
        );
      }

      const [dust] = await cds.ql
        .SELECT("StarDusts")
        .orderBy({ ID: "asc" })
        .limit(1);

      if (!dust) return;
      req.data.stardust_collection = [{ stardust_ID: dust.ID }];
    });

    this.after("CREATE", Spacefarers, async (entity, req) => {
      const email = req.user.attr?.email ?? "";
      if (!email) return;
      this.emailService.sendMail(
        email,
        "Welcome to Spacefarer",
        "Welcome to the Spacefarer program!",
      );
    });

    return super.init();
  }
}

export default CosmosService;
