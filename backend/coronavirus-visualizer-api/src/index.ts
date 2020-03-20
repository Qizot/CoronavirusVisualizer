import express from 'express';
import { PORT } from './config/constants';
import indexRouter from "./routes/index";
import mongoose from 'mongoose';

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

app.listen(PORT, () => {
    console.log(`Server is listening on port ${PORT}`);
});

