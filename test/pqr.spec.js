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

describe("GET - POST /listpqr/", () => {
    let cookie;
    // Inicia sesión antes de ejecutar las pruebas
    beforeAll(async () => {
        cookie = await login();
    });

    test("Deberia responder con un estado 200", async () => {
        const response = await request(app).get("/listpqr").set('Cookie', cookie).send();
        expect(response.statusCode).toBe(200);
    })
    
    test("Debería responder una pqr correctamente", async () => {
        const id = 12;     
        const response = await request(app).post(`/listpqr/${id}`).set('Cookie', cookie).send();
        expect(response.statusCode).toBe(302);
    })
});

describe("GET - POST /createpqr/", () => {
    let cookie;
    // Inicia sesión antes de ejecutar las pruebas
    beforeAll(async () => {
        cookie = await login();
    });

    test("Deberia responder con un estado 200", async () => {
        const response = await request(app).get("/createpqr").set('Cookie', cookie).send();
        expect(response.statusCode).toBe(200);
    })

    test("Debería agregar una pqr correctamente", async () => {

        const postData = {
            descripcion: "Cual es el precio de las uñas?",
            id_user: 1,
            fecha: "2023-05-23",
            tipo: "Financiero",
        };

        const response = await request(app).post(`/createpqr/`).set('Cookie', cookie).send(postData);
        expect(response.statusCode).toBe(302);
    })
});