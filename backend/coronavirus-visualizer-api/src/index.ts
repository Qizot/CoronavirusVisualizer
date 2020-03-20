import express from 'express';
import { PORT } from './config/constants';
import indexRouter from "./routes/index";
import mongoose from 'mongoose';
import {CronJob} from "cron";
import { refreshTimelinesJob } from './services/timeline_refresher';

const app = express();
app.use(express.json());

app.use("/api", indexRouter);

const mongoUri = "mongodb://localhost/corona_visualizer";

app.use(express.json());

mongoose.connect(mongoUri, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}, (err) => {
  if (err) {
    console.log("MongoDB: ", err);
  } else {
    console.log("Connected to MongoDb");
  }
});

// run cron job every full hour - refreshing timelines
const job = new CronJob("0 * * * *", () => {
    refreshTimelinesJob();
});

job.start();

app.listen(PORT, () => {
    console.log(`Server is listening on port ${PORT}`);
});

