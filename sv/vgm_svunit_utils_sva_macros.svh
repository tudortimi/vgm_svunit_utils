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


`ifndef VGM_SVUNIT_UTILS_SVA_MACROS
`define VGM_SVUNIT_UTILS_SVA_MACROS



`define FAIL_IF_PROP_PASS(prop) \
  expect (prop) \
    `FAIL_IF(1)


`define FAIL_IF_PROP_FAIL(prop) \
  expect (prop) \
  else \
    `FAIL_IF(1)


`define FAIL_IF_PROP_VAC(prop) \
  begin \
    vgm_svunit_utils_sva::pass_called = 0; \
    vgm_svunit_utils_sva::fail_called = 0; \
    \
    expect (prop) \
      vgm_svunit_utils_sva::pass_called = 1; \
    else \
      vgm_svunit_utils_sva::fail_called = 1; \
    \
    if (!vgm_svunit_utils_sva::pass_called && \
        !vgm_svunit_utils_sva::fail_called) \
      `FAIL_IF(1) \
  end


`define FAIL_UNLESS_PROP_PASS(prop) \
  begin \
    vgm_svunit_utils_sva::pass_called = 0; \
    \
    expect (prop) \
      vgm_svunit_utils_sva::pass_called = 1; \
    \
    if (!vgm_svunit_utils_sva::pass_called) \
      `FAIL_IF(1) \
  end


`define FAIL_UNLESS_PROP_FAIL(prop) \
  begin \
    vgm_svunit_utils_sva::fail_called = 0; \
    \
    expect (prop) \
    else \
      vgm_svunit_utils_sva::fail_called = 1; \
    \
    if (!vgm_svunit_utils_sva::fail_called) \
      `FAIL_IF(1) \
  end


`define FAIL_UNLESS_PROP_VAC(prop) \
  begin \
    vgm_svunit_utils_sva::pass_called = 0; \
    vgm_svunit_utils_sva::fail_called = 0; \
    \
    expect (prop) \
      vgm_svunit_utils_sva::pass_called = 1; \
    else \
      vgm_svunit_utils_sva::fail_called = 1; \
    \
    if (vgm_svunit_utils_sva::pass_called || \
        vgm_svunit_utils_sva::fail_called) \
      `FAIL_IF(1) \
  end


// Fails if the given SVA property holds (regardless of vacuity).
`define FAIL_IF_PROP(prop) \
  `FAIL_UNLESS_PROP_FAIL(prop)


// Fails if the given SVA property doesn't hold (regardless of vacuity).
`define FAIL_UNLESS_PROP(prop) \
  `FAIL_IF_PROP_FAIL(prop)


// Fails if the given SVA sequence matches.
`define FAIL_IF_SEQ(seq) \
  `FAIL_UNLESS_PROP_FAIL(seq ##0 1)


// Fails if the given SVA sequence doesn't match.
`define FAIL_UNLESS_SEQ(seq) \
  `FAIL_UNLESS_PROP_PASS(seq ##0 1)


`endif
