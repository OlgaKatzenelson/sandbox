/**
  * Created by dpavlov on 12/09/2016.
  */

import org.scalatest.{FeatureSpec, GivenWhenThen}

import scala.collection.mutable.Stack

class ExampleSpec extends FeatureSpec with GivenWhenThen {

  feature("The user can pop an element off the top of the stack") {

    info("As a programmer")
    info("I want to be able to pop items off the stack")
    info("So that I can get them in last-in-first-out order")

    scenario("pop is invoked on a non-empty stack") {

      Given("a non-empty stack")
      val stack = new Stack[Int]
      stack.push(1)
      stack.push(2)
      val oldSize = stack.size

      When("when pop is invoked on the stack")
      val result = stack.pop()

      Then("the most recently pushed element should be returned")
      assert(result === 2)

      And("the stack should have one less item than before")
      assert(stack.size === oldSize - 1)
    }

    scenario("pop is invoked on an empty stack") {

      Given("an empty stack")
      val emptyStack = new Stack[Int]

      When("When pop is invoked on the stack")
      Then("NoSuchElementException should be thrown")
      intercept[NoSuchElementException] {
        emptyStack.pop()
      }
      //emptyStack.push(1)
      And("the stack should still be empty")
      assert(emptyStack.isEmpty)
    }
  }
}
