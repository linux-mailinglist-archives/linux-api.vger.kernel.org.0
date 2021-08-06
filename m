Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CB33E2E98
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 18:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhHFQwJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 12:52:09 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.131.47]:48512 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhHFQwJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 12:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1628268713; x=1659804713;
  h=to:cc:references:subject:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=+Yk7jS1kCh4T4Z0jmOABLJsPkhmyd3gwrABdX6XLTLk=;
  b=640keLWxsk9jFlZbDaL71I1fjJL6NUdYe4xIBBc8Vi8vIKvSmbd20GF+
   Z5VZ+vtacIviOjK+8/G0r0Yp/KG43+y25qhkturbY6v080AJJWEjaOIfx
   1/4MeaJaTShT4dZI0dU9AeHCJaz30MWlT5EPmq/Zvv0ORmWzCCmrU3X+M
   Y=;
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2021 12:51:50 -0400
Received: from [10.42.0.123] (10.32.240.218) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 6 Aug
 2021 12:51:49 -0400
To:     <posk@google.com>
CC:     <avagin@google.com>, <bsegall@google.com>, <jannh@google.com>,
        <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <pabuhr@uwaterloo.ca>, <peterz@infradead.org>,
        <pjt@google.com>, <posk@posk.io>, <tdelisle@uwaterloo.ca>,
        <tglx@linutronix.de>
References: <CAPNVh5fjcJHKJOuQP+UebpYf+GBMDkj5me1c=EzS9cpDSTbzfA@mail.gmail.com>
Subject: Re: [PATCH 3/4 v0.4] sched/umcg: add
 Documentation/userspace-api/umcg.rst
In-Reply-To: <CAPNVh5fjcJHKJOuQP+UebpYf+GBMDkj5me1c=EzS9cpDSTbzfA@mail.gmail.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <1dc64d75-da9b-272a-a9ab-7d2ae7a85764@uwaterloo.ca>
Date:   Fri, 6 Aug 2021 12:51:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.32.240.218]
X-ClientProxiedBy: connhm03.connect.uwaterloo.ca (172.16.137.67) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

  > All _umcg_ state changes here happen in the userspace before
  > sys_umcg_wait() is called. So:
  >
  > W1: cmpxchg W1:RUNNING => W1:IDLE
  >  - if OK, call sys_umcg_wait()
  >  - if failed, do something else (notes below)
  >
  > W2: cmpxchg W1:IDLE => W1:RUNNING
  >  - if OK, lock itself, set W2:next_tid to W1, call sys_umcg_wait()
  > (will not block nor spin), restore next_tid and state/unlock upon
  > syscall return
  >  - if failed, do something else

I am talking about the case where both cmpxchg() succeed and W2 sets
*both* UMCG_WAIT_WAKE_ONLY and UMCG_WAIT_WF_CURRENT_CPU.  More
specifically, if things are ordered like so: (ideally use monospace font)

          - w1 -                     - w2 -

w1:RUNNING => w1:IDLE|L   |
S:IDLE => S:RUNNING       |
sys_umcg_wait():          |
      set ~UMCG_TF_LOCKED  |
                           |   w1:IDLE => w1:RUNNING|L
                           |   w2:RUNNING => w2:IDLE|L
                           |   w2:next_tid := W1.tid
                           |   w1:RUNNING|L => w1:RUNNING
                           |   sys_umcg_wait():
                           |       set ~UMCG_TF_LOCKED
                           |       do_context_switch()
      idle_loop()          |

What does ttwu() do with w1 if it has not reached idle_loop yet?

I am not familiar with the details of kernel context-switching, but in
user-level threading, more specifically Cforall, this would be a problem.
Between the call to do_context_switch() and and idle_loop(), there is a
window where 2 CPUs run the same thread at the same time. One thread is
performing the front side of the context switch and the other threads
wakes up on the backside of the context switch. This behaviour invariably
corrupts the program stack of that thread. Again, I do not know if that
applies here. I am not exactly sure how the program stack is handled when
inside a system call.

