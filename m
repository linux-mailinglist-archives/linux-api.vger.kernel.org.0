Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FB774D01
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 13:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfGYLZL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 07:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49411 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfGYLZL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 25 Jul 2019 07:25:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6F122F8BD7;
        Thu, 25 Jul 2019 11:25:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id A47D819D71;
        Thu, 25 Jul 2019 11:25:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Jul 2019 13:25:10 +0200 (CEST)
Date:   Thu, 25 Jul 2019 13:25:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
Message-ID: <20190725112503.GG4707@redhat.com>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-5-christian@brauner.io>
 <20190725103543.GF4707@redhat.com>
 <20190725104006.7myahvjtnbcgu3in@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725104006.7myahvjtnbcgu3in@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 25 Jul 2019 11:25:10 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 07/25, Christian Brauner wrote:
>
> On Thu, Jul 25, 2019 at 12:35:44PM +0200, Oleg Nesterov wrote:
> >
> > I have to admit this feature looks a bit exotic to me...
>
> It might look like it from the kernels perspective but from the feedback
> on this when presenting on this userspace has real usecases for this.

OK...

but then perhaps we can make PF_WAIT_PID more flexible.

Say, we can add the new WXXX wait option and change eligible_child()

	if ((p->flags & PF_WAIT_PID) && (wo->options & WXXX))
		return 0;

this way the parent can tell waitid() whether the PF_WAIT_PID tasks should
be filtered or not.

And if we do this we can even add PR_SET_WAIT_PID/PR_CLR_WAIT_PID instead
of the new CLONE_ flag.

Oleg.

