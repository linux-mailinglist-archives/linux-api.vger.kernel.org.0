Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235681C4344
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2020 19:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgEDRuW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 4 May 2020 13:50:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46040 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgEDRuW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 4 May 2020 13:50:22 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jVfEQ-0001IG-BA; Mon, 04 May 2020 17:50:18 +0000
Date:   Mon, 4 May 2020 19:50:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v3 2/3] nsproxy: attach to namespaces via pidfds
Message-ID: <20200504175017.ry2qhoeq3q45k2my@wittgenstein>
References: <20200504144141.3605533-1-christian.brauner@ubuntu.com>
 <20200504144141.3605533-3-christian.brauner@ubuntu.com>
 <87h7wvoefw.fsf@x220.int.ebiederm.org>
 <20200504163907.jjgqe7qnnjpw4uwo@wittgenstein>
 <87ftcfmxt1.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftcfmxt1.fsf@x220.int.ebiederm.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 04, 2020 at 12:09:46PM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > On Mon, May 04, 2020 at 11:25:07AM -0500, Eric W. Biederman wrote:
> >> 
> >> I am not thrilled about treating nstype as a flags fields when it is not
> >> currently.  It was my hope when I designed the interface that not
> >> treating nstype as a flags field would save us from the problem of bits
> >> running out.
> >
> > Hm, I researched the setns() syscall history before that and I didn't
> > see that reasoning anywhere. The "nstype" arg was originally advertised
> > on the list as "having a flags field is useful in general".
> 
> Take a look at the code.  At the end of the day nstype is not treated at
> all like a flags field.

Oh, I wasn't trying to dispute that. I was just pointing at the history
where using it as a flags field in the future wasn't in principle out of
the question.

> 
> It isn't a very important point.  And it was certainly easier to use
> the existing bits for essentially their existing meanings.  But it was
> certainly something I was thinking at the time.
> 
> I think I left it as we can see either way, depending on how things
> evolve.
> 
> I can imagine a use for a nstype being a single namespace from a pidfd.
> Do you have any actual usecases for setting some but not all of the
> namespaces from a pidfd?  If we don't have a compelling reason
> I would like to kick that can down the road a ways farther.

Yeah, I think so. We already have a few use-cases. The syscall
interception stuff selectively attaches to subsets of namespaces
depending on what namespaces are needed to emulate a given syscall. And
the exec logic let's users select what namespaces to attach to. It's
common to setns to a subset of namespaces to perform operations with
privilege and then later attach others (often the userns).

> 
> I am also remembering that that setns freed the low 8 bits.  Which gave
> some freedom beyond clone.
> 
> >> That aside.  It would be very good if the default version of setting
> >> everything from a pidfd would set the root directory from the process it
> >> is copying everything else from.
> >
> > I'm not sure I follow completely. If you specify CLONE_NEWNS then we do
> > set the root directory with set_fs_root() in commit_nsset(). Or are you
> > saying we should always do that independent of whether or not
> > CLONE_NEWNS is specified? And if so could you explain why we'd want
> > that? I'm sure I'm missing something!
> 
> I am suggesting that when we do:
> 
> "setns(pidfd, 0)" or "setns(pidfd, SETNS_PIDFD)"
> 
> That the result is not just the namespaces changing but also the root
> directory changing to the pids root directory.  Something where the
> whole is greater than the parts.

Ok, I can see that being useful. But If we do this, then a new flag
would be quite helpful. (I also think Michael had some reservations
against re-using 0 for something like this.)
But let me suggest moving your phrase from above down to here and
say that we could kick that can down the road for a follow-up extension?

Christian
