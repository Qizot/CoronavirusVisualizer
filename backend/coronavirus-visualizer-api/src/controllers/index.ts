import { Request, Response } from "express";
import {VirusTimelineSchema} from "../models/timeline";


export const getTimelines = async (req: Request, res: Response) => {
    const countryCodes: string[] = (req.query.countries as string)?.split(",");
    let dateFrom: Date | null = null;
    let dateTo: Date | null = null;
    try {
        if (req.query.dateFrom) {
            dateFrom = new Date(req.query.dateFrom);
        }
        if (req.query.dateTo) {
            dateTo = new Date(req.query.dateTo);
        }
    } catch (err) {
        return res.status(400).json({
            error: "invalid date format, remove date query param or fix format",
            code: 400
        })
    }

    if (!dateFrom) {
        dateFrom = new Date("1900-01-01");
    }
    if (!dateTo) {
        dateTo = new Date("2100-01-01");
    }



    if (!countryCodes) {
        return res.status(400).send({
            error: "lacking 'countries' query field",
            code: 400
        });
    }

    const matchCountries = countryCodes.includes("all") ? null : {
        "$match": {code: {"$in": countryCodes}}
    };

    try {
        VirusTimelineSchema.aggregate([
            matchCountries,
            {
                "$project": {
                  country: 1,
                  code: 1,
                  timeline: {
                    "$filter": {
                      input: "$timeline",
                      as: "timelineItem",
                      cond: {
                        "$and": [
                         {"$gte": ["$$timelineItem.date", dateFrom]},
                         {"$lte": ["$$timelineItem.date", dateTo]},
                        ] 
                      }
                    }
                  }
                }
              },
        ].filter(el => el !== null)).exec((err, timelines) => {
            if (err) {
                return res.status(500).json({
                    error: err,
                    code: 500
                });
            }
            return res.json(timelines);
        });
    } catch (err) {
        return res.status(500).json({
            error: "Internal server error",
            code: 500
        });
    }
}
