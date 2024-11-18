# YSAC

YSAC is a series of golang based Infrastructure as Code (IaC) automations that are designed to be used in a CI/CD pipeline. The tools are designed to be used in a modular fashion, allowing for the user to pick and choose the tools that they need for their specific use case. The tools are designed to be used in a CI/CD pipeline, but can also be used as standalone automation via using the localstack cli. 

## Usage
In order to deploy an example, just `cd` into the targeted example directory and run the following command:
```pulumi preview && pulumi up --yes```

## Customization
You can customize the default deployment by modifying the configuration file located in the `examples/<service>/config.json` directory. The configuration file allows you to alter the number of resources that are created and maintained by the automation state.

## Examples
- [IAM](./examples/iam/README.md)


## Contributing
If you would like to contribute to the project, please read the [CONTRIBUTING.md](./CONTRIBUTING.md) file for more information.