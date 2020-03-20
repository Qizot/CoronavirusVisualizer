import express from "express";
import { getTimelines } from "../controllers/index";

const router = express.Router();

router.get("/timelines", getTimelines);

export default router;