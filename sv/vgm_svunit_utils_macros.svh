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

`endif
