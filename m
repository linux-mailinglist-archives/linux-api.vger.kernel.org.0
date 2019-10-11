Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E228FD4A0F
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 23:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfJKVq1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 17:46:27 -0400
Received: from albireo.enyo.de ([37.24.231.21]:44962 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbfJKVq1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 17:46:27 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iJ2js-0005ne-Ji; Fri, 11 Oct 2019 21:46:20 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iJ2js-0002M3-Fz; Fri, 11 Oct 2019 23:46:20 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
References: <20191011135458.7399da44@gandalf.local.home>
        <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
        <20191011143610.21bcd9c0@gandalf.local.home>
Date:   Fri, 11 Oct 2019 23:46:20 +0200
In-Reply-To: <20191011143610.21bcd9c0@gandalf.local.home> (Steven Rostedt's
        message of "Fri, 11 Oct 2019 14:36:10 -0400")
Message-ID: <87tv8f9cr7.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Steven Rostedt:

> Once locked down is set, can it ever be undone without rebooting?

I think this is the original intent with such patches, yes.  But then
reality interferes and people add some escape hatch, so that it's
possible again to load arbitrary kernel modules.  And for servers, you
can't have a meaningful physical presence check, so you end up with a
lot of complexity for something that offers absolutely zero gains in
security.

The other practical issue is that general-purpose Linux distributions
cannot prevent kernel downgrades, so even if there's a
cryptographically signed chain from the firmware to the kernel, you
can boot last year's kernel, use a root-to-ring-0 exploit to disable
its particular implementation of lockdown, and then kexec the real
kernel with lockdown disabled.

I'm sure that kernel lockdown has applications somewhere, but for
general-purpose distributions (who usually want to support third-party
kernel modules), it's an endless source of problems that wouldn't
exist without it.
