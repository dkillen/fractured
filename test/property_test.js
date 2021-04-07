const PropertyContract = artifacts.require("Property");

contract("Property", accounts => {
    let property;
    const propertyAddress = "1313 Mockingbird Lane, Mockingbird Heights, NSW 2123";
    const titleParticulars = "Lot 123 in Deposited Plan 123123";
    const maxShares = 100;
    const trustee = accounts[1];

    beforeEach(async () => {
        property = await PropertyContract.new(
            propertyAddress,
            titleParticulars,
            maxShares,
            trustee
        ) ;
    });

    describe("Initialisation", () => {
        it("gets the property address", async () => {
            const actual = await property.propertyAddress();
            assert.equal(actual, propertyAddress, "addresses should match");
        });

        it("gets the title particulars", async () => {
            const actual = await property.titleParticulars();
            assert.equal(actual, titleParticulars, "title particulars should match");
        });

        it("gets the max shares", async () => {
            const actual = await property.maxShares();
            assert.equal(actual, maxShares, "max shares should match");
        });

        it("gets the trustee", async () => {
            const actual = await property.trustee();
            assert.equal(actual, trustee, "trustees should match");
        });

    });
});