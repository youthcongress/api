const {MongoClient} = require('mongodb');

const mongoUrl = 'mongodb+srv://chetanbudathoki:t4l0EkrUoWHCs03X@youthcongressnepal.h0q3w.mongodb.net';
const dbName = 'youthcongressnepal';

// Establish connection
const client = new MongoClient(mongoUrl);
let db;

async function connectDB() {
  try {
    await client.connect();
    db = client.db(dbName);
    console.log('Connected to MongoDB');
    return db;
  } catch (error) {
    console.error('MongoDB connection error:', error);
    throw error;
  }
}

module.exports = { connectDB };