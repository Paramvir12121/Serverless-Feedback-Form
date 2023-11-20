# Serverless Feedback Form Deployment on AWS with Terraform

This repository contains Terraform configurations to automate the deployment of a serverless feedback form on AWS. Feedback submitted through the form is processed by a Lambda function, stored in DynamoDB, and an SNS notification is triggered if necessary. The feedback form webpage is hosted on an S3 bucket and is connected to the REST API Gateway.

### ! Please note that this Repository is WORK IN PROGRESS and is NOT Complete in its function.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Repository Structure](#repository-structure)
- [Architecture Overview](#architecture-overview)
- [Customization](#customization)
- [Contributing](#contributing)

<a name="prerequisites"></a>
## 🔍 Prerequisites

Ensure you have the following:

- AWS Account
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate permissions
- [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)

<a name="quick-start"></a>
## 🚀 Quick Start

1. **Clone the Repository**

    ```bash
    git clone https://github.com/Paramvir12121/Serverless-Feedback-Form.git
    cd Serverless-Feedback-Form
    ```
    If you want to check out the modular deployment of the code, go to:
    ```
    cd terraform
    ```

    For non-modular Deployment, go to:
    ```
    cd terraform-non-modular
    ```
    Both use basically the same code but the the modular code uses the principles of Orthogonality to make it easily reusable. On the other hand, Non-Modular Code is simpler.

2. **Initialize Terraform**

    ```bash
    terraform init
    ```

3. **Apply Terraform Configuration**

    ```bash
    terraform apply
    ```

    Confirm the actions when prompted by typing `yes`.

4. Once deployed, you can access the feedback form via the S3 bucket URL provided in the outputs.

<a name="repository-structure"></a>
## 📁 Repository Structure
- `terraform` : Primary directory containing terraform code. 
    - `lambda_functions` : Directory containing lambda function code.
    - `modules` : Directory containg terraform module blocks.
        - `main.tf`: Primary Terraform configuration file for AWS resources.
        - `variables.tf`: Contains variable definitions.
        - `outputs.tf`: Output configurations post `terraform apply`.
- `website` : Primary directory containg html website to be uploaded and hosted in S3 bucket.

<a name="architecture-overview"></a>
## 🌐 Architecture Overview

- **S3 Bucket**: Hosts the feedback form webpage.
- **API Gateway**: Exposes REST endpoints for the feedback form operations.
- **Lambda Function**: Processes feedback data and interacts with DynamoDB.
- **DynamoDB**: Stores feedback data.
- **SNS Topic**: Sends notifications based on specific conditions or feedback content.

<a name="customization"></a>
## 🔧 Customization

You can modify the feedback form or the processing logic by updating the files in the `assets/` directory and the Lambda function code respectively. Ensure you adjust Terraform configurations as necessary.

<a name="contributing"></a>
## 👥 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss your proposal.


---

For additional information or support, refer to the official AWS and Terraform documentation or open an issue in this repository.
