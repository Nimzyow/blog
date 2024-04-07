Create S3 bucket to host static site objects<br/> DONE
Build gatsby site and push objects to S3, example of below command:<br/>
```bash
aws s3 sync ./public s3://example-of-my-bucket-name/
```
Create Origin access control (give it the name of your s3 bucket url e.g: nimasoufiani-blog.s3.eu-west-2.amazonaws.com)<br/> DONE
We need to create a Cloudfront distribution for NA and Europe only<br/> DONE
Cloudfront distribution set Default root object as index.html<br/> DONE
Setup WAF for Cloudfront distribution.<br/> No need?
Attach Origin access control to Cloudfront Distribution<br/> DONE
Cloudfront distribution set Redirect HTTP to HTTPS DONE
Cloudfront compress objects automatically. DONE
We need to create a Policy to attach to S3 with Cloudfront details. Example below: DONE
```json
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::nimasoufiani-blog/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "REPLACE WITH CLOUDFRONT DISTRIBUTION ARN"
                }
            }
        }
    ]
}
```
Attach policy to S3 bucket<br/> DONE

See if Terraform can apply only one resource. Yes, you can through something like:
```bash
terraform plan -target=aws_s3_bucket.nimasoufiani-blog -out=tfplan -var env=stage
```
TODO: Workflow will be configured to the following:
dev and staging branch:
1 - Clone repo
2 - npm i
3 - build project
4 - Assume role. Permission for cloudfront distribution creation, s3 bucket creation for dev/staging
5 - Use terraform to create bucket only
6 - push artifacts to bucket
7 - Use terraform to apply everything else

production branch:
1 - Clone repo
2 - npm i
3 - build project
4 - Assume role. Permission for cloudfront distribution creation, s3 bucket creation for dev/staging
5 - Use terraform to create bucket only FOR STAGING
6 - push artifacts to STAGING bucket
7 - Use terraform to apply everything else to STAGING environment (staging for cloudfront, policies etc.. )
8 - Use terraform to create bucket only for PRODUCTION
9 - push artifacts to PRODUCTION bucket
10 - Use terraform to apply everything else to PRODUCTION environment




Managed to set up IODC successfully. 
Need to create an identifier in aws. See these 2 guides:
* https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/
* https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services


You cannot dynamically create new s3 buckets if they all sit under the same resource


<p align="center">
  <a href="https://www.gatsbyjs.com/?utm_source=starter&utm_medium=readme&utm_campaign=minimal-starter-ts">
    <img alt="Gatsby" src="https://www.gatsbyjs.com/Gatsby-Monogram.svg" width="60" />
  </a>
</p>
<h1 align="center">
  Gatsby Minimal TypeScript Starter
</h1>

## 🚀 Quick start

1.  **Create a Gatsby site.**

    Use the Gatsby CLI to create a new site, specifying the minimal TypeScript starter.

    ```shell
    # create a new Gatsby site using the minimal TypeScript starter
    npm init gatsby -- -ts
    ```

2.  **Start developing.**

    Navigate into your new site’s directory and start it up.

    ```shell
    cd my-gatsby-site/
    npm run develop
    ```

3.  **Open the code and start customizing!**

    Your site is now running at http://localhost:8000!

    Edit `src/pages/index.tsx` to see your site update in real-time!

4.  **Learn more**

    - [Documentation](https://www.gatsbyjs.com/docs/?utm_source=starter&utm_medium=readme&utm_campaign=minimal-starter-ts)
    - [Tutorials](https://www.gatsbyjs.com/docs/tutorial/?utm_source=starter&utm_medium=readme&utm_campaign=minimal-starter-ts)
    - [Guides](https://www.gatsbyjs.com/docs/how-to/?utm_source=starter&utm_medium=readme&utm_campaign=minimal-starter-ts)
    - [API Reference](https://www.gatsbyjs.com/docs/api-reference/?utm_source=starter&utm_medium=readme&utm_campaign=minimal-starter-ts)
    - [Plugin Library](https://www.gatsbyjs.com/plugins?utm_source=starter&utm_medium=readme&utm_campaign=minimal-starter-ts)
    - [Cheat Sheet](https://www.gatsbyjs.com/docs/cheat-sheet/?utm_source=starter&utm_medium=readme&utm_campaign=minimal-starter-ts)

## 🚀 Quick start (Netlify)

Deploy this starter with one click on [Netlify](https://app.netlify.com/signup):

[<img src="https://www.netlify.com/img/deploy/button.svg" alt="Deploy to Netlify" />](https://app.netlify.com/start/deploy?repository=https://github.com/gatsbyjs/gatsby-starter-minimal-ts)
