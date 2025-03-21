const Minio = require('minio'); // Correct package name

// MinIO client configuration
const storageClient = new Minio.Client({
  endPoint: '194.136.185.141',                              // MinIO server hostname (fixed IP typo)
  port: 9000,                                               // Default MinIO port
  useSSL: false,                                            // Set to true for HTTPS
  accessKey: 'HTkDFKvkz7grU3qIPgDk',                        // MinIO access key
  secretKey: 'cJwK85jmHarjY5K78SuVcm5qVIswKRcpubGHqC0z'     // MinIO secret key
});

const bucket = 'youthcongressnepal';

// Function to check connection and specific bucket
async function connectStorage() {
  try {
    // Verify MinIO connection by listing buckets
    const buckets = await storageClient.listBuckets();
    console.log('Connected to MinIO');

    // Check if the specific bucket exists
    const bucketExists = buckets.some(b => b.name === bucket);
    if (bucketExists) {
      console.log(`Bucket '${bucket}' found and connection established`);
    } else {
      console.log(`Bucket '${bucket}' not found`);
      throw new Error(`Bucket '${bucket}' does not exist`);
    }

    return storageClient; // Return client for further use
  } catch (error) {
    console.error('MinIO connection or bucket check failed:', error);
    throw error;
  }
}

module.exports = { connectStorage, getClient: () => storageClient, bucket };