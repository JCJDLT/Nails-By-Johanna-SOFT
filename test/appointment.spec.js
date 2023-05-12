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

describe("GET /appointment", () => {
    let cookie;
    // Inicia sesión antes de ejecutar las pruebas
    beforeAll(async () => {
        cookie = await login();
    });

    test("Deberia responder con un estado 200", async () => {
        const response = await request(app).get("/appointment").set('Cookie', cookie).send();
        expect(response.statusCode).toBe(302);
    })
});

describe("GET - POST /appointment/add", () => {
    let cookie;
    // Inicia sesión antes de ejecutar las pruebas
    beforeAll(async () => {
        cookie = await login();
    });

    test("Deberia responder con un estado 200", async () => {
        const response = await request(app).get("/appointment/add").set('Cookie', cookie).send();
        expect(response.statusCode).toBe(302);
    })

    test("Debería agregar una cita correctamente", async () => {

        const postData = {
            date: "2024-06-12",
            start_time: "12:00:00",
            nails: 1,
        };

        const response = await request(app).post("/appointment/add").set('Cookie', cookie).send(postData);
        expect(response.statusCode).toBe(302);
    })
});

describe('DELETE /appointment/delete/:id', () => {
    let cookie;
    // Inicia sesión antes de ejecutar las pruebas
    beforeAll(async () => {
        cookie = await login();
    });
    
    test('Deberia cambiar el estado de la cita y redireccionar a otra pagina', async () => {
        const id = 61;

        const response = await request(app).get(`/appointment/delete/${id}`).set('Cookie', cookie);
        expect(response.statusCode).toBe(302);
    });
});

describe("GET - POST /appointment/edit/:id", () => {
    let cookie;
    // Inicia sesión antes de ejecutar las pruebas
    beforeAll(async () => {
        cookie = await login();
    });

    test("Deberia responder con un estado 200", async () => {
        const id = 90;
        const response = await request(app).get(`/appointment/edit/${id}`).set('Cookie', cookie).send();
        expect(response.statusCode).toBe(302);
    })

    test("Debería editar una cita correctamente", async () => {

        const postData = {
            date: "2024-06-12",
            start_time: "14:00:00",
            nails: 1,
        };

        const response = await request(app).post("/appointment/add").set('Cookie', cookie).send(postData);
        expect(response.statusCode).toBe(302);
    })
});