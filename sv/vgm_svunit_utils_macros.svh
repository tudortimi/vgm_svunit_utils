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


`ifndef VGM_SVUNIT_UTILS_MACROS
`define VGM_SVUNIT_UTILS_MACROS


// Fails if the given SVA property holds.
//
// Note: Evaluating this macro will advance the simulation time.

`define FAIL_IF_PROP(prop) \
  expect (prop) \
    `FAIL_IF(1)


// Fails if the given SVA property doesn't hold.
//
// Note: Evaluating this macro will advance the simulation time.

`define FAIL_UNLESS_PROP(prop) \
  expect (prop) \
  else \
    `FAIL_IF(1)


// Fails if the given event is triggered in the current time step.
//
// Note: Evaluation is stopped once the specified number of NBAs is reached.

`define FAIL_IF_TRIGGERED(ev, num_nbas = 1) \
  fork \
    repeat (num_nbas) begin \
      static int nba, next_nba; \
      next_nba++; \
      nba <= next_nba; \
      @(nba); \
    end \
    \
    begin \
      wait (sequencer.put_response_called.triggered); \
      `FAIL_IF_LOG(1, `"'ev' triggered`") \
    end \
  join_any \
  disable fork;


// Fails if the given event isn't triggered in the current time step.

`define FAIL_UNLESS_TRIGGERED(ev) \
  fork \
    wait (ev.triggered); \
    \
    begin \
      #1; \
      `FAIL_IF_LOG(1, `"'ev' not triggered`") \
    end \
  join_any \
  disable fork;


`endif
