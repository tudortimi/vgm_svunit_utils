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



interface some_interface(input bit clk);
  bit some_signal;
endinterface



class some_component extends uvm_component;
  virtual some_interface intf;
  event some_event;

  protected event stop_req;


  virtual task run_phase(uvm_phase phase);
    forever begin
      fork
        trigger_events();
        @(stop_req);
      join_any
      disable fork;
      uvm_wait_for_nba_region();
    end
  endtask


  virtual function void request_stop();
    -> stop_req;
  endfunction


  protected task trigger_events();
    forever begin
      @(intf.clk iff intf.some_signal);
      -> some_event;
    end
  endtask


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass



`include "svunit_uvm_mock_pkg.sv"


module some_component_unit_test;
  import svunit_pkg::svunit_testcase;
  `include "svunit_defines.svh"

  import svunit_uvm_mock_pkg::*;
  `include "vgm_svunit_utils_macros.svh"

  string name = "some_component_ut";
  svunit_testcase svunit_ut;


  some_component component;


  bit clk;
  always #1 clk = ~clk;

  default clocking @(posedge clk);
  endclocking

  some_interface intf(clk);


  function void build();
    svunit_ut = new(name);

    component = new({name, "__component"}, null);
    component.intf = intf;
  endfunction


  task setup();
    svunit_ut.setup();

    reset_signals();
    svunit_activate_uvm_component(component);
    svunit_uvm_test_start();
  endtask


  task teardown();
    svunit_ut.teardown();

    component.request_stop();
    svunit_uvm_test_finish();
    svunit_deactivate_uvm_component(component);
  endtask



  `SVUNIT_TESTS_BEGIN

    `SVTEST(some_event__some_signal_low__not_triggered)
      intf.some_signal <= 0;
      ##1;
      `FAIL_IF_TRIGGERED(component.some_event)
    `SVTEST_END


    `SVTEST(some_event__some_signal_high__triggered)
      intf.some_signal <= 1;
      ##1;
      `FAIL_UNLESS_TRIGGERED(component.some_event)
    `SVTEST_END

  `SVUNIT_TESTS_END


  task reset_signals();
    intf.some_signal <= 0;
    ##1;
  endtask
endmodule
