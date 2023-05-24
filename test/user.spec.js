import app from "../src/app";
import request from "supertest";
import dotenv from 'dotenv';
dotenv.config();

async function login() {
    const response = await request(app).post('/signin').send({
        email: process.env.TEST_EMAIL,
        password: process.env.TEST_PASSWORD,
    });
    // Guarda la cookie de sesión
    const cookie = response.headers['set-cookie'];
    return cookie;
}

// Función para simplificar las pruebas
async function testGetEndpoint(path,cookie) {
    const response = await request(app).get(path).set('Cookie', cookie).send();
    expect(response.statusCode).toBe(200);
}

describe("GET /profile", () => {
    let cookie;
    // Inicia sesión antes de ejecutar las pruebas
    beforeAll(async () => {
        cookie = await login();
    });
    test("deberia responder con un estado 200", async () => {
        await testGetEndpoint("/profile",cookie);
    })
});

describe("GET /records", () => {
    let cookie;
    // Inicia sesión antes de ejecutar las pruebas
    beforeAll(async () => {
        cookie = await login();
    });
    test("deberia responder con un estado 200", async () => {
        await testGetEndpoint("/records",cookie);
    })
});

describe("GET /statistics", () => {
    let cookie;
    // Inicia sesión antes de ejecutar las pruebas
    beforeAll(async () => {
        cookie = await login();
    });
    test("deberia responder con un estado 200", async () => {
        await testGetEndpoint("/statistics",cookie);
    })
});

describe("GET - POST /admin", () => {
    let cookie;
    // Inicia sesión antes de ejecutar las pruebas
    beforeAll(async () => {
        cookie = await login();
    });
    test("deberia responder con un estado 200", async () => {
        await testGetEndpoint("/admin",cookie);
    });

    test("Debería editar el precio de las uñas correctamente", async () => {
        const id = 1;     
        const postData = {
            price: 80000,
        };
        const response = await request(app).post(`/admin/${id}`).set('Cookie', cookie).send(postData);
        expect(response.statusCode).toBe(302);
    });
});