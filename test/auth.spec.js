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

describe("GET - POST /signup", () => {

    test("Deberia responder con un estado 200", async () => {
        const response = await request(app).get("/signup").send();
        expect(response.statusCode).toBe(200);
    })

    test("Deberia poder registrarse y ser redireccionado de pagina", async () => {

        const postData = {
            fullname: "Prueba test",
            email: "pruebatest@gmail.com",
            phone: 8787676565,
            password1: process.env.TEST_PASSWORD_PRUEBA,
            password2: process.env.TEST_PASSWORD_PRUEBA,
        };

        const response = await request(app).post("/signup").send(postData);
        expect(response.statusCode).toBe(302);
        expect(response.headers['location']).toBe('/');
    })
});

describe("GET - POST /signin", () => {

    test("Deberia responder con un estado 200", async () => {
        const response = await request(app).get("/signin").send();
        expect(response.statusCode).toBe(200);
    })

    test("Deberia poder registrarse y ser redireccionado de pagina", async () => {

        const postData = {
            email: process.env.TEST_EMAIL,
            password: process.env.TEST_PASSWORD,
        };

        const response = await request(app).post("/signin").send(postData);
        expect(response.statusCode).toBe(302);
        expect(response.headers['location']).toBe('/');
    })
});

describe("GET /logout", () => {

    test("Deberia responder con un estado 200", async () => {
        const response = await request(app).get("/logout").send();
        expect(response.statusCode).toBe(302);
        expect(response.headers['location']).toBe('/');
    })
});