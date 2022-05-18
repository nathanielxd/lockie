import * as admin from "firebase-admin";
import * as emails from '@sendgrid/mail';
import { sendgrid } from "./config";

let serviceAccount = require('../firebase-admin.json');

admin.initializeApp({credential: admin.credential.cert(serviceAccount)});
emails.setApiKey(sendgrid['apiKey']);

exports.account = require('./account-index');