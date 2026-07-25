import cds from "@sap/cds";

const { GET, POST, expect, defaults } = cds.test();

defaults.auth = { username: "alice" };
defaults.path = "/cosmos";

describe("browse spacefarers", () => {
  it("should allow fetching lists of spacefarers", async () => {
    const { data } = await GET`Spacefarers`;
    expect(data.value).to.have.length(5);
    expect(data.value[0]).to.include({
      name: "Lyra Quill",
      wormhole_navigation_skill: 85,
      spacesuit_color: "red",
    });
  });
});

describe("spacefarer creation", () => {
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
