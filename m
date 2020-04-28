Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD31BBDB0
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2020 14:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgD1Mfg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Apr 2020 08:35:36 -0400
Received: from albireo.enyo.de ([37.24.231.21]:48354 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgD1Mff (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 28 Apr 2020 08:35:35 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jTPSR-0001tQ-I1; Tue, 28 Apr 2020 12:35:27 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jTPSR-0008JX-CE; Tue, 28 Apr 2020 14:35:27 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        carlos <carlos@redhat.com>, Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C startup and thread creation (v17)
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com>
        <20200326155633.18236-6-mathieu.desnoyers@efficios.com>
        <87ees9z417.fsf@mid.deneb.enyo.de>
        <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com>
        <87zhawvphv.fsf@mid.deneb.enyo.de>
        <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com>
        <87ftcnrf7d.fsf@mid.deneb.enyo.de>
        <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com>
Date:   Tue, 28 Apr 2020 14:35:27 +0200
In-Reply-To: <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 28 Apr 2020 08:33:13 -0400
        (EDT)")
Message-ID: <878sifrdo0.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> One issue I'm currently facing when running "make check": because
> nptl/tst-rseq-nptl.c uses pthread_cancel(), I run into an Abort
> with:
>
> libgcc_s.so.1 must be installed for pthread_cancel to work
> Didn't expect signal from child: got `Aborted'

This is really unusual.  Is the affected test statically linked?
