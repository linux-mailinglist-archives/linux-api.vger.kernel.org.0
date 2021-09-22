Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AC5415019
	for <lists+linux-api@lfdr.de>; Wed, 22 Sep 2021 20:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbhIVSr6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Sep 2021 14:47:58 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.135.51]:37169 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIVSr6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 22 Sep 2021 14:47:58 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Sep 2021 14:47:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1632336388; x=1663872388;
  h=subject:to:cc:references:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=v5kFGHXxXJ0RZ8ntYh31K9vkfTpEhCGFEcTqn2MiuNY=;
  b=FKSEgWvEt3fJKVBjL+90D0+393OqOjvRUQjZEMl9fN+9K4ue0vEWyY4F
   bf9LS+z7AX+HXIEE7UcQu+fN+Gj0ggWxjPoTvV8UN7073H8R4n9YKpgSB
   NFXpwWZ2cweCXlsoLREDt2Rf6CV797Yx1dtWxpIllZ8Zp97+EEd18/Iih
   M=;
IronPort-Data: A9a23:GelqL6sv2p26iAIjwW0qpRr/UOfnVLFfMUV32f8akzHdYApBsoF/q
 tZmKW3QPf+MMGqhe9hyPoq+9UsO7JeByIdmGVdp+HoxEnhAgMeUXt7xwmUcns+xwm8vaGo9s
 q3yv/GZdJhcoln0+E/1atANilEjifrXLlbE5Wqt1hlZHWeIcg944f5Ys7N/0tMAbeSRWVvX4
 Iuj+ZeHYzdJ5hYtWo4qw/PSwP9QlKmq0N8olgRWiSdj5QK2e9E9VfrzFInpR5fKatA88t2SG
 44v+IqEElbxpH/BPD8HfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1he66RFxlkvgoo
 Oihu6BcRi8MZ5T+wtsNeiNYSRhxEp1Kwb7nOkiG5Jn7I03uKxMAwt1lC0cwPYhApqB8BmdI+
 PcEbi0SZwyOneaxx/SwQ4GAhOx6dpitbdxZ4Ckwi22CZRolacmrr6Hi+dNV2DYrgs1mAOnXe
 8cDbT1oKh/JC/FKEg5HUchkxLzx7pX5WxlptQPEvPYZ30zs9FQpwLXDGvbvQNPfEK25mW7d/
 Aoq5V/RABgcMty3xj2C/XahwOTImEvTUZwbG7y+3vFth1KXyyoYDxh+fUO8uvqRhUm5VNZSb
 UcT/0IGp7M/+0WvSvHyWBq3pHPCtRkZM/JIEfES5waKxa7ZpQ2eAwAsSj9Hdcxjvdc3bSIl2
 0XPnN7zAzFr9rqPRhq18raSsCP3OiUPK2IGTTELQBFD4NT5pow3yBXVQb5LDKGxnvXxGDft3
 yqNqikuwbke5eYO1qO0+njdjj6sr4SPRQkwji3PU36o9BFRZYirfYWk5FHXq/FaI+6xVl6av
 1AcnNOdquEJZaxhjwSGR+MLEbq1oeuaOSHRm1poGN8q/lxB5kKeQGyZ2xkmTG8BDyrOUWa5C
 KMPkWu9PKNuAUY=
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2021 14:39:05 -0400
Received: from [10.42.0.123] (10.32.225.138) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 22
 Sep 2021 14:39:04 -0400
Subject: Re: [PATCH 5/5 v0.6] sched/umcg: add
 Documentation/userspace-api/umcg.txt
To:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>
CC:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>
References: <20210917180323.278250-1-posk@google.com>
 <20210917180323.278250-6-posk@google.com>
In-Reply-To: <20210917180323.278250-6-posk@google.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <12eb2300-4a78-9e93-30a3-8e2ddba4693f@uwaterloo.ca>
Date:   Wed, 22 Sep 2021 14:39:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.32.225.138]
X-ClientProxiedBy: connhm03.connect.uwaterloo.ca (172.16.137.67) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2021-09-17 2:03 p.m., Peter Oskolkov wrote:
 > [...]
 > +SYS_UMCG_WAIT()
 > +
 > +int sys_umcg_wait(uint32_t flags, uint64_t abs_timeout) operates on
 > +registered UMCG servers and workers: struct umcg_task *self provided to
 > +sys_umcg_ctl() when registering the current task is consulted in 
addition
 > +to flags and abs_timeout parameters.
 > +
 > +The function can be used to perform one of the three operations:
 > +
 > +* wait: if self->next_tid is zero, sys_umcg_wait() puts the current
 > +  server or worker to sleep;

I believe this description is misleading but I might be wrong.
 From the example
     * worker to server context switch (worker "yields"):
       S:IDLE+W:RUNNING => +S:RUNNING+W:IDLE

It seems to me that when a worker goes from running to idle, it should
*not* set the next_tid to 0, it should preserve the next_tid as-is,
which is expected to point to its current server. This is consistent
with my understanding of the umcg_wait implementation. This operation
is effectively a direct context-switch to the server.

With that said, I'm a little confused by the usage of "yields" in that
example. I would expect workers yielding to behave like kernel threads
calling sched_yield(), i.e., context switch to the server but also be
immediately added to the idle_workers_ptr.

 From my understanding of the umcg_wait call, "worker to server context
switch" does not have analogous behaviour to sched_yield. Am I correct?
If so, I suggest using "park" instead of "yield" in the description
of that example. I believe the naming of wait/wake as park/unpark is
consistent with Java[1] and Rust[2], but I don't know if that naming
is used in contexts closer to the linux kernel.

[1] 
https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/locks/LockSupport.html
[2] https://doc.rust-lang.org/std/thread/fn.park.html


