import fetch from "node-fetch";
import { VirusTimelineType, VirusTimelineSchema } from "../models/timeline";


const countries: {[key: string]: any} = {
    "Albania": "AL",
    "Austria": "AT",
    "Belarus": "BY",
    "Belgium": "BE",
    "Bosnia and Herzegovina": "BA",
    "Bulgaria": "BG",
    "Burkina Faso": "BF",
    "Costa Rica": "CR",
    "Croatia": "HR",
    "Cyprus": "CY",
    "Czech Republic": "CZ",
    "Denmark": "DK",
    "Egypt": "EG",
    "Estonia": "EE",
    "Finland": "FI",
    "France": "FR",
    "Germany": "DE",
    "Greece": "GR",
    "Greenland": "GL",
    "Hungary": "HU",
    "Iceland": "IS",
    "Ireland": "IE",
    "Israel": "IL",
    "Italy": "IT",
    "Latvia": "LV",
    "Lithuania": "LT",
    "Luxembourg": "LU",
    "Macedonia": "MK",
    "Moldova": "MD",
    "Mongolia": "MN",
    "Montenegro": "ME",
    "Netherlands": "NL",
    "Norway": "NO",
    "Poland": "PL",
    "Portugal": "PT",
    "Puerto Rico": "PR",
    "Romania": "RO",
    "Russia": "RU",
    "Serbia": "RS",
    "Slovakia": "SK",
    "Slovenia": "SI",
    "Spain": "ES",
    "Swaziland": "SZ",
    "Sweden": "SE",
    "Switzerland": "CH",
    "Turkey": "TR",
    "United Kingdom": "GB",
    "Ukraine": "UA"
}

export const refreshTimelinesJob = async () => {
    const APIS = ["thevirustracker", "graphql"];

    for (let key in countries) {
        for (let api in APIS) {
            const url = `http://127.0.0.1:5000/api/timelines/${countries[key]}?api=${api}`;
            try {
                const response = await fetch(url);
                const body = await response.json();
                const timeline = await VirusTimelineSchema.findOne({code: key});
                if (timeline) {

                    timeline.timeline = body['timeline'];
                    await timeline.save();

                } else {
                    const newTimeline = new VirusTimelineSchema({
                        country: countries[key],
                        code: key,
                        timeline: body['timeline']
                    });
                    await newTimeline.save();
                }
                break;

            } catch (err) {
                console.log("error while updating timeline");
            }


        }
    }
}