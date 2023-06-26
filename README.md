# AWS Cloud Resume

I am working on [this](https://cloudresumechallenge.dev/docs/the-challenge/aws/)!

## Tracker and notes

1. Certification
2. HTML - Done

- Not my resume, just a random paragraph generated using ChatGPT

3. CSS - Done

- Anyhow done, not the point of this project

4. Static Website - Done

- Created an S3 bucket and added in all the `html` and `css` files from this repository in there. Before step 5, had to enable public access in order to view the resources that was imported into s3.

5. HTTPS - Done

- After step 4, the page has not use HTTPS yet. Hence a Cloudfront distribution was created to help with this. Cloudfront acts as a reverse proxy, serving as an intermediary between website's origin server and end user. It terminates SSL connections on our behalf, reliving our server from the computational burden of handling encryption and decryption.

6. DNS - Done

- Utilized Route 53, a DNS web service that helps to route requests to appropriate resources, in other words for this case, to my resume website.
- The website is now available at [https://www.aws-cloud-resume-challenge-lalala.online/](https://www.aws-cloud-resume-challenge-lalala.online/)
- My understanding on how things work altogether from step 2-6:
  - By configuring DNS in Route 53, Route 53 becomes the main DNS for my domain and it manages the DNS records that map my domain name to the IP addresses.
  - Now, when user looks up my website, the browser will perform a DNS look up to find the IP address associated with the domain name entered.
  - DNS Resolver will then contact the root name servers to find the authroitative name servers for the Top Level Domains (TLD) of the domain. the TLD name servers respond with the name servers responsible for the specific domain.
  - The DNS resolver queries the authoritative name servers for the domain to retrieve the IP address associated with the domain name. These authoritative name servers are responsible for storing and providing the DNS records specific to the domain.
  - DNS Resolver will then receive IP address, which is returned to the web browser to establish a connection to the server hosting the website. In our case, the DNS resolver will receive the CloudFront domain name, and the browser initiates a request ot the CloudFront distribution.
  - CloudFront (which is a CDN as well), will then route the request to the nearest edge location. If it is cached, it will directly return the content. Else, CloudFront will retrieve the content from the S3 bucket associated with the CloudFront distribution.
- I found [this resource from Cloudfare](https://www.cloudflare.com/en-gb/learning/dns/what-is-dns/) super useful as well

7. Javascript - Done
8. Database - Done
9. API - Done
10. Python - Done
11. Tests
12. Infrastructure as Code
13. Source Control
14. CI/CD (Back end)
15. CI/CD (Front end)
16. Blog post
