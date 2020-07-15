Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4AF220505
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 08:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgGOGdj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 02:33:39 -0400
Received: from albireo.enyo.de ([37.24.231.21]:44584 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgGOGdj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 Jul 2020 02:33:39 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jvayt-0000Pz-3w; Wed, 15 Jul 2020 06:33:27 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jvawb-00039g-W6; Wed, 15 Jul 2020 08:31:05 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Chris Kennelly <ckennelly@google.com>
Cc:     Peter Oskolkov <posk@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
        <20200714030348.6214-3-mathieu.desnoyers@efficios.com>
        <CAFTs51UHaUqaKj5bEj0vQtEZrww9gnrqb-kGVk7DAgQJPBAR+w@mail.gmail.com>
        <775688146.12145.1594748580461.JavaMail.zimbra@efficios.com>
        <CAPNVh5fiCCJpyeLj_ciWzFrO4fasVXZNhpfKXJhJWJirXdJOjQ@mail.gmail.com>
        <CAEE+ybmt4BredezuTPdh-vf=FkKtu0yAhWuf+0daUe89AnbmPg@mail.gmail.com>
Date:   Wed, 15 Jul 2020 08:31:05 +0200
In-Reply-To: <CAEE+ybmt4BredezuTPdh-vf=FkKtu0yAhWuf+0daUe89AnbmPg@mail.gmail.com>
        (Chris Kennelly's message of "Tue, 14 Jul 2020 22:34:38 -0400")
Message-ID: <87k0z5xpau.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Chris Kennelly:

> When glibc provides registration, is the anticipated use case that a
> library would unregister and reregister each thread to "upgrade" it to
> the most modern version of interface it knows about provided by the
> kernel?

Absolutely not, that is likely to break other consumers because an
expected rseq area becomes dormant instead.

> There, I could assume an all-or-nothing registration of the new
> feature--limited only by kernel availability for thread
> homogeneity--but inconsistencies across early adopter libraries would
> mean each thread would have to examine its own TLS to determine if a
> feature were available.

Exactly.  Certain uses of seccomp can also have this effect,
presenting a non-homogeneous view.
