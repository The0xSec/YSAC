package aws_iam

import (
	"fmt"

	"github.com/pulumi/pulumi-aws/sdk/v6/go/aws/iam"
	"github.com/pulumi/pulumi-random/sdk/v4/go/random"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi"
)

func CreateIAMUsers(ctx *pulumi.Context, userCount int) ([]*iam.User, error) {
	var iamUsers []*iam.User

	for i := 0; i < userCount; i++ {
		pet, err := random.NewRandomPet(ctx, fmt.Sprintf("userName-%d", i), &random.RandomPetArgs{
			Length: pulumi.Int(2),
		})
		if err != nil {
			return nil, err
		}

		user, err := iam.NewUser(ctx, fmt.Sprintf("user-%d", i), &iam.UserArgs{
			Name: pet.ID(),
		})
		if err != nil {
			return nil, err
		}

		iamUsers = append(iamUsers, user)
	}

	return iamUsers, nil
}

func CreateIAMGroup(ctx *pulumi.Context, groupName string) (*iam.Group, error) {
	group, err := iam.NewGroup(ctx, groupName, &iam.GroupArgs{
		Name: pulumi.String(groupName),
	})
	if err != nil {
		return nil, err
	}
	return group, nil
}

func AddUsersToGroup(ctx *pulumi.Context, group *iam.Group, users []*iam.User) error {
	for i := 0; i < len(users); i++ {
		group.Arn.ApplyT(func(arn string) (string, error) {
			name := fmt.Sprintf("GroupMembership-%s", arn)
			_, err := iam.NewGroupMembership(ctx, name, &iam.GroupMembershipArgs{
				Group: group.Name,
			})
			return "", err
		})
	}
	return nil
}

func CreateIAMPolicy(ctx *pulumi.Context, policyName string, policyDescription, policyDocument string) (*iam.Policy, error) {
	policy, err := iam.NewPolicy(ctx, policyName, &iam.PolicyArgs{
		Policy: pulumi.String(policyDocument),
	})
	if err != nil {
		return nil, err
	}
	return policy, nil
}

func AttachManagedPolicyToGroup(ctx *pulumi.Context, group *iam.Group, policyArn pulumi.String) error {
	for i := 0; i < 2; i++ {
		_, err := iam.NewGroupPolicyAttachment(ctx, fmt.Sprintf("GroupPolicyAttachment-%d", i), &iam.GroupPolicyAttachmentArgs{
			Group:     group.Name,
			PolicyArn: policyArn,
		})
		if err != nil {
			return err
		}
	}
	return nil
}

func AttachCustomPolicyToGroup(ctx *pulumi.Context, group *iam.Group, policyArn pulumi.StringOutput) error {
	_, err := iam.NewGroupPolicyAttachment(ctx, "GroupPolicyAttachment", &iam.GroupPolicyAttachmentArgs{
		Group:     group.Name,
		PolicyArn: policyArn,
	})
	if err != nil {
		return err
	}
	return nil
}
