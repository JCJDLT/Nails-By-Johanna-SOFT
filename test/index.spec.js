import app from "../src/app";
import request from "supertest";

// Función para simplificar las pruebas
async function testGetEndpoint(path) {
    const response = await request(app).get(path).send();
    expect(response.statusCode).toBe(200);
}

describe("GET /", () => {
    test("deberia responder con un estado 200", async () => {
        await testGetEndpoint("/");
    })
});

describe("GET /catalogue", () => {
    test("deberia responder con un estado 200", async () => {
        await testGetEndpoint("/catalogue");
    })
});

describe("GET /consulta", () => {
    test("deberia responder con un estado 200", async () => {
        await testGetEndpoint("/consulta");
    })
});