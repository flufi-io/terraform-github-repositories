package test

import (
	"github.com/joho/godotenv"
	"log"
	"os"
	"strconv"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCompleteExample(t *testing.T) {

	// DELAY is the time in seconds to run terraform destroy after terraform apply
	DELAY, _ := strconv.Atoi(os.Getenv("DELAY"))
	godotenv.Load("../../.env")

	varFiles := []string{"../../examples/complete/terraform.tfvars"}
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/complete",
		VarFiles:     varFiles,
		Vars:         map[string]interface{}{},
		Upgrade:      true,
		Reconfigure:  true,
	})

	defer terraform.Destroy(t, terraformOptions)
	// Delay the execution of the terraform destroy
	defer func() {
		delay(DELAY)
	}()

	terraform.InitAndApply(t, terraformOptions)

	//output := terraform.Output(t, terraformOptions, "repository_name")
	//assert.Equal(t, "testing-template-repository-jkshdbjk", output)
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
