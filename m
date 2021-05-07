Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F837661D
	for <lists+linux-api@lfdr.de>; Fri,  7 May 2021 15:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbhEGN1I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 7 May 2021 09:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhEGN1I (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 7 May 2021 09:27:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A9D61042;
        Fri,  7 May 2021 13:26:06 +0000 (UTC)
Date:   Fri, 7 May 2021 09:26:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Herton Krzesinski <hkrzesin@redhat.com>
Subject: Re: [PATCH 7/7 v2] tracing: Do not create tracefs files if tracefs
 lockdown is in effect
Message-ID: <20210507092604.31d2491d@gandalf.local.home>
In-Reply-To: <CAFqZXNs4eRC6kjFRe6CdwA-sng-w6bcJZf5io+hoLKwM98TVSA@mail.gmail.com>
References: <20191012005747.210722465@goodmis.org>
        <20191012005921.580293464@goodmis.org>
        <CAFqZXNs4eRC6kjFRe6CdwA-sng-w6bcJZf5io+hoLKwM98TVSA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 13 Apr 2021 10:13:04 +0200
Ondrej Mosnacek <omosnace@redhat.com> wrote:

> Thoughts?

I never enable the lockdown feature for tracefs, so I'll leave it up to the
other people that do (and that care about this code) to answer.

-- Steve
