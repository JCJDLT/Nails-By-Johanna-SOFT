import { Router } from "express";
import { isLoggedIn } from "../lib/auth.js";
import {
    renderUserProfile,
    renderRecords,
    renderUserAdmin,
    renderStatisticsAdmin,
    editPriceNails,
    renderListPqr,
    createPqr,
    renderCreatePqr,
    donePqr
} from "../controllers/user.controller.js";

const router = Router();

router.get("/profile", isLoggedIn, renderUserProfile);
router.get("/records", isLoggedIn, renderRecords);
router.get("/statistics", isLoggedIn, renderStatisticsAdmin)
router.get("/admin", isLoggedIn, renderUserAdmin);
router.post("/admin/:id", isLoggedIn, editPriceNails);
router.get("/listpqr",renderListPqr);
router.post("/listpqr/:id",donePqr);
router.get("/createpqr",renderCreatePqr);
router.post("/createpqr",createPqr);


export default router;