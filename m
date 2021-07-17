Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F98E3CC06A
	for <lists+linux-api@lfdr.de>; Sat, 17 Jul 2021 02:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhGQBBb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Jul 2021 21:01:31 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.131.47]:33565 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGQBBa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Jul 2021 21:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1626483515; x=1658019515;
  h=to:cc:references:subject:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=7Msst6GRlO4ej0lfburnS3KYsBzgPojoLxzW+XLxWlQ=;
  b=jSo41eg2AXP8gs98G/UiyuaTm2bbs4kR+xo3/29BGmVxF3/jGYiZoPzG
   5UMc+bPuq4jt9VDAguCB1tiI+k16s6Fxa3nla7e3qH0HjtJSokkzbD+ht
   9h4D7mUp568+sD7D/IB5BxwJL4xnfvC+y9QhwSN6GW6hoTCLuOT6hEMGG
   A=;
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2021 20:58:11 -0400
Received: from [10.42.0.123] (10.32.139.159) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Jul 2021 20:58:10 -0400
To:     <posk@posk.io>
CC:     <avagin@google.com>, <bsegall@google.com>, <jannh@google.com>,
        <jnewsome@torproject.org>, <joel@joelfernandes.org>,
        <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>, <pjt@google.com>,
        <posk@google.com>, <tglx@linutronix.de>,
        Peter Buhr <pabuhr@uwaterloo.ca>,
        Martin Karsten <mkarsten@uwaterloo.ca>
References: <20210716184719.269033-4-posk@google.com>
Subject: Re: [RFC PATCH 3/4 v0.3] sched/umcg: RFC: add userspace sll helpers
In-Reply-To: <20210716184719.269033-4-posk@google.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <e84df89d-5c5b-c3fd-42f6-2240b8a110a1@uwaterloo.ca>
Date:   Fri, 16 Jul 2021 20:58:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.32.139.159]
X-ClientProxiedBy: connhm04.connect.uwaterloo.ca (172.16.137.68) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

 > The helpers below can work with userspace single-linked lists 
concurrently
 > without indefinitely spinning in the kernel. Specifically:
 >
 > push (add to the head of the list):
 >
 >   step = 0
 >   while (++step < N)
 >      old = *head
 >      *next = old
 >      cmp_xchng(head, &old, next)
 >
 > pop (remove the first element from the list):
 >     mark the node as deleted by flipping its lowest bit without
 >     actually removing the node from the list:
 >
 >   curr = *head
 >   step = 0
 >
 >   while (curr && ++step < N)
 >
 >     next = *curr
 >     if (next & 1)
 >         curr = next & ~1
 >         continue
 >
 >     if (cmp_xchng(curr, next, next | 1))
 >         return curr
 >     else
 >         curr = next & ~1
 >
 > It is the userspace's responsibility to actually remove the
 > nodes marked as deleted from the list.

I believe the subsystem called Nemesis introduced a MCS-based queue that 
could
be useful here. The original paper is https://doi.org/10.1109/CCGRID.2006.31

You can also look at this repo for an implementation of the queue.
https://git.uwaterloo.ca/mkarsten/libfibre/-/blob/master/src/runtime/LockFreeQueues.h

While it uses 2 pointers, I believe it would fit well for idle_workers_ptr
since the push operation is wait-free, which avoids problems for the kernel.
The pop operation requires a lock in userspace *if* multiple servers can
consume from the same queue, but I don't believe it's a requirement in 
general.

