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


import uvm_pkg::*;
`include "uvm_macros.svh"


class some_driver extends uvm_driver #(uvm_sequence_item);
  protected event stop_req;

  virtual task run_phase(uvm_phase phase);
    forever begin
      fork
        get_and_drive();
        @(stop_req);
      join_any
      disable fork;
      uvm_wait_for_nba_region();
    end
  endtask


  virtual function void request_stop();
    -> stop_req;
  endfunction


  protected task get_and_drive();
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info("DRV", $sformatf("Got an item:\n%s", req.sprint()), UVM_NONE)
      #1;
      seq_item_port.item_done();
    end
  endtask


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass


`include "svunit_uvm_mock_pkg.sv"


module some_driver_unit_test;
  import svunit_pkg::svunit_testcase;
  `include "svunit_defines.svh"

  import svunit_uvm_mock_pkg::*;
  import vgm_svunit_utils::*;

  string name = "some_driver_ut";
  svunit_testcase svunit_ut;


  some_driver driver;
  sequencer_stub #(uvm_sequence_item) sequencer;


  function void build();
    svunit_ut = new(name);

    driver = new({name, "__driver"}, null);
    sequencer = new({name, "__sequencer"}, null);
    driver.seq_item_port.connect(sequencer.seq_item_export);

    svunit_deactivate_uvm_component(driver);
  endfunction


  task setup();
    svunit_ut.setup();

    svunit_activate_uvm_component(driver);
    svunit_uvm_test_start();
  endtask


  task teardown();
    svunit_ut.teardown();

    // Flush the sequencer between unit tests
    sequencer.flush();

    driver.request_stop();
    svunit_uvm_test_finish();
    svunit_deactivate_uvm_component(driver);
  endtask



  `SVUNIT_TESTS_BEGIN

    `SVTEST(add_item)
      uvm_sequence_item item = new("item");
      sequencer.add_item(item);
      uvm_wait_for_nba_region();
    `SVTEST_END


    `SVTEST(item_done_called_twice)
      uvm_sequence_item item = new("item");
      sequencer.add_item(item);
      sequencer.add_item(item);
      #2;
      uvm_wait_for_nba_region();
      `FAIL_UNLESS(sequencer.num_item_done_calls == 2)
    `SVTEST_END

  `SVUNIT_TESTS_END

endmodule
