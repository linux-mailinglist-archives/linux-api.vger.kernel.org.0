Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB233E0880
	for <lists+linux-api@lfdr.de>; Wed,  4 Aug 2021 21:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhHDTNP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 15:13:15 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.131.47]:50265 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhHDTNP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Aug 2021 15:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1628104382; x=1659640382;
  h=to:cc:references:subject:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=jhirTOgGUhkgYbiPKAgrVluoIZkjP7rovxdkpI9Ou24=;
  b=kCPQPk9Yqf/w6fNB8UoceH4qVo+sq96+de7FqeJjZJQsCc/8nRzzE2xG
   ylwptBJeqPzA5rcjqVX7m6NwotK0uFJ6kw/3wzX/ny/aJ32UeM9ym4LN8
   xq2xc4/3OIT7Ric7p8J4SlYwEAmjMgvfbW9bpwsCQxso3d1tPYuCkk2FH
   0=;
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Aug 2021 15:12:59 -0400
Received: from [10.42.0.123] (10.32.139.159) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 4 Aug
 2021 15:12:58 -0400
To:     <posk@posk.io>
CC:     <avagin@google.com>, <bsegall@google.com>, <jannh@google.com>,
        <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>, <pjt@google.com>,
        <posk@google.com>, <tdelisle@uwaterloo.ca>, <tglx@linutronix.de>,
        Peter Buhr <pabuhr@uwaterloo.ca>
References: <20210801200617.623745-4-posk@google.com>
Subject: Re: [PATCH 3/4 v0.4] sched/umcg: add
 Documentation/userspace-api/umcg.rst
In-Reply-To: <20210801200617.623745-4-posk@google.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <605a9d20-8fe4-ec9a-97b4-bc6db38da62f@uwaterloo.ca>
Date:   Wed, 4 Aug 2021 15:12:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.32.139.159]
X-ClientProxiedBy: connhm02.connect.uwaterloo.ca (172.16.137.66) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

These state transition descriptions are very helpful, but what is not
clear is the details of these transitions when there are concurrent
wake/waits. I do not know enough about the kernel code to be able to
read the implementation and answer my own questions.

For example, imagine two worker threads W1 and W2. W1 adds itself to a
concurrent list and calls umcg_wait(next_tid = 0). W2 pops from the list
and calls umcg_wait(UMCG_WAIT_WAKE_ONLY | UMCG_WAIT_WF_CURRENT_CPU) on the
popped worker, W1 in this example.

If W1 calls umcg_wait first, W2 context-switches to W1 and W2's state
changes to IDLE. My understanding is that wake detection/block does not
apply to this case.

If W2 calls umcg_wait first, what happens? I can imagine two different
behaviour in this case:

1. W2 waits for W1 to call umcg_wait, by spinning or blocking, and then
    execution proceed like the first ordering.

2. W2 sets W1's state to RUNNING. When W1 eventually calls umcg_wait, it
    simply notices the state change and returns without context-switching.
    In this case, W1 is not migrated to W2's CPU.

Behaviour 1 makes me uncomfortable since it means umcg_wait must wait for
cooperation that potentially never comes.

But in Behaviour 2, the state of W2 after both calls to umcg_wait is not
clear to me, either. I could imagine that W2 is set to IDLE, but since W1
is not migrated, W2 could also simply be left RUNNING.

Which behaviour is correct and in what state does W2 end up?

Thierry

