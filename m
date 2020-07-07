Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBC721785D
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgGGTzh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 7 Jul 2020 15:55:37 -0400
Received: from albireo.enyo.de ([37.24.231.21]:39930 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbgGGTzh (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 Jul 2020 15:55:37 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jstgh-0003Qy-8z; Tue, 07 Jul 2020 19:55:31 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jstgh-00047U-6A; Tue, 07 Jul 2020 21:55:31 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Carlos O'Donell <carlos@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Date:   Tue, 07 Jul 2020 21:55:31 +0200
In-Reply-To: <d6b28b3e-9866-ce6f-659e-2c0dba4cd527@redhat.com> (Carlos
        O'Donell's message of "Tue, 7 Jul 2020 14:53:41 -0400")
Message-ID: <87zh8bw158.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Carlos O'Donell:

> It's not a great fit IMO. Just let the kernel version be the arbiter of
> correctness.

For manual review, sure.  But checking it programmatically does not
yield good results due to backports.  Even those who use the stable
kernel series sometimes pick up critical fixes beforehand, so it's not
reliable possible for a program to say, “I do not want to run on this
kernel because it has a bad version”.  We had a recent episode of this
with the Go runtime, which tried to do exactly this.
