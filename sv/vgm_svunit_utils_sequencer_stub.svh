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


class sequencer_stub #(type REQ = uvm_sequence_item, type RSP = REQ)
    extends uvm_component;

  typedef sequencer_stub #(REQ, RSP) this_type;


  uvm_seq_item_pull_imp #(REQ, RSP, this_type) seq_item_export;


  extern virtual function void add_item(REQ item);

  extern virtual function bit try_get_rsp(output RSP rsp);
  extern task get_rsp(output RSP rsp);

  extern virtual function void flush();


  int unsigned num_get_next_item_calls;
  int unsigned num_try_next_item_calls;
  int unsigned num_get_calls;
  int unsigned num_peek_calls;

  int unsigned num_item_done_calls;
  int unsigned num_put_calls;
  int unsigned num_put_response_calls;

  int unsigned num_has_do_available_calls;


  event get_next_item_called;
  event try_next_item_called;
  event get_called;
  event peek_called;

  event item_done_called;
  event put_called;
  event put_response_called;

  event has_do_available_called;


  //----------------------------------------------------------------------------
  // Sequencer methods
  //----------------------------------------------------------------------------

  // Requests
  extern virtual task get_next_item(output REQ t);
  extern virtual task try_next_item(output REQ t);
  extern virtual task get(output REQ t);
  extern virtual task peek(output REQ t);

  // Responses
  extern virtual function void item_done(RSP item = null);
  extern virtual task put(RSP t);
  extern virtual function void put_response(RSP t);

  // Sync control
  extern virtual task wait_for_sequences();
  extern virtual function bit has_do_available();


  protected uvm_tlm_fifo #(REQ) reqs;
  protected uvm_tlm_fifo #(RSP) rsps;


  function new(string name, uvm_component parent);
    super.new(name, parent);
    seq_item_export = new("seq_item_export", this);
    reqs = new("reqs", this, 0);
    rsps = new("rsps", this, 0);
  endfunction
endclass



function void sequencer_stub::add_item(REQ item);
  void'(reqs.try_put(item));
endfunction


function bit sequencer_stub::try_get_rsp(output RSP rsp);
  return rsps.try_get(rsp);
endfunction


task sequencer_stub::get_rsp(output RSP rsp);
  rsps.get(rsp);
endtask


function void sequencer_stub::flush();
  reqs.flush();
  rsps.flush();
  num_get_next_item_calls = 0;
  num_try_next_item_calls = 0;
  num_get_calls = 0;
  num_peek_calls = 0;
  num_item_done_calls = 0;
  num_put_calls = 0;
  num_put_response_calls = 0;
  num_has_do_available_calls = 0;
endfunction


task sequencer_stub::get_next_item(output REQ t);
  reqs.peek(t);
  num_get_next_item_calls++;
  -> get_next_item_called;
endtask


task sequencer_stub::try_next_item(output REQ t);
  void'(reqs.try_peek(t));
  num_try_next_item_calls++;
  -> try_next_item_called;
endtask


task sequencer_stub::get(output REQ t);
  reqs.get(t);
  num_get_calls++;
  -> get_called;
endtask


task sequencer_stub::peek(output REQ t);
  reqs.peek(t);
  num_peek_calls++;
  -> peek_called;
endtask


function void sequencer_stub::item_done(RSP item = null);
  REQ t;
  void'(reqs.try_get(t));

  if (item != null)
    void'(rsps.try_put(item));

  num_item_done_calls++;
  -> item_done_called;
endfunction


task sequencer_stub::put(RSP t);
  rsps.put(t);
  num_put_calls++;
  -> put_called;
endtask


function void sequencer_stub::put_response(RSP t);
  void'(rsps.try_put(t));
  num_put_response_calls++;
  -> put_response_called;
endfunction


task sequencer_stub::wait_for_sequences();
  `uvm_fatal("USGERR", "Not supported");
endtask


function bit sequencer_stub::has_do_available();
  num_has_do_available_calls++;
  -> has_do_available_called;
  return !reqs.is_empty();
endfunction
