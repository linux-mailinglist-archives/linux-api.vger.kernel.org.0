Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F90FD47B4
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfJKSgO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 14:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbfJKSgN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 14:36:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AED3B206CD;
        Fri, 11 Oct 2019 18:36:12 +0000 (UTC)
Date:   Fri, 11 Oct 2019 14:36:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for
 lockdown
Message-ID: <20191011143610.21bcd9c0@gandalf.local.home>
In-Reply-To: <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
References: <20191011135458.7399da44@gandalf.local.home>
        <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 11 Oct 2019 11:20:30 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Willing to do that instead?

Honestly, what you described was my preferred solution ;-)

I just didn't want to upset the lockdown crowd if a new tracefs file
was opened without doing this.

Once locked down is set, can it ever be undone without rebooting? If
not, a lockdown call could also trigger setting tracing_disabled to 1.
Which is much stronger, as that was the code we added to kill tracing
if anything abnormal was detected (and it does a hard shutdown of all
the tracing utilities).

It's set to one on bootup and cleared, after tracing is initialized.
But it is never cleared again. If lockdown can be enabled at bootup, we
could simply not clear it, and we can have something to allow lockdown
to set it as well.

Currently, the only places tracing_disabled gets set is in the self
tests and if the ring buffer gets corrupted.

-- Steve
