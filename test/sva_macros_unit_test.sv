// Copyright 2016 Tudor Timisescu (verificationgentleman.com)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


module sva_macros_unit_test;
  import svunit_pkg::svunit_testcase;
  `include "svunit_defines.svh"

  `include "vgm_svunit_utils_macros.svh"

  string name = "sva_macros_ut";
  svunit_testcase svunit_ut;

  bit HCLK;
  always #1 HCLK = ~HCLK;

  default clocking cb @(posedge HCLK);
  endclocking


  function void build();
    svunit_ut = new(name);
  endfunction


  task setup();
    svunit_ut.setup();
  endtask


  task teardown();
    svunit_ut.teardown();
  endtask



  `SVUNIT_TESTS_BEGIN

    `SVTEST(FAIL_IF_PROP_PASS__true_prop__fails)
      `FAIL_IF_PROP_PASS(1)
    `SVTEST_END

    `SVTEST(FAIL_IF_PROP_PASS__false_prop__passes)
      `FAIL_IF_PROP_PASS(0)
    `SVTEST_END

    `SVTEST(FAIL_IF_PROP_PASS__vac_prop__passes)
      `FAIL_IF_PROP_PASS(0 |-> 1)
    `SVTEST_END


    `SVTEST(FAIL_IF_PROP_FAIL__true_prop__passes)
      `FAIL_IF_PROP_FAIL(1)
    `SVTEST_END

    `SVTEST(FAIL_IF_PROP_FAIL__false_prop__fails)
      `FAIL_IF_PROP_FAIL(0)
    `SVTEST_END

    `SVTEST(FAIL_IF_PROP_FAIL__vac_prop__passes)
      `FAIL_IF_PROP_FAIL(0 |-> 1)
    `SVTEST_END


    `SVTEST(FAIL_IF_PROP_VAC__true_prop__passes)
      `FAIL_IF_PROP_VAC(1)
    `SVTEST_END

    `SVTEST(FAIL_IF_PROP_VAC__false_prop__passes)
      `FAIL_IF_PROP_VAC(0)
    `SVTEST_END

    `SVTEST(FAIL_IF_PROP_VAC__vac_prop__fails)
      `FAIL_IF_PROP_VAC(0 |-> 1)
    `SVTEST_END



    `SVTEST(FAIL_UNLESS_PROP_PASS__true_prop__passes)
      `FAIL_UNLESS_PROP_PASS(1)
    `SVTEST_END

    `SVTEST(FAIL_UNLESS_PROP_PASS__false_prop__fails)
      `FAIL_UNLESS_PROP_PASS(0)
    `SVTEST_END

    `SVTEST(FAIL_UNLESS_PROP_PASS__vac_prop__fails)
      `FAIL_UNLESS_PROP_PASS(0 |-> 1)
    `SVTEST_END


    `SVTEST(FAIL_UNLESS_PROP_FAIL__true_prop__fails)
      `FAIL_UNLESS_PROP_FAIL(1)
    `SVTEST_END

    `SVTEST(FAIL_UNLESS_PROP_FAIL__false_prop__passes)
      `FAIL_UNLESS_PROP_FAIL(0)
    `SVTEST_END

    `SVTEST(FAIL_UNLESS_PROP_FAIL__vac_prop__fails)
      `FAIL_UNLESS_PROP_FAIL(0 |-> 1)
    `SVTEST_END


    `SVTEST(FAIL_UNLESS_PROP_VAC__true_prop__fails)
      `FAIL_UNLESS_PROP_VAC(1)
    `SVTEST_END

    `SVTEST(FAIL_UNLESS_PROP_VAC__false_prop__fails)
      `FAIL_UNLESS_PROP_VAC(0)
    `SVTEST_END

    `SVTEST(FAIL_UNLESS_PROP_VAC__vac_prop__passes)
      `FAIL_UNLESS_PROP_VAC(0 |-> 1)
    `SVTEST_END


    `SVTEST(FAIL_IF_PROP__true_prop__fails)
      `FAIL_IF_PROP(1)
    `SVTEST_END

    `SVTEST(FAIL_IF_PROP__false_prop__passes)
      `FAIL_IF_PROP(0)
    `SVTEST_END

    `SVTEST(FAIL_IF_PROP__vac_prop__fails)
      `FAIL_IF_PROP(0 |-> 1)
    `SVTEST_END


    `SVTEST(FAIL_UNLESS_PROP__true_prop__passes)
      `FAIL_UNLESS_PROP(1)
    `SVTEST_END

    `SVTEST(FAIL_UNLESS_PROP__false_prop__fails)
      `FAIL_UNLESS_PROP(0)
    `SVTEST_END

    `SVTEST(FAIL_UNLESS_PROP__vac_prop__passes)
      `FAIL_UNLESS_PROP(0 |-> 1)
    `SVTEST_END


    `SVTEST(FAIL_IF_SEQ__matching_seq__fails)
      `FAIL_IF_SEQ(1)
    `SVTEST_END

    `SVTEST(FAIL_IF_SEQ__non_matching_seq__passes)
      `FAIL_IF_SEQ(0)
    `SVTEST_END


    `SVTEST(FAIL_UNLESS_SEQ__matching_seq__passes)
      `FAIL_UNLESS_SEQ(1)
    `SVTEST_END

    `SVTEST(FAIL_UNLESS_SEQ__non_matching_seq__fails)
      `FAIL_UNLESS_SEQ(0)
    `SVTEST_END

  `SVUNIT_TESTS_END

endmodule
