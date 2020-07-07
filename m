Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF1C216F6D
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgGGOy7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 10:54:59 -0400
Received: from albireo.enyo.de ([37.24.231.21]:59320 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgGGOy7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 Jul 2020 10:54:59 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jsozn-0004vt-47; Tue, 07 Jul 2020 14:54:55 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jsozn-00064o-0d; Tue, 07 Jul 2020 16:54:55 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH for 5.8 0/4] rseq cpu_id ABI fix
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
Date:   Tue, 07 Jul 2020 16:54:55 +0200
In-Reply-To: <20200706204913.20347-1-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Mon, 6 Jul 2020 16:49:09 -0400")
Message-ID: <87tuyjxtmo.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I would like to point out that the subject is misleading: This is not
an ABI change.  It fixes the contents of the __rseq_abi TLS variable
(as glibc calls it), but that's it.

(Sorry, I should have mentioned this earlier.)
