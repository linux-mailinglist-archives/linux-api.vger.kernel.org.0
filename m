Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EA2218285
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2020 10:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgGHIbc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Jul 2020 04:31:32 -0400
Received: from albireo.enyo.de ([37.24.231.21]:46408 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgGHIbc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 8 Jul 2020 04:31:32 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jt5U7-0004Zt-GV; Wed, 08 Jul 2020 08:31:19 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jt5U7-000757-Ca; Wed, 08 Jul 2020 10:31:19 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
Subject: Re: [RFC PATCH for 5.8 3/4] rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
        <20200706204913.20347-4-mathieu.desnoyers@efficios.com>
        <87fta3zstr.fsf@mid.deneb.enyo.de>
        <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com>
        <874kqjzhkb.fsf@mid.deneb.enyo.de>
        <378862525.1039.1594123580789.JavaMail.zimbra@efficios.com>
        <d6b28b3e-9866-ce6f-659e-2c0dba4cd527@redhat.com>
        <1834900818.710.1594148361942.JavaMail.zimbra@efficios.com>
Date:   Wed, 08 Jul 2020 10:31:19 +0200
In-Reply-To: <1834900818.710.1594148361942.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 7 Jul 2020 14:59:21 -0400
        (EDT)")
Message-ID: <87o8oq2yso.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> Allright, thanks for the insight! I'll drop these patches and focus only
> on the bugfix.

Thanks, much appreciated!
