import cds from "@sap/cds";

// New environemnts as to reset the data
const createTestEnvironment = () => {
  const testEnvironment = cds.test();
  testEnvironment.defaults.auth = { username: "Alice", password: "Alice" };
  testEnvironment.defaults.path = "/cosmos";

  return testEnvironment;
};

describe("spacefarer creation", () => {
  const { GET, POST, expect } = createTestEnvironment();

  it("should allow creating a new spacefarer", async () => {
    const response = await POST`/Spacefarers ${{
      name: "Nova Starling",
      wormhole_navigation_skill: 90,
      spacesuit_color: "blue",
      origin_planet_ID: "11a1b1c1-d1e1-4f01-8a11-111111111111",
    }}`;
    expect(response.status).to.equal(201);
  });

  it("must not allow creating a spacefarer with more than the maximum of wormhole navigation skill", async () => {
    const response = POST`/Spacefarers ${{
      name: "Nova Starling",
      wormhole_navigation_skill: 200,
      spacesuit_color: "blue",
      origin_planet_ID: "11a1b1c1-d1e1-4f01-8a11-111111111111",
    }}`;

    await expect(response).to.be.rejected;
  });
});

describe("browse spacefarers", () => {
  describe("without a spacefarer", () => {
    const { GET, expect } = createTestEnvironment();

    it("should not allow fetching spacefarers", async () => {
      const response = GET`Spacefarers`;
      await expect(response).to.be.rejectedWith(401);
    });
  });

  describe("with a spacefarer already", async () => {
    const { GET, POST, expect } = createTestEnvironment();

    it("should not allow fetching spacefarers without having a spacefarer already", async () => {
      const response = GET`Spacefarers`;
      await expect(response).to.be.rejectedWith(403);
    });

    it("should allow fetching lists of spacefarers once you have one", async () => {
      await cds.ql.INSERT.into("cosmos.Spacefarers").entries({
        name: "Lyra Quill",
        wormhole_navigation_skill: 85,
        spacesuit_color: "red",
        origin_planet_ID: "11a1b1c1-d1e1-4f01-8a11-111111111111",
        createdBy: "Alice",
      });

      const { data } = await GET`Spacefarers`;
      expect(data.value.length).to.gt(0);
      expect(data.value[0]).to.include({
        name: "Lyra Quill",
        wormhole_navigation_skill: 85,
        spacesuit_color: "red",
      });
    });
  });
});
