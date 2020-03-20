import express from "express";
import { getTimelines, getGlobalTimeline } from "../controllers/index";

const router = express.Router();

router.get("/timelines", getTimelines);
router.get("/global-timeline", getGlobalTimeline);

export default router;