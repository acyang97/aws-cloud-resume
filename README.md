# AWS Cloud Resume

I am working on [this](https://cloudresumechallenge.dev/docs/the-challenge/aws/)! I did not really have much opportunity to play around with AWS related services in my time at Indeed. I found out about the AWS Cloud Resume Challenge through a Telegram group and saw this as a good opportunity for me to learn some of AWS services and dive into the details on how these services work. I have completed up till step 11 as of 26 June 2023, and it was a great way to learn more in AWS so far, since before this, I did not really have a good idea on what app can I build to play around with AWS services. The aim of this challenge is to simply make use of AWS services to host a resume website

## Tracker and notes

1. Certification
2. HTML - Done

- Not my resume, just a random paragraph generated using ChatGPT as I don't want to risk my [current portfolio site](https://www.chunyang-portfolio.lol/) facing some issues from this challenge.

1. CSS - Done

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

- To write some Javascript code to show the render an element in the `index.html` to show the number of visitors to my portfolio currently. Nothing new to a frontend geek like me, but I only did this part after completing steps 8-10 as we need to create an api to update and get the number of views to the site.
- A small issue I faced and learnt was that after uploading an updated file to `s3` manually (as I have not done CI/CD yet, in part 14), it might be necessary to invalidate the file in Cloudfront as well, as Cloudfront caches static content for 24 hours.

8. Database - Done

- Setting up Dynamodb to store the number of views to the current site. I dive too much into dynamodb low level details, but it seems very similar to MongoDB in terms of both being a NoSQL database, both can be fully managed service and highly scalable. I also read up more on when to choose one over another in [this blog](https://rockset.com/blog/mongodb-vs-dynamodb-head-to-head-which-should-you-choose/)

9.  API - Done
10. Python - Done

- Part 9 and 10 are sort of things that should be done together, so I will write down my process and learnings here together.
- Created a lambda serverless function that runs on the cloud, which seems like a pretty useful thing to me. I wrote a lambda function to update the `view` value in the `dynamodb` table by 1, and return the updated view value as a JSON response. This function will then be called by a javascript script (in step 7) to render the document to show the number of visitors to the website.
- Additionally, the use of API gateway was necessary in order to create an api to call the lambda function.
- I also found out about the existence of CloudWatch to read up error logs of the lambda function when required, to debug a stupid mistake I made of using an undeclared variable initially.

11. Tests

- Will revisit this later

12. Infrastructure as Code - Currently here learning how to make use of terraform
13. Source Control - Done
14. CI/CD (Back end)
15. CI/CD (Front end)
16. Blog post
