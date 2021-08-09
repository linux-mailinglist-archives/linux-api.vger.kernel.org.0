Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0383E474F
	for <lists+linux-api@lfdr.de>; Mon,  9 Aug 2021 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhHIOQX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Aug 2021 10:16:23 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.135.51]:25938 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhHIOQX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Aug 2021 10:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1628518562; x=1660054562;
  h=to:cc:references:subject:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=4x9sjHeD5a8VARosMaEyBrjLPXQdoIE6Gb2m/Ff3xKs=;
  b=pm8lt8eAk1wNnmMKDg6tTD4jh3xzjbBDgGkpfEZQqsHZMEXdnh7uMGJ3
   NgB951MUPtAPoy2RX4S8+lmMfW4RTImEb4oL89kgrhN/8grlulDalyVV2
   SF5Qtw3U48fjmEqLBdfph719YVNDz+oXXOOjBt31wEEe64kjdok1a7PSM
   4=;
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2021 10:16:00 -0400
Received: from [10.42.0.123] (10.32.240.218) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 9 Aug
 2021 10:15:59 -0400
To:     <posk@google.com>
CC:     <avagin@google.com>, <bsegall@google.com>, <jannh@google.com>,
        <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <pabuhr@uwaterloo.ca>, <peterz@infradead.org>,
        <pjt@google.com>, <posk@posk.io>, <tdelisle@uwaterloo.ca>,
        <tglx@linutronix.de>
References: <CAPNVh5cQG8WjRryYXhrApNmV-7ybJ7ePpjXqtS6RUdguXO4e=A@mail.gmail.com>
Subject: Re: [PATCH 3/4 v0.4] sched/umcg: add
 Documentation/userspace-api/umcg.rst
In-Reply-To: <CAPNVh5cQG8WjRryYXhrApNmV-7ybJ7ePpjXqtS6RUdguXO4e=A@mail.gmail.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <b6308f50-8e0a-c0bc-d25a-d8f515e5183d@uwaterloo.ca>
Date:   Mon, 9 Aug 2021 10:15:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.32.240.218]
X-ClientProxiedBy: connhm01.connect.uwaterloo.ca (172.16.137.65) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

 > This is a wake, not a context switch, right?

I followed the "worker to worker context switch" procedure in the
documentation.

 > I'm not sure why you are concerned with context switching here. And even
 > if it were a context switch, the kernel manages thread stacks properly,
 > there's nothing to worry about.

The reason I'm interested in this particular operation is because the
outcome is decided by an invisible race (between W1 and W2) in the
kernel. W2 might context-switch to W1 and it might not. Note I don't mean
race in the problematic sense, just that there are two possible outcomes
that are decided by relative speed. I'm wondering how many outcomes the
users needs to program for and if they may have to back-track anything.

For example, if W2 wants to "yield to", it must enqueue itself in the
user scheduler before the system call. But if the system call doesn't
context-switch and W2 keeps running, it may need to undo the enqueue.

I agree the comment about the stack was a tangent and I expected the
kernel to handle it. But, I believe, how the kernel handles this case
affects the number of outcomes for this scenario.

 > If both cmpxchg() succeeded, but W1 was never put to sleep, ttwu()
 > will do nothing and W1 will continue running on its initial CPU, while
 > W2 will continue running on its own CPU. WF_CURRENT_CPU is an advisory
 > flag, and in this situation it will not do anything.

This does not sound right to me. If ttwu does nothing, W1 and W2 keep
running. Who sets W2's state back to RUNNING?

Is W2 responsible for doing that? It's not "the party initiating
the state transition" in this case.

Since there is no way for W2 to tell if it did context-switch to W1, does
that mean that W2 should always cmpxchg() its state to RUNNING after a
sys_umcg_wait()?

