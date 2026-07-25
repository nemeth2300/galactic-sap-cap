import cds from "@sap/cds";

class CosmosService extends cds.ApplicationService {
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
      sendWelcomeEmail(email, entity);
    });

    return super.init();
  }
}

export default CosmosService;

const sendMail = (to, subject, text) => {
  // Whatever email service we are using
};

const sendWelcomeEmail = (to, spacefarer) => {
  console.log(`Spacefarer ${spacefarer.name} has been created successfully.`);
  sendMail(to, "Welcome to Spacefarer", "Welcome to the Spacefarer program!");
};
