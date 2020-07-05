import { Mongoose, Schema, model, Document } from "mongoose";


export interface VirusTimelineType extends Document {
    country: string;
    code: string;
    timeline: {
        date: Date;
        new_cases: number;
        new_deaths: number;
        total_cases: number;
        total_deaths: number;
        total_recovered: number;
    }
}

const schema = new Schema({
    country: String,
    code: String,
    timeline: [
        {
            date: Date,
            new_cases: Number,
            new_deaths: Number,
            total_cases: Number,
            total_deaths: Number,
            total_recovered: Number,
        }
    ]
});

export const VirusTimelineSchema = model<VirusTimelineType>("virusTimeline", schema, "virusTimelines");
