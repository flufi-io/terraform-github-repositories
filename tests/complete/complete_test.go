package test

import (
	"log"
	"os"
	"strconv"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestCompleteExample(t *testing.T) {
	log.Println("TOKEN:", os.Getenv("GITHUB_TOKEN"))
	// DELAY is the time in seconds to run terraform destroy after terraform apply
	DELAY, _ := strconv.Atoi(os.Getenv("DELAY"))
	varFiles := []string{"../../examples/complete/terraform.tfvars"}
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/complete",
		VarFiles:     varFiles,
		Vars: map[string]interface{}{
			"github_token": os.Getenv("GITHUB_TOKEN"),
		},
		Upgrade:     true,
		Reconfigure: true,
	})

	defer terraform.Destroy(t, terraformOptions)
	// Delay the execution of the terraform destroy
	defer func() {
		delay(DELAY)
	}()

	terraform.InitAndApply(t, terraformOptions)

	output := terraform.Output(t, terraformOptions, "repository_name")
	assert.Equal(t, "testing-template-repository-jkshdbjk", output)
}

func delay(seconds int) {
	for {
		if seconds <= 0 {
			break
		} else {
			log.Println(seconds)
			time.Sleep(1 * time.Second)
			seconds--
		}
	}
}
