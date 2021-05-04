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


module sequencer_stub_unit_test;
  import svunit_pkg::svunit_testcase;
  `include "svunit_defines.svh"

  import vgm_svunit_utils::*;

  string name = "sequencer_stub_ut";
  svunit_testcase svunit_ut;


  class dummy_item;
  endclass


  sequencer_stub #(dummy_item) seqr;

  function void build();
    svunit_ut = new(name);
    
    seqr = new("sequencer_stub_unit_test_seqr", null);
  endfunction


  task setup();
    svunit_ut.setup();
  endtask


  task teardown();
    svunit_ut.teardown();
  endtask



  `SVUNIT_TESTS_BEGIN

    `SVTEST(check_code_compiles)
      // Try compiling with desired UVM version.
    `SVTEST_END


  `SVUNIT_TESTS_END

endmodule
