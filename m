Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0AA3D1770
	for <lists+linux-api@lfdr.de>; Wed, 21 Jul 2021 22:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbhGUTP1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 15:15:27 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.131.47]:56842 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbhGUTP1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 15:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1626897363; x=1658433363;
  h=subject:to:cc:references:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=wByW4kQoNce1t766GDEbqdfp/u97yFN+31QKN2jPBsQ=;
  b=vOHXJI3ZSwXAjw35WMwDVjMUKRFym0aTQFlZYY+xuv5RY2dY2oSoqMde
   PhNOlO+XpEHr1278+4DGlvcZ4w4pv3HgXo/ikLOeREV+z5Pn2OksH4OlZ
   +sLryW5B1bcFM7RXkioSHXrBHQTiOxhwcEyZXOgjyNKsuLO4eBr8lxhUy
   I=;
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jul 2021 15:56:01 -0400
Received: from [10.42.0.123] (10.32.139.159) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 21
 Jul 2021 15:56:00 -0400
Subject: Re: [RFC PATCH 4/4 v0.3] sched/umcg: RFC: implement UMCG syscalls
To:     Peter Oskolkov <posk@posk.io>
CC:     Peter Oskolkov <posk@google.com>, Andrei Vagin <avagin@google.com>,
        Ben Segall <bsegall@google.com>, Jann Horn <jannh@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Buhr <pabuhr@uwaterloo.ca>
References: <20210716184719.269033-5-posk@google.com>
 <2c971806-b8f6-50b9-491f-e1ede4a33579@uwaterloo.ca>
 <CAPNVh5cmhFEWr4bmODkDDFhV=mHLcO0DZJ432GEL=OitzPP80g@mail.gmail.com>
 <c8ea4892-51e5-0dc2-86c6-b705e8a23cde@uwaterloo.ca>
 <CAFTs51XW0H1UJKv0t2tq+5VLfgPMtZmDcxQVUQ5HkgDe38jHpw@mail.gmail.com>
In-Reply-To: <CAFTs51XW0H1UJKv0t2tq+5VLfgPMtZmDcxQVUQ5HkgDe38jHpw@mail.gmail.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <5790661b-869c-68bd-86fa-62f580e84be1@uwaterloo.ca>
Date:   Wed, 21 Jul 2021 15:55:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.32.139.159]
X-ClientProxiedBy: connhm04.connect.uwaterloo.ca (172.16.137.68) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

 > Yes, this is naturally supported in the current patchset on the kernel
 > side, and is supported in libumcg (to be posted, later when the kernel
 > side is settled); internally at Google, some applications use
 > different "groups" of workers/servers per NUMA node.

Good to know. Cforall has the same feature, where we refer to these groups
as "clusters". https://doi.org/10.1002/spe.2925 (Section 7)

 > Please see the attached atomic_stack.h file - I use it in my tests,
 > things seem to be working. Specifically, atomic_stack_gc does the
 > cleanup. For the kernel side of things, see the third patch in this
 > patchset.

I don't believe the atomic_stack_gc function is robust enough to be 
offering
any guarantee. I believe that once a node is unlinked, its next pointer 
should
be reset immediately, e.g., by writing 0xDEADDEADDEADDEAD. Do your tests 
work
if the next pointer is reset immediately on reclaimed nodes?

As far as I can tell, the reclaimed nodes in atomic_stack_gc still contain
valid next fields. I believe there is a race which can lead to the kernel
reading reclaimed nodes. If atomic_stack_gc does not reset the fields, 
this bug
could be hidden in the testing.

An more aggressive test is to put each node in a different page and 
remove read
permissions when the node is reclaimed. I'm not sure this applies when the
kernel is the one reading.


 > To keep the kernel side light and simple. To also protect the kernel
 > from spinning if userspace misbehaves. Basically, the overall approach
 > is to delegate most of the work to the userspace, and keep the bare
 > minimum in the kernel.

I'll try to keep this in mind then.


After some thought, I'll suggest a scheme to significantly reduce 
complexity.
As I understand, the idle_workers_ptr are linked to form one or more
Multi-Producer Single-Consumer queues. If each head is augmented with a 
single
volatile tid-sized word, servers that want to go idle can simply write 
their id
in the word. When the kernel adds something to the idle_workers_ptr 
list, it
simply does an XCHG with 0 or any INVALID_TID. This scheme only supports 
one
server blocking per idle_workers_ptr list. To keep the "kernel side 
light and
simple", you can simply ask that any extra servers must synchronize 
among each
other to pick which server is responsible for wait on behalf of everyone.


