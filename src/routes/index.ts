import express from "express";
import { getTimelines, getGlobalTimeline, getCountrySummary } from "../controllers/index";

const router = express.Router();

router.get("/timelines", getTimelines);
router.get("/global-timeline", getGlobalTimeline);
router.get("/summary/:countryCode", getCountrySummary);

export default router;