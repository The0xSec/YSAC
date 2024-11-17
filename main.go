package main

import (
	"encoding/json"
	"fmt"
	"os"

	"github.com/pulumi/pulumi/sdk/v3/go/pulumi"
	aws_iam "github.com/the0xsec/YSAC/libs/iam"
)

type Config struct {
	UserCount      int    `json:"user_count"`
	DeveloperGroup string `json:"developer_group"`
	OperatorsGroup string `json:"operators_group"`
	VPCPolicy      string `json:"vpc_policy"`
}

func main() {
	configFile := "config.json"
	configData, err := os.ReadFile(configFile)
	if err != nil {
		fmt.Printf("Error reading configuration file: %v\n", err)
		os.Exit(1)
	}

	var config Config
	if err := json.Unmarshal(configData, &config); err != nil {
		fmt.Printf("Error parsing configuration: %v\n", err)
		os.Exit(1)
	}

	pulumi.Run(func(ctx *pulumi.Context) error {
		users, err := aws_iam.CreateIAMUsers(ctx, config.UserCount)
		if err != nil {
			return err
		}

		developerGroup, err := aws_iam.CreateIAMGroup(ctx, config.DeveloperGroup)
		if err != nil {
			return err
		}

		err = aws_iam.AttachManagedPolicyToGroup(ctx, developerGroup, "arn:aws:iam::aws:policy/AWSLambda_FullAccess")
		if err != nil {
			return err
		}

		err = aws_iam.AddUsersToGroup(ctx, developerGroup, users[:2])
		if err != nil {
			return err
		}

		operatorsGroup, err := aws_iam.CreateIAMGroup(ctx, config.OperatorsGroup)
		if err != nil {
			return err
		}

		vpcPolicy, err := aws_iam.CreateIAMPolicy(ctx, "VPCManagementPolicy", "Policy to manage a specific VPC", config.VPCPolicy)
		if err != nil {
			return err
		}

		err = aws_iam.AttachCustomPolicyToGroup(ctx, operatorsGroup, vpcPolicy.Arn)
		if err != nil {
			return err
		}

		err = aws_iam.AddUsersToGroup(ctx, operatorsGroup, users)
		if err != nil {
			return err
		}

		return nil
	})
}
