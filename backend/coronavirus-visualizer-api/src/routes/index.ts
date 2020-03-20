import express, {Request, Response} from "express";
import {refreshTimelinesJob} from "../services/timeline_refresher";

const router = express.Router();

router.get("/refresh", async (req: Request, res: Response) => {
    refreshTimelinesJob();
    res.send("git gut");
});

export default router;