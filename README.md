# Lambda Layers

Lambda-layers for Bagubagu projects.

## Usage

To use `bagubagu-common` nodejs lambda layer, add following to your `sam template`

```yaml
AWSTemplateFormatVersion: "2010-09-09"
Transform: AWS::Serverless-2016-10-31
Resources:
  MyLambda:
    Type: AWS::Serverless::Function
    Properties:
      FunctionName: my-lambda
      # ..
      Layers:
        - "arn:aws:lambda:us-east-1:116952590464:layer:bagubagu-common"
```

To use a specific version

```yaml
AWSTemplateFormatVersion: "2010-09-09"
Transform: AWS::Serverless-2016-10-31
Resources:
  MyLambda:
    Type: AWS::Serverless::Function
    Properties:
      FunctionName: my-lambda
      # ..
      Layers:
        - !Sub arn:aws:lambda:us-east-1:116952590464:layer:bagubagu-common:${LayerVersion}
```

## Develop

Add `useful-library` npm module to bagubagu-common lambda-layer, then publish.

```bash
cd bagubagu-common
yarn --production
yarn add useful-library
cd ..
./scripts/publish-bagubagu-common.sh
```
